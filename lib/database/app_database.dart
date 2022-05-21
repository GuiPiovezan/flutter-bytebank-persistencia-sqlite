import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

Future<Database> creteDatabase() {
  return getDatabasesPath().then((value) {
    final String path = join(value, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('''CREATE TABLE contacts(
          id INTEGER PRIMARY KEY, 
          name TEXT, 
          account_number INTEGER)''');
    }, version: 2);
  });
}

Future<int> save(Contact contact) {
  return creteDatabase().then((db) {
    final Map<String, dynamic> contactMap = {};

    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;

    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return creteDatabase().then((value) {
    return value.query('contacts').then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contacts.add(contact);
      }
      return contacts;
    });
  });
}
