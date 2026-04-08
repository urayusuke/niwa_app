import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:niwa_app/app/routes/app_router.dart';
import 'package:niwa_app/app/services/app_theme.dart';
import 'package:niwa_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '601556564320-oooihsef7j8p6ob5tdgbmj2dvn81dmj1.apps.googleusercontent.com',
  );
  runApp(const ProviderScope(child: NiwaApp()));
}

class NiwaApp extends ConsumerWidget {
  const NiwaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Niwa',
      theme: buildNiwaTheme(),
      routerConfig: router,
    );
  }
}
