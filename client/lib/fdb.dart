import 'package:firebase_dart/database.dart';

class FDb {
  static late FirebaseDatabase db;
  static init(FirebaseDatabase db) {
    FDb.db = db;
  }
}
