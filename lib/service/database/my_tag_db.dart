import 'package:sqflite/sqflite.dart';
import 'package:tikimon_collection/models/my_tag_model.dart';
import 'package:tikimon_collection/service/database/database_service.dart';

class MyTagDB {
  final tableName = 'my_tags';

  Future<void> createTable(Database database) async {
    await database.execute(
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER,
      "name" TEXT,
      "gif" TEXT,
      "avatar" TEXT,
      "race" TEXT,
      "description" TEXT,
      "attack" INTEGER,
      "defense" INTEGER,
      "quantity" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
    );
      ''',
    );
  }

  Future<int> create(MyTagModel myTagModel) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
    INSERT INTO $tableName(name,gif,avatar,race,description,attack,defense) 
    VALUES (?,?,?,?,?,?,?)
      ''',
      [
        myTagModel.name,
        myTagModel.gif,
        myTagModel.avatar,
        myTagModel.race,
        myTagModel.description,
        myTagModel.attack,
        myTagModel.defense,
      ],
    );
  }

  Future<List<MyTagModel>> fetchAll() async {
    final database = await DatabaseService().database;
    final myTags = await database.rawQuery(
      '''
        SELECT * FROM $tableName
      ''',
    );
    return myTags.map((json) => MyTagModel.fromJson(json)).toList();
  }

  Future<MyTagModel> fetchByID(int id) async {
    final database = await DatabaseService().database;
    final myTag = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ?
      ''',
      [id],
    );
    return MyTagModel.fromJson(myTag.first);
  }

  // Future<int> updateQuantity({
  //   required int id,
  //   required int quantity,
  // }) async {
  //   final database = await DatabaseService().database;
  //   return await database.update(
  //     tableName,
  //     {
  //       'quantity': quantity += 1,
  //     },
  //     where: 'id = ?',
  //     conflictAlgorithm: ConflictAlgorithm.rollback,
  //     whereArgs: [id],
  //   );
  // }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete(
      '''
        DELETE FROM $tableName WHERE id = ?
      ''',
      [id],
    );
  }
}
