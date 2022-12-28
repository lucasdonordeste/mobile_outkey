import 'package:flutter/cupertino.dart';

class AppState with ChangeNotifier {
  bool _logado = false;
  bool _localizacao = false;
  late String _nivelAcesso;
  late String _nome = '';
  late String _cpf = '';
  late int _idade = 0;
  late String _localizacaoAtual;
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

  void setLogado(bool value) {
    _logado = value;
    notifyListeners();
  }

  void setLocalizacao(bool value) {
    _localizacao = value;
    notifyListeners();
  }

  void setNivelAcesso(String value) {
    _nivelAcesso = value;
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

  void setOutrosLeitores(List<Map<String, dynamic>> value) {
    _outrosLeitores = value;
    notifyListeners();
  }

  void addOutroAdministrador(Map<String, dynamic> value) {
    _outrosAdministradores.add(value);
    notifyListeners();
  }

  void addOutroLeitor(Map<String, dynamic> value) {
    _outrosLeitores.add(value);
    notifyListeners();
  }

  void removeOutroAdministrador(Map<String, dynamic> value) {
    _outrosAdministradores.remove(value);
    notifyListeners();
  }

  void removeOutroLeitor(Map<String, dynamic> value) {
    _outrosLeitores.remove(value);
    notifyListeners();
  }

  void clearOutrosAdministradores() {
    _outrosAdministradores.clear();
    notifyListeners();
  }

  void clearOutrosLeitores() {
    _outrosLeitores.clear();
    notifyListeners();
  }
}