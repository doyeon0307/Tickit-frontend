import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tickit/config/key.dart';
import 'package:tickit/ui/login/splash/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: KAKAO_NATIVE_KEY,
    javaScriptAppKey: KAKAO_JS_KEY,
  );

  runApp(
    EasyLocalization(
      fallbackLocale: const Locale("ko", "KR"),
      supportedLocales: const [Locale("ko", "KR")],
      path: "l10n",
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tickit',
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
      home: const SplashView(),
    );
  }
}
