import 'package:tutor_helper/database/DBProvider.dart';

abstract class Model<T> {
  final int id = null;
  final String tableName = "";

  Map<String, dynamic> toMap();

  fromMap(Map<String, dynamic> json);

  save() async {
    final db = await DBProvider.db.database;
//    print(this.toMap());
    if (this.id == null)
      var res = db.insert(this.tableName, this.toMap());
    else
      var res = db.update(this.tableName, this.toMap(),
          where: 'id = ?', whereArgs: [this.id]);
  }

  delete() async {
    final db = await DBProvider.db.database;
    var res = db.delete(this.tableName, where: 'id = ?', whereArgs: [this.id]);
  }

  Future<List<T>> all() async {
    final db = await DBProvider.db.database;

    var res = await db.query(this.tableName, orderBy: "id DESC");
    List<dynamic> list =
        res.isNotEmpty ? res.map((c) => this.fromMap(c)).toList() : [];
//    print(this);
    return list;
  }

  Future<T> find(int id) async {
    final db = await DBProvider.db.database;

    var res = await db.query(this.tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? this.fromMap(res.first) : null;
  }
}
