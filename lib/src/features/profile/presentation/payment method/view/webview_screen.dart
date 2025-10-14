import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebViewScreen extends StatefulWidget {
  final String url;

  const StripeWebViewScreen({super.key, required this.url});

  @override
  State<StripeWebViewScreen> createState() => _StripeWebViewScreenState();
}

class _StripeWebViewScreenState extends State<StripeWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (url.startsWith('https://localhost:8000/expert/')) {
              Navigator.of(context).pop();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect bank", textAlign: TextAlign.center,)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
