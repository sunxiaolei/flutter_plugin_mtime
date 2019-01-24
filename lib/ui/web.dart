import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  final String url;

  WebPage(this.url);

  @override
  State<StatefulWidget> createState() {
    return new Web();
  }
}

class Web extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: new Text("Mtime"),
      ),
      initialChild: Center(
        child: Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Card(
              child: Container(
                child: SpinKitCircle(
                  size: 50.0,
                  color: Theme.of(context).primaryColor,
                ),
                width: 70,
                height: 70,
              ),
              elevation: 5,
            ),
          ),
        ),
      ),
    );
  }
}
