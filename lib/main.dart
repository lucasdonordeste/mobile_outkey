import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'login_screen.dart';
import 'localizacao_screen.dart';
import 'leitor_screen.dart';
import 'administrador_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      title: 'Meu Aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: appState.logado
          ? appState.localizacao
              ? appState.nivelAcesso == 'L'
                  ? LeitorScreen()
                  : AdministradorScreen()
              : LocalizacaoScreen()
          : LoginScreen(),
    );
  }
}
