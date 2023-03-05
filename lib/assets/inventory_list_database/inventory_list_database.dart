import 'package:converter/model/computer.dart';
import 'package:excel/excel.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class InventoryListDatabase{
  static final InventoryListDatabase instance = InventoryListDatabase._init();

  static Database? _database;

  InventoryListDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sqfile.db');
    return _database!;
  }
  
  Future<Database> _initDB(String filePath) async {
    return await databaseFactoryFfi.openDatabase(filePath);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future _createDB(Database database) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final model = 'TEXT NOT NULL';
    final buhName = 'TEXT NOT NULL';
    final serialNumber = 'TEXT NOT NULL';
    final productNumber = 'TEXT NOT NULL';
    final buhNumber = 'TEXT NOT NULL';
    final invNumber = 'TEXT NOT NULL';
    final userName = 'TEXT NOT NULL';
    final storage = 'TEXT NOT NULL';
    final sealNumber = 'TEXT NOT NULL';
    final cleanDate = 'TEXT NOT NULL';
    final comment = 'TEXT NOT NULL';

    await database.execute('''
      CREATE TABLE $computersTableName (
        ${ComputerFields.id} $idType, 
        ${ComputerFields.model} $model,
        ${ComputerFields.buhName} $buhName,
        ${ComputerFields.serialNumber} $serialNumber,
        ${ComputerFields.productNumber} $productNumber,
        ${ComputerFields.buhNumber} $buhNumber,
        ${ComputerFields.invNumber} $invNumber,
        ${ComputerFields.userName} $userName,
        ${ComputerFields.storage} $storage,
        ${ComputerFields.sealNumber} $sealNumber,
        ${ComputerFields.cleanDate} $cleanDate,
        ${ComputerFields.comment} $comment,
      )
''');
  }

  void create(Computer computer) async {
    final db = await instance.database;

    await db.insert(computersTableName, computer.toJson());
  }

  Future<Computer> readComputer(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      computersTableName,
      columns: ComputerFields.values,
      where: '${ComputerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Computer.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Computer>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${ComputerFields.id} ASC';
    final result = await db.query(computersTableName, orderBy: orderBy);

    return result.map((json) => Computer.fromJson(json)).toList();
  }
  
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      computersTableName,
      where: '${ComputerFields.id} = ?',
      whereArgs: [id],
    );
  }
}