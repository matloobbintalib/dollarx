import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:bot_toast/bot_toast.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:dollarax/modules/startup/splash_page.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';
import '../ui/widgets/unfocus.dart';
import 'bloc_di.dart';
import 'package:http/http.dart' as http;

class DollarXApp extends StatefulWidget {
  DollarXApp({super.key});

  @override
  State<DollarXApp> createState() => _DollarXAppState();
}

class _DollarXAppState extends State<DollarXApp> {

  @override
  Widget build(BuildContext context) {
    return BlocDI(
      child: MaterialApp(
        theme: lightTheme,
        themeMode: ThemeMode.light,
        title: 'Dollarax',
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) {
          child = BotToastInit()(context, child);
          child = UnFocus(child: child);
          return child;
        },
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        home: SplashPage(),
      ),
    );
  }
}