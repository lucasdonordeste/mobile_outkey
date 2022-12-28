import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AdministradorScreen extends StatefulWidget {
  @override
  State<AdministradorScreen> createState() => _AdministradorScreenState();
}

class _AdministradorScreenState extends State<AdministradorScreen> {
  int _currentIndex = 0;
  bool _editandoDados = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text('Bem-vindo, administrador!'),
            Text('Seu nome: ${appState.nome}'),
            Text('Seu CPF: ${appState.cpf}'),
            Text('Sua idade: ${appState.idade}'),
            Text('Sua localização atual: ${appState.localizacaoAtual}'),
            _editandoDados
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nome (mínimo 5 dígitos)',
                      ),
                      onChanged: (value) {
                        if (value.length >= 5) {
                          appState.setNome(value);
                        }
                      },
                    ),
                  )
                : Container(),
            _editandoDados
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'CPF',
                      ),
                      onChanged: (value) {
                        appState.setCpf(value);
                      },
                    ),
                  )
                : Container(),
            _editandoDados
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Idade (maior ou igual a 18)',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final idade = int.tryParse(value);
                        if (idade != null && idade >= 18) {
                          appState.setIdade(idade);
                        }
                      },
                    ),
                  )
                : Container(),

            ElevatedButton(
              child: Text(_editandoDados ? 'Concluir' : 'Editar'),
              onPressed: () {
                setState(() {
                  _editandoDados = !_editandoDados;
                });
              },
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.grey[300], // cinza claro
              child: GridView.count(
                crossAxisCount: 2, // número de colunas do grid
                mainAxisSpacing: 10, // espaçamento entre os itens na horizontal
                crossAxisSpacing: 10, // espaçamento entre os itens na vertical
                children: List.generate(appState.outrosAdministradores.length,
                    (index) {
                  final administrador = appState.outrosAdministradores[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(backgroundColor: Colors.grey),
                        Text(
                          administrador['nome'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          administrador['localizacaoAtual'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            //botao de logout
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
