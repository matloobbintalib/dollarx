import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_bloc_observer.dart';
import 'app/my_app.dart';
import 'config/environment.dart';
import 'core/di/service_locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  setupLocator(Environment.fromEnv(AppEnv.dev));
  await sl.allReady();
  HttpOverrides.global = MyHttpOverrides();
  runApp(DollarXApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}