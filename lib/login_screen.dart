import 'package:flutter/material.dart';
import 'package:mobile_outkey/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';
import 'localizacao_screen.dart';
import 'leitor_screen.dart';
import 'administrador_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadLoginState().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LocalizacaoScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _cpfController,
                decoration: InputDecoration(
                  hintText: 'CPF',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _senhaController,
                decoration: InputDecoration(
                  hintText: 'Senha',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Entrar'),
                onPressed: () {


                  if (_cpfController.text == '12345678900' &&
                      _senhaController.text == '123') {
                    appState.setLogado(true);
                    appState.setNivelAcesso('A');
                    //se o usuario estiver logado levar para a tela de home
                    //se nao estiver logadodeixar na tela de login
                    if (appState.logado) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }

                  } else if (_cpfController.text == '12345678901' &&
                      _senhaController.text == '123') {
                    appState.setLogado(true);
                    appState.setNivelAcesso('L');
                    //se o usuario estiver logado levar para a tela de home
                    //se nao estiver logadodeixar na tela de login
                    if (appState.logado) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> saveNivelAcesso(String nivelAcesso) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nivelAcesso', nivelAcesso);
  }

  Future<void> saveCpf(String cpf) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cpf', cpf);
  }

  Future<void> saveNome(String nome) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nome', nome);
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
}
