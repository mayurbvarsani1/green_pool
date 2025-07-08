import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:upgrader/upgrader.dart';

import 'app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/routes/app_pages.dart';
import 'app/services/app_language.dart';
import 'app/services/auth.dart';
import 'app/services/colors.dart';
import 'app/services/dependency_injection.dart';
import 'app/services/push_notification_service.dart';
import 'app/services/storage.dart';
import 'app_environment.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform, name: "prod");
  }

  await initGetServices();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  PushNotificationService().setupInteractedMessage();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance; // Initialize Firebase Analytics
  FirebaseAnalyticsObserver analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics); // Create Observer

  return runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,

        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtil.kBackgroundColor,
      ),
      navigatorObservers: [analyticsObserver],
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      locale: Locale(Get.find<GetStorageService>().langCode,
          Get.find<GetStorageService>().langCodeV),
      fallbackLocale: AppLanguage.getLocale(),
      translationsKeys: AppTranslation.translations,
      initialRoute: AppPages.INITIAL,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      unknownRoute: GetPage(
        name: "/splash",
        page: () => const SplashView(),
        binding: SplashBinding(),
      ),
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
    ),
  ));
}

Future<void> initGetServices() async {
  AppEnvironment.setupEnv(Environment.prod);
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  await Get.putAsync<AuthService>(() async => AuthService());
  Get.put(HomeController());
  await DependencyInjection.init();
}
