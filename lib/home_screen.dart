import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'administrador_screen.dart';
import 'app_state.dart';
import 'leitor_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);


    Color? backgroundColor;
    if (appState.nivelAcesso == 'L') {
      backgroundColor = Colors.lightBlue;
    } else if (appState.nivelAcesso == 'A') {
      backgroundColor = Colors.grey[300]  ;
    }

    return Scaffold(
        backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bem-vindo, ${appState.nome}!'),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              // color: Colors.grey[300], // cinza claro
              child: GridView.count(
                crossAxisCount: 2, // número de colunas do grid
                mainAxisSpacing: 10, // espaçamento entre os itens na horizontal
                crossAxisSpacing: 10, // espaçamento entre os itens na vertical
                children:
                    //se o usuario for um administrador, ele pode ver os outros administradores
                    //se o usuario for um leitor, ele pode ver os outros leitores
                appState.nivelAcesso == 'A'
                        ? List.generate(appState.outrosAdministradores.length,
                            (index) {
                            final administrador =
                                appState.outrosAdministradores[index];
                            return Container(
                              width: 80,
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person),
                                    radius: 30,),

                                    Text(
                                      administrador['nome'],
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      administrador['localizacaoAtual'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                        : List.generate(appState.outrosLeitores.length,
                            (index) {
                            final leitor = appState.outrosLeitores[index];
                            return Container(
                              width: 80,
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              child: Card(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(backgroundColor: Colors.grey,child: Icon(Icons.person),
                                    radius: 30,
                                    ),
                                    Text(
                                      leitor['nome'],
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      leitor['localizacaoAtual'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
              ),
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
