import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:sub100daysofcode/utils/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFlutter extends StatefulWidget {
  const WebViewFlutter({super.key});

  @override
  _WebViewFlutterState createState() => _WebViewFlutterState();
}

class _WebViewFlutterState extends State<WebViewFlutter> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    WebView.platform = SurfaceAndroidWebView();
  }
  @override  
  void dispose(){
    super.dispose();
  }
  void _clearCache() async {
    await _webViewController.clearCache();
  }
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      color: AppColors.white,
      debugShowCheckedModeBanner: false,
      title: 'FlipKart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: WebView(
            zoomEnabled: false,
            initialUrl: flipkart,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
              _webViewController.loadUrl(
               flipkart,
                headers: {"Cookie": "mycookie=true"},
               );
              _clearCache();
            },
            onPageStarted: (String url) {
              print("Page started loading: $url");
            },
            onPageFinished: (String url) {
              print("Page finished loading: $url");
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith("$flipkart")) {
                print("Navigating to ${request.url}");
                return NavigationDecision.navigate;
              }
              print("Blocking navigation to ${request.url}");
              return NavigationDecision.prevent;
            },
          ),
        ),
      ),
    );
  }
}