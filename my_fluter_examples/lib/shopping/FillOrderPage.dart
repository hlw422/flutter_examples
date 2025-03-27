import 'package:flutter/material.dart';
import 'package:flutter_trans_file/shopping/components/AddressEditWidget.dart';
import 'package:flutter_trans_file/shopping/components/AddressInfoWidget.dart';

class FillOrderPage extends StatelessWidget {
  const FillOrderPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '填写订单',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyOrderPage(title: '填写订单'),
    );
  }
}

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key, required this.title});
  final String title;

  @override
  State<MyOrderPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyOrderPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          // 设置左边内边距为 20 像素
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
            right: 20,
          ),
          child: Container(
            width: 500,
            height: 200,
            // 设置边框样式
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // 边框颜色
                width: 1, // 边框宽度
              ),
              borderRadius: BorderRadius.circular(8), // 边框圆角
            ),
            padding: const EdgeInsets.all(10), // 内边距
            child: Row(
              // 将子组件改为 Row
              children: [
                Expanded(
                  // 让 AddressInfoWidget 占据剩余空间
                  child: AddressInfoWidget(),
                ),
                const SizedBox(width: 10), // 图标与内容的间距
                GestureDetector(
                  // 点击区域
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressEditWidget(),
                      ),
                    );
                  },
                  child: const Icon(
                    // 箭头图标
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
