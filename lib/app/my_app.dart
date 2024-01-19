import 'package:bot_toast/bot_toast.dart';
import 'package:dollarx/modules/startup/splash_page.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';
import '../ui/widgets/unfocus.dart';
import 'bloc_di.dart';

class DollarXApp extends StatelessWidget {
  DollarXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocDI(
      child: MaterialApp(
        title: 'DollarX',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
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
