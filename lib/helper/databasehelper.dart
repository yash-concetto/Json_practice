import 'dart:developer';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/model/dbmodelm.dart';


class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String table_mart = 'mart';
  String id = 'id';
  String mname = 'martname';

  String table_product = 'product';
  String pid = 'productid';
  String pname = 'productname';
  String pprice = 'price';

  String table_employee = 'employee';
  String eid = 'employeeid';
  String ename = 'employeename';
  String emo = 'employeemobile';
  String eemail = 'employeemail';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cmp.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $table_mart ($id INTEGER PRIMARY KEY,"
          "$mname TEXT,"
          "$pname TEXT,"
          "$ename TEXT)",
    );

    await db.execute(
      "CREATE TABLE $table_product($id INTEGER PRIMARY KEY,"
          "$pname TEXT,"
          "$pprice TEXT)",
    );

    await db.execute(
      "CREATE TABLE $table_employee($id INTEGER PRIMARY KEY,"
          "$ename TEXT,"
          "$emo TEXT,"
          "$eemail TEXT)",
    );
  }

  Future<int> insert(String name, String number, String email) async {
    Database db = await this.database;
    var result = await db.rawInsert(
        "INSERT INTO $table_employee($ename,$emo,$eemail) VALUES('$name','$number', '$email')");
    return result;
  }

  Future<int> insertmart(String name, String prname, String emname) async {
    Database db = await this.database;
    var result = await db.rawInsert(
        "INSERT INTO $table_mart($mname,$pname,$ename) VALUES('$name','$prname','$emname')");
    return result;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $table_employee");
    return result;
  }

  Future<List<Dbmodel>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Dbmodel> noteList = <Dbmodel>[];
    for (int i = 0; i < count; i++) {
      noteList.add(Dbmodel.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Map<String, dynamic>>> getEmployeeMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "SELECT $mname, $pname, $table_employee.$ename, $table_employee.$emo, $table_employee.$eemail FROM $table_employee INNER JOIN $table_mart ON $table_mart.$ename = $table_employee.$ename");
    print(
        "SELECT * FROM $table_employee INNER JOIN $table_mart ON $table_mart.$ename = $table_employee.$ename");
    return result;
  }

  Future<List<Dbmodel>> getEmployeeList() async {
    var employeeMapList = await getEmployeeMapList();
    int count = employeeMapList.length;
    List<Dbmodel> employeeList = <Dbmodel>[];
    for (int i = 0; i < count; i++) {
      employeeList.add(Dbmodel.fromMap(employeeMapList[i]));
    }
    return employeeList;
  }

  Future<List<Dbmodel>> getMartList() async {
    var martMapList = await getEmployeeMapList();
    int count = martMapList.length;
    List<Dbmodel> martList = <Dbmodel>[];
    for (int i = 0; i < count; i++) {
      martList.add(Dbmodel.fromMap(martMapList[i]));
    }
    return martList;
  }

  Future<int> updateNotes(int id, Dbmodel model) async {
    Database db = await this.database;
    log("$table_employee, ${model.toMap()}, where: '$eid = ?', whereArgs: [$id]");
    var result = await db.update(table_employee, model.toMap(),
        where: '$eid = ?', whereArgs: [id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    var result =
    await db.rawDelete("DELETE FROM $table_employee WHERE $eid = $id");
    print("EID::$eid");
    print("ID::$id");
    print('RESULT::::::${result}');
    return result;
  }
}
