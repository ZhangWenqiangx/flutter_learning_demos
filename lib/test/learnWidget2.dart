import 'package:flutter/material.dart';

void main() {
  runApp(LearnWidget2App());
}

class LearnWidget2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var top =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).padding.top;
    return new MaterialApp(home: new LearnWidgetPage());
  }
}

class LearnWidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeanWidgetStatePage();
}

class LeanWidgetStatePage extends State<LearnWidgetPage> {
  Widget buildLoading() {
      return Opacity(
        opacity: .5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.black,
          ),
          child: SpinKitPouringHourglass(color: Colors.white),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("this is scaffold page"),
      ),
    );
  }
}
