import 'package:my_fluter_examples/model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  // 新增笔记
  Future<int> createNote(Note note) async {
    final db = await NotesDatabase.instance.database;
    return await db.insert('notes', note.toMap());
  }

  // 获取所有笔记
  Future<List<Note>> getAllNotes() async {
    final db = await NotesDatabase.instance.database;

    final result = await db.query('notes', orderBy: 'time DESC');

    return result.map((map) => Note.fromMap(map)).toList();
  }

  // 更新笔记
  Future<int> updateNote(Note note) async {
    final db = await NotesDatabase.instance.database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // 删除笔记
  Future<int> deleteNote(int id) async {
    final db = await NotesDatabase.instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // 搜索笔记
  Future<List<Note>> searchNotes({
    String? keyword,
    String? tag,
    String? startTime,
    String? endTime,
  }) async {
    final db = await NotesDatabase.instance.database;

    List<String> conditions = [];
    List<dynamic> args = [];

    if (keyword != null && keyword.isNotEmpty) {
      conditions.add('content LIKE ?');
      args.add('%$keyword%');
    }

    if (tag != null && tag.isNotEmpty) {
      conditions.add('tags LIKE ?');
      args.add('%$tag%');
    }

    // 如果同时传入开始和结束时间，则查询该时间段内的记录
    if (startTime != null &&
        startTime.isNotEmpty &&
        endTime != null &&
        endTime.isNotEmpty) {
      conditions.add('time BETWEEN ? AND ?');
      args.add(startTime);
      args.add(endTime);
    } else if (startTime != null && startTime.isNotEmpty) {
      conditions.add('time >= ?');
      args.add(startTime);
    } else if (endTime != null && endTime.isNotEmpty) {
      conditions.add('time <= ?');
      args.add(endTime);
    }

    final whereString = conditions.join(' AND ');

    final result = await db.query(
      'notes',
      where: whereString.isNotEmpty ? whereString : null,
      whereArgs: args.isNotEmpty ? args : null,
      orderBy: 'time DESC',
    );

    return result.map((map) => Note.fromMap(map)).toList();
  }

  // 初始化数据库
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE notes (
  id $idType,
  content $textType,
  time $textType,
  tags $textType
)
''');
  }

  // 关闭数据库
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
