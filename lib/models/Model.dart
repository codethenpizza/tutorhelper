import 'package:tutor_helper/database/DBProvider.dart';

abstract class Model {
  final String tableName = "";

  Map<String, dynamic> toMap();

  fromMap(Map<String, dynamic> json);

  save() async {
    final db = await DBProvider.db.database;
//    print(this.toMap());
    var res = db.insert(this.tableName, this.toMap());
  }

  Future<List<dynamic>> all() async {
    final db = await DBProvider.db.database;

    var res = await db.query(this.tableName, orderBy: "id DESC");
    List<dynamic> list =
    res.isNotEmpty ? res.map((c) => this.fromMap(c)).toList() : [];
//    print(this);
    return list;
  }

  find(int id) async {
    final db = await DBProvider.db.database;

    var res = await db.query(this.tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? this.fromMap(res.first) : null;
  }
}