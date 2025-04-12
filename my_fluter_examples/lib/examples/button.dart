import 'package:flutter/material.dart';

class ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            print('Button clicked');
          },
          child: Text('Click me'),
        ),

        TextButton(
          onPressed: () {
            print('Button clicked');
          },
          child: Text('Click me'),
        ),

        OutlinedButton(
          onPressed: () {
            print('Button clicked');
          },
          child: Text('Click me'),
        ),

        IconButton(
          onPressed: () {
            print('Button clicked');
          },
          icon: Icon(Icons.add),
        ),
        ElevatedButton.icon(
          onPressed: () {
            print('Button clicked');
          },
          label: Text('Click me'),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
