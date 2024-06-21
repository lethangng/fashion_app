import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'tables/search_history_table.dart';

class FashionDatabase {
  static const dbName = 'fahsion.db';
  static const dbVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await init();

    debugPrint('Database path: ${await getDatabasesPath()}');
    return _database!;
  }

  FashionDatabase._internal();
  static final FashionDatabase instance = FashionDatabase._internal();

  static const initScripts = [
    SearchHistoryTable.createTableQuery,
  ];
  static const migrationScripts = [
    SearchHistoryTable.dropTableQuery,
  ];

  Future<Database> init() async {
    final path = join(
      await getDatabasesPath(),
      dbName,
    );

    Database database = await openDatabase(
      path,
      onCreate: (db, version) {
        initScripts.forEach((scrip) async => await db.execute(scrip));
      },
      onUpgrade: (db, oldVersion, newVersion) {
        migrationScripts.forEach((scrip) async => await db.execute(scrip));
      },
      version: dbVersion,
      singleInstance: true,
    );

    return database;
  }
}
