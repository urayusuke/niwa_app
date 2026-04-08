import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_service.g.dart';

@riverpod
FcmService fcmService(Ref ref) => FcmService(
      FirebaseMessaging.instance,
      FirebaseFirestore.instance,
    );

class FcmService {
  FcmService(this._messaging, this._db);
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _db;

  /// 通知許可を要求し、FCMトークンを Firestore に保存する
  Future<void> initialize(String userId) async {
    // 通知許可（iOS は必須、Android 13+ も必要）
    final settings = await _messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    // トークン取得・保存
    await _saveToken(userId);

    // トークンが更新されたときも再保存
    _messaging.onTokenRefresh.listen((token) => _saveToken(userId));

    // フォアグラウンド通知の表示設定（iOS）
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _saveToken(String userId) async {
    final token = await _messaging.getToken();
    if (token == null) return;
    debugPrint('[FCM] token=$token');
    await _db.collection('users').doc(userId).set(
      {'fcmToken': token},
      SetOptions(merge: true),
    );
  }
}
