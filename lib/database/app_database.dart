import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void creteDatabase() {
  getDatabasesPath().then((value) {
    final String path = join(value, 'bytebank.db');
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER');
    }, version: 1);
  });
}
