import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/theme_service.dart';
import 'package:postervibe/core/utils/app_theme.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/localization/localization_service.dart';

import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setup();
  LocalStorage.loadLocalData();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor:
            Get.isDarkMode ? AppColors.darkModeBackgroundColor : Colors.white,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ConnectivityManager());
      }),
      debugShowCheckedModeBanner: false,
      title: 'Poster Vibe',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeService().theme,
      initialRoute: AppRoute.splash,
      getPages: AppRoute.pages,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      defaultTransition: Transition.cupertino,
      locale: Locale(LocalStorage.local),
      fallbackLocale: Locale(LocalStorage.local),
      translations: LocalizationService(),
    );
  }
}
