import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class OfferPage extends StatelessWidget {
  String url;
  OfferPage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset(
          'assets/images/Logo.png',
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 12,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: this.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
