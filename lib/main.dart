import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/login_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(DemoApp());
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "index",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "new_page": (context) => HomePage(),
        "index": (context) => LoginPage(),
      },
      builder:EasyLoading.init(),
    );
  }

}
