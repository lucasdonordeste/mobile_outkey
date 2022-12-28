

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'app/modules/home/pages/home_screen.dart';
import 'app/modules/auth/pages/login_screen.dart';
import 'app/modules/localizacao/pages/localizacao_screen.dart';
import 'app/modules/leitor/pages/leitor_screen.dart';
import 'app/modules/administrador/pages/administrador_screen.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
        '/localizacao': (context) => LocalizacaoScreen(),
        '/leitor': (context) => LeitorScreen(),
        '/administrador': (context) => AdministradorScreen(),
      },
    );
  }
}

