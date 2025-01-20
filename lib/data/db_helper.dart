import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud/models/item.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;
  List<Item> itemList = [];
  DBHelper._();
  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final String path = await getDatabasesPath();
    final String dbPath = join(path, 'items.db');

    return await openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            image BLOB 
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE items ADD COLUMN image BLOB');
        }
      },
    );
  }

  Future<int> insertItem(Item item) async {
    final db = await database;
    return await db.insert('items', item.toMap());
  }

  Future<List<Item>> getItem() async {
    final db = await database;

    final List<Map<String, dynamic>> items = await db.query('items');
    itemList = items.map((item) => Item.fromMap(item)).toList();
    return itemList;
  }

  Future<int> updateItem(Map<String, dynamic> item, int id) async {
    final db = await database;

    return await db.update(
      'items',
      item,
      where: 'id = ? ',
      whereArgs: [id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await database;

    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
