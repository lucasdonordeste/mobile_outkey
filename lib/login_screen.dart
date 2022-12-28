import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'localizacao_screen.dart';
import 'leitor_screen.dart';
import 'administrador_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
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
                      _senhaController.text == '123456') {
                    appState.setLogado(true);
                    appState.setNivelAcesso('A');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocalizacaoScreen(),
                      ),
                    );
                  } else if (_cpfController.text == '12345678901' &&

                      _senhaController.text == '123456') {
                    appState.setLogado(true);
                    appState.setNivelAcesso('L');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocalizacaoScreen(),
                      ),
                    );
                  } else {

                      const SnackBar(
                        content: Text('CPF ou senha incorretos'),

                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
