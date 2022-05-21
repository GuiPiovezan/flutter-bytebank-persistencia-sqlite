import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

Future<Database> getDatabase() async {
  //Depois da refatoração
  final String dbPath = await getDatabasesPath();
  final path = join(dbPath, 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('''CREATE TABLE contacts(
          id INTEGER PRIMARY KEY,
          name TEXT,
          account_number INTEGER)''');
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );

  //Antes da refatoração
  // return getDatabasesPath().then((value) {
  //   final String path = join(value, 'bytebank.db');
  //   return openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       db.execute('''CREATE TABLE contacts(
  //         id INTEGER PRIMARY KEY,
  //         name TEXT,
  //         account_number INTEGER)''');
  //     },
  //     version: 1,
  //     //onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });
}

Future<int> save(Contact contact) async {
  //Depois da refatoração
  final db = await getDatabase();
  final Map<String, dynamic> contactMap = {};

  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;

  return db.insert('contacts', contactMap);

  //Antes da refatoração
  // return getDatabase().then((db) {
  //   final Map<String, dynamic> contactMap = {};
  //   contactMap['name'] = contact.name;
  //   contactMap['account_number'] = contact.accountNumber;
  //   return db.insert('contacts', contactMap);
  // });
}

Future<List<Contact>> findAll() async {
  //Depois da refatoração
  final db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('contacts');
  final List<Contact> contacts = [];

  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'],
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }

  return contacts;

  //Antes da refatoração
  // return getDatabase().then((value) {
  //   return value.query('contacts').then((maps) {
  //     final List<Contact> contacts = [];
  //     for (Map<String, dynamic> map in maps) {
  //       final Contact contact = Contact(
  //         map['id'],
  //         map['name'],
  //         map['account_number'],
  //       );
  //       contacts.add(contact);
  //     }
  //     return contacts;
  //   });
  // });
}
