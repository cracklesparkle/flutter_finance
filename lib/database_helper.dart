import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  // Database fields
  String expenseTable = 'expenses';
  String colId = 'id';
  String colItem = 'item';
  String colAmount = 'amount';
  String colIsIncome = 'isIncome';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'expenses.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $expenseTable (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT,
            $colItem TEXT,
            $colAmount INTEGER,
            $colIsIncome INTEGER,
            $colDate TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertExpense(Map<String, dynamic> expense) async {
    Database db = await this.database;
    return await db.insert(expenseTable, expense);
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    Database db = await this.database;
    return await db.query(expenseTable);
  }

  // Add methods for update and delete if needed

}
