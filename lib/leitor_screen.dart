import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_outkey/login_screen.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home_screen.dart';

class LeitorScreen extends StatefulWidget {
  @override
  State<LeitorScreen> createState() => _LeitorScreenState();
}

class _LeitorScreenState extends State<LeitorScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    List<String> nomes = [
      'João',
      'Maria',
      'José',
      'Ana',
      'Carlos',
      'Bruna',
      'Mateus',
      'Luana'
    ];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bem-vindo, leitor!'),
            Text('Nome: ${appState.nome}'),

            Text('Sua idade: ${appState.idade}'),
            Text(
                'Sua localização atual: ${appState.latitude} | ${appState.longitude}'),
            Text('Seu nível de acesso: ${appState.nivelAcesso}'),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                appState.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}
