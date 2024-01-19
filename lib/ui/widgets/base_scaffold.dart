import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    required this.body,
    this.safeAreaTop = false,
    this.safeAreaBottom = true,
    this.hMargin = 10,
    this.appBar,
    this.bottomNavigationBar,
    this.drawer,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.backgroundColor = Colors.black,
  }) : super(key: key);
  final Widget body;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool? resizeToAvoidBottomInset;
  final double hMargin;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: appBar,
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      body: SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: hMargin),
          child: body,
        ),
      ),
    );
  }
}
