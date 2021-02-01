import 'package:DrezuBiju/model/VendaModel.dart';
import 'package:DrezuBiju/model/ProdutoModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbHelper {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "xoias.db"),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE venda(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            dataVenda DATETIME,
            comprador TEXT,
            pago BOOLEAN,
          )
        ''');

        db.execute('''
          CREATE TABLE produto(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            tipo TEXT,
            codigo TEXT,
            valorVenda REAL,
            valorPagar REAL,
            solicitacaoId INTEGER,
          )
        ''');
      },
      version: 1,
    );
  }

  /*
   *
   */

  Future<void> deleteProduto(int id) async {
    try {
      final Database db = await _getDatabase();

      await db.delete('produto', where: 'id = ?', whereArgs: [id]);
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<void> insertProduto(ProdutoModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        'produto',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<ProdutoModel>> getProdutos() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query("produto");

      return List.generate(
        maps.length,
        (i) {
          return ProdutoModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<ProdutoModel>();
    }
  }

  Future<List<ProdutoModel>> getProdutosPorVenda(int solititacaoId) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query("produto",
          where: "solititacaoId = ?", whereArgs: [solititacaoId]);

      return List.generate(
        maps.length,
        (i) {
          return ProdutoModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<ProdutoModel>();
    }
  }

  /*
   * 
   */

  Future<void> deleteVenda(int id) async {
    try {
      final Database db = await _getDatabase();

      await db.delete('venda', where: 'id = ?', whereArgs: [id]);
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<void> insertVenda(VendaModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        'venda',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<VendaModel>> getVendas() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query("venda");

      return List.generate(
        maps.length,
        (i) {
          return VendaModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<VendaModel>();
    }
  }
}
