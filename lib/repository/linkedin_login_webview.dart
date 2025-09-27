import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class LinkedInLoginWebView extends StatefulWidget {
  const LinkedInLoginWebView({super.key});

  @override
  State<LinkedInLoginWebView> createState() => _LinkedInLoginWebViewState();
}

class _LinkedInLoginWebViewState extends State<LinkedInLoginWebView> {
  late final WebViewController _controller;
  var loadingPercentage = 0;

  final String clientId = "77xs883ujqitwg";
  final String redirectUri = "${ApiEndPoints.baseUrl}/auth/linkedin/callback";
  final String scope = "openid email profile";

  @override
  void initState() {
    super.initState();

    final authUrl = Uri.parse(
      "https://www.linkedin.com/oauth/v2/authorization"
      "?response_type=code"
      "&client_id=$clientId"
      "&redirect_uri=$redirectUri"
      "&scope=$scope",
    );

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageFinished: (url) {
                print('on page finished: $url');
                setState(() {
                  loadingPercentage = 100;
                });
              },
              onNavigationRequest: (request) {
                final url = request.url;
                if (url.startsWith("elearningapp://ParentScreen")) {
                  final uri = Uri.parse(url);
                  final params = uri.queryParameters;
                  Navigator.pop(context, params);
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(authUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LinkedIn Login")),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
