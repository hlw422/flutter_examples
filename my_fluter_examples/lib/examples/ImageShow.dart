import 'package:flutter/material.dart';

class ImageShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String icons = "";
    // accessible: 0xe03e
    icons += "\uE03e";
    // error:  0xe237
    icons += " \uE237";
    // fingerprint: 0xe287
    icons += " \uE287";
    return Column(
      children: [
        Image(
          image: AssetImage("images/wall.png"),
          width: 300.0,
          height: 300.0,
        ),
        Text(
          icons,
          style: TextStyle(
            fontFamily: "MaterialIcons",
            fontSize: 24.0,
            color: Colors.blue
          )
        )
      ],
    );
  }
}
