// 定义标签模型
import 'dart:ui';

class Tag {
  final String label;
  final Color color;
  bool isSelected;

  Tag({required this.label, required this.color, this.isSelected = false});
}