import 'package:sqflite/sqflite.dart';


class Usuario {
  final String cpf;
  final String nome;
  final String senha;
  final String nivelAcesso;

  Usuario(this.cpf, this.nome, this.senha, this.nivelAcesso);

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'nome': nome,
      'senha': senha,
      'nivel_acesso': nivelAcesso,
    };
  }
}

class BancoDeDados {
  static final BancoDeDados _instance = BancoDeDados._internal();

  factory BancoDeDados() => _instance;

  BancoDeDados._internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await inicializarDB();
    return _db;
  }

  inicializarDB() async {
    return openDatabase(
        // Defina o caminho do banco de dados
        'usuarios.db',
        // Quando o banco de dados é criado pela primeira vez, crie a tabela
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE usuarios(cpf TEXT PRIMARY KEY, nome TEXT, senha TEXT, nivel_acesso TEXT)",
      );
    },
        // Defina a versão. Isso executa o onCreate e provides a path to perform database upgrades and downgrades.
        version: 1);
  }

  Future<void> inserirUsuario(Usuario usuario) async {
    final Database? db = await this.db;
    await db!.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Usuario>> usuarios() async {
    final Database? db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario(
        maps[i]['cpf'],
        maps[i]['nome'],
        maps[i]['senha'],
        maps[i]['nivel_acesso'],
      );
    });
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    final db = await this.db;
    await db!.update(
      'usuarios',
      usuario.toMap(),
      where: "cpf = ?",
      whereArgs: [usuario.cpf],
    );
  }

  Future<void> deletarUsuario(String cpf) async {
    final db = await this.db;
    await db!.delete(
      'usuarios',
      where: "cpf = ?",
      whereArgs: [cpf],
    );
  }

}