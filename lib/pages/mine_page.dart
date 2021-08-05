import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';

class MinePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(
        child: TextButton(
          child: Text("open new route"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          },
        ),
      ),
    );
  }
}
