import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final String databaseName = "data.db";

  static Future<Database> databaseAccess() async {
    String databaseRoad = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(databaseRoad)) {
      print("database exists.");
    } else {
      ByteData data = await rootBundle.load("data/$databaseName");

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(databaseRoad).writeAsBytes(bytes, flush: true);
      print("database copied to phone.");
    }
    return openDatabase(databaseRoad);
  }
}
