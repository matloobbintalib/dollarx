import 'dart:async';

import 'package:dollarax/modules/webpage/cubit/content_page_cubit.dart';
import 'package:dollarax/modules/webpage/cubit/content_page_state.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/loading_indicator.dart';
import 'package:html/parser.dart' show parse;


class WebScreen extends StatefulWidget {
  final String url;
  final String pageTitle;

  const WebScreen({super.key, required this.url, required this.pageTitle});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ContentPageCubit(sl())..contentPages(),
        child: Scaffold(
          appBar: CustomAppbar(
            title: widget.pageTitle,
          ),
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: WebView(
                  backgroundColor: Colors.black,
                  initialUrl: widget.url,
                  // Replace with the desired URL
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (String url) {
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  zoomEnabled: true,
                ),
              ),
              if (_isLoading)
                Center(
                  child: LoadingIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
