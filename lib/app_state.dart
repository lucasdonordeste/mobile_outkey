import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  bool _logado = false;
  bool _localizacao = false;
  late String _nivelAcesso;
  late String _nome = '';
  late String _cpf = '';
  late int _idade = 0;
  late String _localizacaoAtual = '';
  List<Map<String, dynamic>> _outrosAdministradores = [
    {
      'nome': 'Administrador 1',
      'cpf': '123.456.789-00',
      'idade': 30,
      'localizacaoAtual': 'Rio de Janeiro, RJ',
    },
    {
      'nome': 'Administrador 2',
      'cpf': '987.654.321-00',
      'idade': 35,
      'localizacaoAtual': 'São Paulo, SP',
    },
  ];
  List<Map<String, dynamic>> _outrosLeitores = [
    {
      'nome': 'Leitor 1',
      'cpf': '111.222.333-44',
      'idade': 20,
      'localizacaoAtual': 'Belo Horizonte, MG',
    },
    {
      'nome': 'Leitor 2',
      'cpf': '444.555.666-77',
      'idade': 25,
      'localizacaoAtual': 'Recife, PE',
    },
    {
      'nome': 'Leitor 3',
      'cpf': '777.888.999-11',
      'idade': 28,
      'localizacaoAtual': 'Salvador, BA',
    },
  ];

  bool get isLogado => _logado;



  Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> saveNivelAcesso(String nivelAcesso) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nivelAcesso', nivelAcesso);
  }


  void setLogado(bool value) {
    _logado = value;
    saveLoginState(value);
    notifyListeners();
  }

  void setNivelAcesso(String value) {
    _nivelAcesso = value;
    saveNivelAcesso(value);
    notifyListeners();
  }

  Future<bool> loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }




  final Map<String, dynamic> _adminMocado = {
    'cpf': '123.456.789-00',
    'senha': 'admin123',
  };
  final Map<String, dynamic> _leitorMocado = {
    'cpf': '987.654.321-00',
    'senha': 'leitor123',
  };

  bool get logado => _logado;

  bool get localizacao => _localizacao;

  String get nivelAcesso => _nivelAcesso;

  String get nome => _nome;

  String get cpf => _cpf;

  int get idade => _idade;

  String get localizacaoAtual => _localizacaoAtual;

  List<Map<String, dynamic>> get outrosAdministradores =>
      _outrosAdministradores;

  List<Map<String, dynamic>> get outrosLeitores => _outrosLeitores;




  void setLocalizacao(bool value) {
    _localizacao = value;
    notifyListeners();
  }



  void setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  void setCpf(String value) {
    _cpf = value;
    notifyListeners();
  }

  void setIdade(int value) {
    _idade = value;
    notifyListeners();
  }

  void setLocalizacaoAtual(String value) {
    _localizacaoAtual = value;
    notifyListeners();
  }

  void setOutrosAdministradores(List<Map<String, dynamic>> value) {
    _outrosAdministradores = value;
    notifyListeners();
  }




  checkIsLoggedIn() {
    if (_cpf == _adminMocado['cpf'] && _cpf == _leitorMocado['cpf']) {
      setNivelAcesso('Administrador');
    } else if (_cpf == _adminMocado['cpf']) {
      setNivelAcesso('Administrador');
    } else if (_cpf == _leitorMocado['cpf']) {
      setNivelAcesso('Leitor');
    } else {
      setNivelAcesso('Não logado');
    }
  }

  void logout() {
    setLogado(false);
    setNivelAcesso('Não logado');
    setCpf('');
    setIdade(0);
    _localizacao = false;
    _localizacaoAtual = '';

  }

  checkNivelAcesso() {
if (_nivelAcesso == 'Administrador') {
      setOutrosAdministradores(_outrosAdministradores);

    } else if (_nivelAcesso == 'Leitor') {
      setOutrosAdministradores([]);

    } else {
      setOutrosAdministradores([]);

    }

  }
}