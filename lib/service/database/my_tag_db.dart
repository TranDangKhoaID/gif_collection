import 'package:sqflite/sqflite.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/service/database/database_service.dart';

class MyTagDB {
  final tableName = 'my_tags';

  Future<void> dropTable() async {
    final database = await DatabaseService().database;
    await database.execute(
      '''
    DROP TABLE IF EXISTS $tableName
      ''',
    );
  }

  Future<void> createTable(Database database) async {
    await database.execute(
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      "id" TEXT,
      "name" TEXT,
      "gif" TEXT,
      "avatar" TEXT,
      "race" TEXT,
      "description" TEXT,
      "attack" INTEGER,
      "defense" INTEGER,
      PRIMARY KEY("id")
    );
      ''',
    );
  }

  Future<int> create(MyTagModel myTagModel) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
    INSERT INTO $tableName(id,name,gif,avatar,race,description,attack,defense) 
    VALUES (?,?,?,?,?,?,?,?)
      ''',
      [
        myTagModel.id,
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

  Future<void> deleteByID(String id) async {
    final database = await DatabaseService().database;
    await database.rawDelete(
      '''
        DELETE FROM $tableName WHERE id = ?
      ''',
      [id],
    );
  }

  Future<void> deleteAll() async {
    final database = await DatabaseService().database;
    await database.delete(tableName);
  }
}
