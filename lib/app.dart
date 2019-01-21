import 'package:flutter/material.dart';
import 'package:flutter_plugin_mtime/ui/home.dart';
import 'package:flutter_plugin_mtime/constant/colors.dart';

class MtimeApp extends StatefulWidget {
  @override
  _MtimeAppState createState() => _MtimeAppState();
}

class _MtimeAppState extends State<MtimeApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Mcolors.windowBackground,
        cardColor: Mcolors.contentBackground,

      ),
      home: HomePage(),
    );
  }
}
