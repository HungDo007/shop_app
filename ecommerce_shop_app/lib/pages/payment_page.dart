import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './checkout_status.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  static const routeName = "payment";

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: WebView(
        initialUrl: paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
        },
        onPageStarted: (String strUrl) {
          final url = Uri.parse(strUrl);
          final token = url.queryParameters["token"];
          if (strUrl.contains("checkout/CheckoutSuccess")) {
            Navigator.pushNamed(
              context,
              CheckoutStatus.routeName,
              arguments: {"isSuccess": true, "token": token},
            );
          } else {
            if (strUrl.contains("checkout/CheckoutFail")) {
              Navigator.pushNamed(
                context,
                CheckoutStatus.routeName,
                arguments: {"isSuccess": false, "token": token},
              );
            }
          }
        },
      ),
    );
  }
}
