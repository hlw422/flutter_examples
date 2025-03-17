// 注册页面：包含邮箱、密码、确认密码输入框以及注册按钮
import 'package:flutter/material.dart';
import 'package:my_fluter_examples/NotesListPage.dart';
import 'package:my_fluter_examples/db/NotesDatabase.dart';
import 'package:my_fluter_examples/model/Note.dart';
import 'dart:async';

import 'package:my_fluter_examples/model/Tag.dart';

class ShortHandPage extends StatefulWidget {
  const ShortHandPage({super.key});

  @override
  State<ShortHandPage> createState() => _ShortHandPageState();
}

class _ShortHandPageState extends State<ShortHandPage> {
  String _timeString = "";

  // 定义一组可选标签
  final List<Tag> _tags = [
    Tag(label: "工作", color: Colors.green),
    Tag(label: "生活", color: Colors.orange),
    Tag(label: "学习", color: Colors.blue),
    Tag(label: "娱乐", color: Colors.purple),
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    // 每秒更新一次时间
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final String formattedTime = _formatDateTime(DateTime.now());
    setState(() {
      _timeString = formattedTime;
    });
  }

  Future<void> _save() async {
    // 获取用户已选中的标签
    List<String> selectedTags =
        _tags.where((tag) => tag.isSelected).map((tag) => tag.label).toList();

    // 校验输入
    if (_shortHandController.text.trim().isEmpty) {
      _showMessage('请输入速记内容');
      return;
    }

    // 获取当前时间（可按需求格式化）
    String dateTimeNow = DateTime.now().toString().substring(
      0,
      19,
    ); // yyyy-MM-dd HH:mm:ss

    // 创建笔记
    await NotesDatabase.instance.createNote(
      Note(
        content: _shortHandController.text.trim(),
        time: dateTimeNow,
        tags: selectedTags, // ✅ 动态选中的标签
      ),
    );

    // 清空输入框和标签选择状态
    setState(() {
      _shortHandController.clear();
      for (var tag in _tags) {
        tag.isSelected = false;
      }
    });

    _showMessage('速记已保存 ✅');
    //跳转到 NodeListPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotesListPage()),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // 格式化时间为 HH:mm:ss 格式
    return "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  final TextEditingController _shortHandController = TextEditingController();

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("速记"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft, // 左对齐
                  child: Chip(
                    avatar: Icon(Icons.label, size: 20, color: Colors.white),
                    label: Text(
                      _timeString,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                // 展示可选标签，多选效果
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children:
                      _tags.map((tag) {
                        return FilterChip(
                          label: Text(
                            tag.label,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: tag.color.withOpacity(0.6),
                          selectedColor: tag.color,
                          selected: tag.isSelected,
                          onSelected: (bool selected) {
                            setState(() {
                              tag.isSelected = selected;
                            });
                          },
                        );
                      }).toList(),
                ),
                const SizedBox(height: 40),

                TextField(
                  controller: _shortHandController, // 你的 TextEditingController
                  minLines: 3, // 最少显示 3 行
                  maxLines: null, // 当内容超过 3 行时自动扩展
                  decoration: InputDecoration(
                    hintText: '请输入速记内容',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // save按钮
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _save,
                    child: const Text(
                      '保存',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      //跳转到 NodeListPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotesListPage(),
                        ),
                      );
                    },
                    child: const Text(
                      '查看记录',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
