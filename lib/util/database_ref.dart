import 'package:sqflite/sqflite.dart';

Database? database_ref;

Future<void> openDb() async {
  database_ref =
      await openDatabase('items.db', version: 1, onCreate: (db, version) async {
    await db.execute(
        'create table items (id INTEGER primary key, title TEXT,description TEXT , image TEXT,price TEXT )');
    print('db created');
  }, onOpen: (db) {
    print('db opend');
  });
}
