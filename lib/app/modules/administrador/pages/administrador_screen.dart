import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:fluttermoji/fluttermojiThemeData.dart';
import 'package:provider/provider.dart';

import '../../../../app_state.dart';
import '../../../shared/widgets/editar_dados.dart';
import '../../home/pages/home_screen.dart';
import '../../auth/pages/login_screen.dart';

class AdministradorScreen extends StatefulWidget {
  @override
  State<AdministradorScreen> createState() => _AdministradorScreenState();
}

class _AdministradorScreenState extends State<AdministradorScreen> {
  int _currentIndex = 1;
  String nome = 'João';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    Color? backgroundColor;
    if (appState.nivelAcesso == 'L') {
      backgroundColor = Colors.lightBlue[50];
    } else if (appState.nivelAcesso == 'A') {
      backgroundColor = Colors.grey[300];
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FluttermojiCircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 80,
              ),
              Text('Bem-vindo, administrador!'),
              Text('Seu nome: ${appState.nome == null ? nome : appState.nome}'),
              Text('Seu CPF: ${appState.cpf}'),
              Text('Sua idade: ${appState.idade}'),
              Text(
                  'Sua localização atual: ${appState.latitude} | ${appState.longitude}'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditionAvatar(),
                      ),
                    );
                  },
                  child: Text('Editar dados')),
              SizedBox(
                height: 80,
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
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
