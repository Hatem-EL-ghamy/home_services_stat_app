import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_ease/home_ease__app.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/core/helpers/constants.dart';
import 'package:home_ease/core/routing/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/di/dependency_injection.dart';
import 'package:home_ease/core/helpers/my_bloc_observer.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
// ignore_for_file: unused_local_variable

// import 'package:home_ease/core/di/dependency_injection.dart';
// ignore: depend_on_referenced_packages
// ignore: depend_on_referenced_packages
// ignore: depend_on_referenced_packages
// ignore: depend_on_referenced_packages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  setupGetIt();

  // Always start from splash screen
  String initialRoute = Routes.splashScreen;

  token = CacheHelper.getData(key: 'token');
  token != null ? token = CacheHelper.getData(key: 'token') : token = null;

  log(token.toString());

  Bloc.observer = MyBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,

    statusBarIconBrightness:
        Brightness.dark, //<-- For Android SEE HERE (dark icons)
  ));

  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('ar', 'EG'),
      // assetLoader: const CodegenLoader(),
      // saveLocale: true,
      child: HomeEase(
        appRouter: AppRouter(),
        initialRoute: initialRoute,
      ),
    ),
  );
}
