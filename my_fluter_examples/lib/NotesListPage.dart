import 'package:flutter/material.dart';
import 'package:my_fluter_examples/model/Note.dart';
import 'package:my_fluter_examples/db/NotesDatabase.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({Key? key}) : super(key: key);

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  List<Note> _notes = [];
  String _keyword = '';
  String? _selectedTag;
  String? _startTime; // 格式：yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss
  String? _endTime;

  final TextEditingController _searchController = TextEditingController();

  // 预设的标签列表（也可以动态获取）
  final List<String> _tags = ["工作", "生活", "学习", "娱乐"];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  /// 根据关键字、标签和时间范围查询速记
  Future<void> _loadNotes() async {
    List<Note> notes;
    // 如果所有筛选条件都为空，则查询所有记录
    if (_keyword.isEmpty &&
        (_selectedTag == null || _selectedTag!.isEmpty) &&
        (_startTime == null || _startTime!.isEmpty) &&
        (_endTime == null || _endTime!.isEmpty)) {
      notes = await NotesDatabase.instance.getAllNotes();
    } else {
      notes = await NotesDatabase.instance.searchNotes(
        keyword: _keyword,
        tag: _selectedTag,
        startTime: _startTime,
        endTime: _endTime,
      );
    }
    setState(() {
      _notes = notes;
    });
  }

  /// 搜索按钮点击事件
  void _onSearch() {
    setState(() {
      _keyword = _searchController.text;
    });
    _loadNotes();
  }

  /// 当点击某个标签时切换选择状态
  void _onTagSelected(String tag) {
    setState(() {
      _selectedTag = _selectedTag == tag ? null : tag;
    });
    _loadNotes();
  }

  // 弹出日期选择器，选择开始日期
  Future<void> _selectStartTime() async {
    DateTime initialDate = DateTime.now();
    if (_startTime != null) {
      try {
        initialDate = DateTime.parse(_startTime!);
      } catch (_) {}
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // 设置当天的起始时间：00:00:00
        _startTime = picked.toIso8601String().substring(0, 10) + " 00:00:00";
      });
      _loadNotes();
    }
  }

  // 弹出日期选择器，选择结束日期
  Future<void> _selectEndTime() async {
    DateTime initialDate = DateTime.now();
    if (_endTime != null) {
      try {
        initialDate = DateTime.parse(_endTime!);
      } catch (_) {}
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // 设置当天的结束时间：23:59:59
        _endTime = picked.toIso8601String().substring(0, 10) + " 23:59:59";
      });
      _loadNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("速记列表"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // 搜索输入框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "搜索内容",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) => _onSearch(),
            ),
          ),
          // 标签筛选区域（横向滚动）
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  _tags.map((tag) {
                    bool isSelected = _selectedTag == tag;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FilterChip(
                        label: Text(tag),
                        selected: isSelected,
                        onSelected: (_) {
                          _onTagSelected(tag);
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),
          // 时间范围选择区域
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _selectStartTime,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _startTime == null ? "开始日期" : _startTime!.substring(0, 10),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _selectEndTime,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _endTime == null ? "结束日期" : _endTime!.substring(0, 10),
                  ),
                ),

                // 清除时间筛选
                IconButton(
                  onPressed: () {
                    setState(() {
                      _startTime = null;
                      _endTime = null;
                    });
                    _loadNotes();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
          ),
          const Divider(),
          // 速记列表展示
          // 速记列表展示
          Expanded(
            child:
                _notes.isEmpty
                    ? const Center(child: Text("暂无速记"))
                    : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        Note note = _notes[index];
                        return Dismissible(
                          key: Key(note.id.toString()),
                          direction: DismissDirection.endToStart, // 限制为从右向左滑动
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) async {
                            // 执行删除操作：从数据库删除并更新本地列表
                            await NotesDatabase.instance.deleteNote(note.id!);
                            setState(() {
                              _notes.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("删除成功")),
                            );
                          },
                          child: ListTile(
                            title: Text(note.content),
                            subtitle: Text(
                              "时间：${note.time}\n标签：${note.tags.join(', ')}",
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
