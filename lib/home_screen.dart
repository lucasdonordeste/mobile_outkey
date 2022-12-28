import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'administrador_screen.dart';
import 'app_state.dart';
import 'leitor_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: const Center(
        child: Text('Seja bem-vindo à home'),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          final appState = Provider.of<AppState>(context, listen: false);
          if (index == 1) {
            if (appState.nivelAcesso == 'A') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdministradorScreen(),
                ),
              );
            } else if (appState.nivelAcesso == 'L') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeitorScreen(),
                ),
              );
            }
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
