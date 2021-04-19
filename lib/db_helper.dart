import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database _database;

  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> database() async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'wiki.db');

    var createTableListQuery =
        'CREATE TABLE list(id INTEGER PRIMARY KEY, title TEXT, url TEXT, desc TEXT)';

    return await openDatabase(path, onCreate: (db, version) async {
      return await db.execute(
        createTableListQuery,
      );
    }, version: 1);
  }

  insertListData(PageData data) async {
    final db = await instance.database();
    db.insert('list', data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('data inserted');
  }

  Future<List<PageData>> getListDataFromDb(String searchedValue) async {
    final db = await instance.database();

    List<Map<String, dynamic>> list = await db
        .query('list', where: 'title LIKE ?', whereArgs: ['%$searchedValue%']);
    var dataList = List.generate(list.length, (index) {
      return PageData(
        pageId: list[index]['id'],
        title: list[index]['title'],
        desc: list[index]['desc'],
        url: list[index]['url'],
      );
    });
    return dataList;
  }
}

class PageData {
  PageData({
    this.title,
    this.pageId,
    this.desc,
    this.url,
  });

  String title;
  int pageId;
  String desc;
  String url;

  factory PageData.fromJson(Map<String, dynamic> json) => PageData(
        title: json["title"],
        pageId: json["id"],
        desc: json["desc"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": pageId,
        "desc": desc,
        "url": url,
      };
}
