import 'package:sqflite/sqflite.dart';

Database? database_ref;

Future<void> openDb() async {
  database_ref =
      await openDatabase('items.db', version: 1, onCreate: (db, version) async {
    await db.execute(
        'create table items (id integer primary key, title text,description text , image text,price integer,isFavorite integer , cart integer )');
    print('db created');
  }, onOpen: (db) {
    print('db opend');
  });
}
