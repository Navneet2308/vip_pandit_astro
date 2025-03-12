import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';
import '../../utils/ui_utils.dart';
class WebView extends StatefulWidget {
  final String url;
  final String heading;
  WebView({required this.heading,required this.url});

  @override
  State<WebView> createState() => _ShopViewState();
}

class _ShopViewState extends State<WebView> {
  late WebViewController controller;
  bool isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to load the page")),
            );
          },
        ),
      )
      ..loadRequest(
          Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: colPrimary,
        title: Text(
         widget.heading,
          style: semiBoldTextStyle(fontSize: dimen16, color: black),
        ),

      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
