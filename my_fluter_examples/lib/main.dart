import 'package:flutter/material.dart';
import 'package:my_fluter_examples/examples/Fstates/TapboxA.dart';
import 'package:my_fluter_examples/examples/ImageShow.dart';
import 'package:my_fluter_examples/examples/SwitchAndCheckBoxTestRoute.dart';
import 'package:my_fluter_examples/examples/button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semantics Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SemanticsExamplePage(),
    );
  }
}

class SemanticsExamplePage extends StatefulWidget {
  @override
  _SemanticsExamplePageState createState() => _SemanticsExamplePageState();
}

class _SemanticsExamplePageState extends State<SemanticsExamplePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Semantics Example')),
      body: Column(
        children: [
          ButtonExample(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [TapboxA(), ImageShow()],
          ),
          SwitchAndCheckBoxTestRoute(),
        ],
      ),
    );
  }
}
