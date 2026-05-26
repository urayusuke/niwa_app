import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:niwa_app/common/constants/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'iap_service.freezed.dart';
part 'iap_service.g.dart';

const _prefKeyPremium = 'is_premium';

@riverpod
IapService iapService(Ref ref) => IapService(InAppPurchase.instance);

class IapService {
  IapService(this._iap);
  final InAppPurchase _iap;

  SharedPreferences? _prefs;

  Future<bool> loadPremiumStatus() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(_prefKeyPremium) ?? false;
  }

  Future<void> setPremium() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_prefKeyPremium, true);
  }

  /// 購入フローを開始する。商品情報の取得から購入まで行う。
  /// 購入結果は購入ストリームで受け取るため、このメソッドは購入開始のみ担う。
  Future<void> purchase() async {
    final available = await _iap.isAvailable();
    if (!available) {
      throw Exception('ストアに接続できませんでした');
    }

    final response = await _iap.queryProductDetails({AppConfig.removeAdsProductId});
    if (response.productDetails.isEmpty) {
      throw Exception('商品情報を取得できませんでした');
    }

    final purchaseParam = PurchaseParam(
      productDetails: response.productDetails.first,
    );
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// 購入を復元する
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// 購入完了を処理し、ストアに完了を通知する
  Future<bool> deliverAndComplete(PurchaseDetails purchase) async {
    if (purchase.productID != AppConfig.removeAdsProductId) return false;

    final isValid = purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored;
    if (!isValid) return false;

    await setPremium();

    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
    return true;
  }
}

// ---- State ----

@freezed
abstract class IapState with _$IapState {
  const factory IapState({
    @Default(false) bool isPremium,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _IapState;
}

// ---- Notifier ----

@riverpod
class IapNotifier extends _$IapNotifier {
  StreamSubscription<List<PurchaseDetails>>? _sub;

  @override
  IapState build() {
    _init();
    ref.onDispose(() => _sub?.cancel());
    return const IapState();
  }

  Future<void> _init() async {
    final service = ref.read(iapServiceProvider);

    // ローカルの購入済み状態を反映
    final isPremium = await service.loadPremiumStatus();
    state = state.copyWith(isPremium: isPremium);

    // 購入ストリームを購読
    _sub = InAppPurchase.instance.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (Object e) {
        debugPrint('[IAP] stream error: $e');
        state = state.copyWith(errorMessage: e.toString(), isLoading: false);
      },
    );
  }

  Future<void> _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    final service = ref.read(iapServiceProvider);
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.error) {
        debugPrint('[IAP] purchase error: ${purchase.error}');
        state = state.copyWith(
          isLoading: false,
          errorMessage: purchase.error?.message,
        );
        continue;
      }
      if (purchase.status == PurchaseStatus.canceled) {
        state = state.copyWith(isLoading: false);
        continue;
      }
      final delivered = await service.deliverAndComplete(purchase);
      if (delivered) {
        state = state.copyWith(isPremium: true, isLoading: false, errorMessage: null);
      }
    }
  }

  Future<void> purchase() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(iapServiceProvider).purchase();
    } catch (e) {
      debugPrint('[IAP] purchase: $e');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> restore() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(iapServiceProvider).restorePurchases();
      // 結果は purchaseStream 経由で _onPurchaseUpdate に届く
      // ストリームで isPremium が更新されるまで少し待つ
      await Future<void>.delayed(const Duration(seconds: 2));
      state = state.copyWith(isLoading: false);
      return state.isPremium;
    } catch (e) {
      debugPrint('[IAP] restore: $e');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
