import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/empty_widget.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../cubit/content_page_cubit.dart';
import '../cubit/content_page_state.dart';

class HtmlContentPage extends StatefulWidget {
  final String pageTitle;

  const HtmlContentPage({super.key, required this.pageTitle});

  @override
  State<HtmlContentPage> createState() => _HtmlContentPageState();
}

class _HtmlContentPageState extends State<HtmlContentPage> {
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  Future<void> _loadHtmlString(Completer<WebViewController> controller,
      BuildContext context, String htmlContent) async {
    WebViewController _controller = await controller.future;
    await _controller.loadHtmlString(htmlDecode(htmlContent));
  }

  String htmlDecode(String input) {
    final document = parse(input);
    return document.body!.text;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentPageCubit(sl())..contentPages(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: widget.pageTitle,
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ContentPageCubit, ContentPageState>(
          builder: (context, state) {
            if(state.contentPageStatus == ContentPageStatus.loading){
              return Center(child: LoadingIndicator(),);
            }
            if(state.contentPageStatus == ContentPageStatus.success){
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: WebView(
                      backgroundColor: Colors.black,
                      initialUrl: 'https://flutter.dev',
                      // Replace with the desired URL
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (String url) {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      zoomEnabled: true,
                      onWebViewCreated: (
                          WebViewController webViewController) async {
                        _controller.complete(webViewController);
                        _loadHtmlString(_controller, context, state.pages.first.htmlContent);
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    ),
                  ),
                  if (_isLoading)
                    Center(
                      child: LoadingIndicator(),
                    ),
                ],
              );;
            }
            if(state.contentPageStatus == ContentPageStatus.failure){
              return Center(child: Text(state.message,style: TextStyle(color: Colors.white),),);
            }
            return EmptyWidget();
          },
        ),
      ),
    );
  }
}