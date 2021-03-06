import 'dart:async';
import 'package:flutter/material.dart';
import 'package:organadora/view/constructor/payment.dart';
import 'package:organadora/view/constructor/user.dart';
import 'package:organadora/view/food/organicproduct.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  const PayScreen({Key key, this.user, this.payment}) : super(key: key);
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
   Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lightGreenAccent[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color:Colors.white,
          onPressed:(){
            _backButton();
          }
        )
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl:
                    'https://crimsonwebs.com/s271819/organadora/php/bill_generate.php?email=' +
                        widget.user.email +
                        '&mobile=' +
                        widget.user.phone +
                        '&name=' +
                        widget.user.name +
                        '&message=' +
                        widget.payment.message +
                        '&amount=' +
                        widget.payment.totalpayment.toStringAsFixed(2)+
                        '&address=' +
                        widget.user.address,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _backButton() {
    Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => OrganicProduct(user: widget.user)));
  }
  }
