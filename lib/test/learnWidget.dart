import 'package:flutter/material.dart';

void main() {
  runApp(WidgetTest());
}

class WidgetTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoStateWidgetState("title");
}

class _DemoStateWidgetState extends State<WidgetTest> {
  String text;

  _DemoStateWidgetState(this.text);

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 2), () {
      setState(() {
        text = "do some thing";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
      height: 120,
      width: 500,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Colors.black,
          border: Border.all(color: Colors.yellow, width: 0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text("expanded", textDirection: TextDirection.ltr),
            flex: 1,
          ),
          Text(text, textDirection: TextDirection.ltr),
          Text("cloumn2", textDirection: TextDirection.ltr),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _getBottonItem(Icons.stacked_bar_chart, text)
            ],
          )
        ],
      ),
    );
  }

  _getBottonItem(IconData icon, String text) {
    return Expanded(
        flex: 1,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.grey,
              ),
              new Padding(padding: new EdgeInsets.only(left: 15)),
              new Text(
                "data1111111111111111111111111111111111111111111111111111",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.yellow, fontSize: 14),
              )
            ],
          ),
        ));
  }
}
