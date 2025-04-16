import 'package:flutter/material.dart';

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwitchAndCheckBoxTestRouteState();
  }
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //单选开关
  bool? _checkboxSelected = true; //复选开关
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: _switchSelected,
          activeColor: Colors.green,
          onChanged: (value) {
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _checkboxSelected,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              },
            ),
            Text("hello"),
          ],
        ),

        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
      ],
    );
  }
}
