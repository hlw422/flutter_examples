// 新创建的组件
import 'package:flutter/material.dart';

class AddressInfoWidget extends StatelessWidget {
  const AddressInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "公司",
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
            const SizedBox(width: 20),
            Text(
              "常州市新北区",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "新北区软件园E栋",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "候立伟",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const SizedBox(width: 20),
            Text(
              "138****3056",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}