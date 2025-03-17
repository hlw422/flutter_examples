import 'dart:convert';

class Note {
  final int? id;
  final String content;
  final String time;
  final List<String> tags;

  Note({
    this.id,
    required this.content,
    required this.time,
    required this.tags,
  });

  // 转 Map 存数据库
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'time': time,
      'tags': jsonEncode(tags), // 标签存 JSON 格式
    };
  }

  // 从数据库 Map 转对象
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      time: map['time'],
      tags: List<String>.from(jsonDecode(map['tags'])),
    );
  }
}
