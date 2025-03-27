// 新创建的组件
import 'package:flutter/material.dart';

class AddressEditWidget extends StatelessWidget {
  const AddressEditWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("edit address"),
            IconButton(
              // 返回按钮
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // 点击返回上一页
              },
            ),
          ],
        ),
      ],
    );
  }
}
