import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../viewmodel/payment_method_notifier_provider.dart';

class StripeWebViewScreen extends ConsumerStatefulWidget {
  final String url;

  const StripeWebViewScreen({super.key, required this.url});

  @override
  ConsumerState<StripeWebViewScreen> createState() => _StripeWebViewScreenState();
}

class _StripeWebViewScreenState extends ConsumerState<StripeWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            if (url.startsWith('https://localhost:8000/expert/')) {
              await ref.read(paymentMethodNotifierProvider.notifier).getAccountStatus();

              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Connect Bank",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
