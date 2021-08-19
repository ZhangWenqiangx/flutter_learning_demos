import 'package:flutter/material.dart';

void main() {
  // runApp(DemoStatelessWidget("stateless"));
  runApp(DemoStatefulWidget("stateful"));
}

class DemoStatefulWidget extends StatefulWidget {
  final String text;

  DemoStatefulWidget(this.text);

  @override
  State<StatefulWidget> createState() => _DemoStateWidgetState(text);
}

class _DemoStateWidgetState extends State<DemoStatefulWidget> {
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
      child: Text(text, textDirection: TextDirection.ltr),
    );
  }
}

class DemoStatelessWidget extends StatelessWidget {
  final String text;

  DemoStatelessWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text(text, textDirection: TextDirection.ltr),
    );
  }
}
