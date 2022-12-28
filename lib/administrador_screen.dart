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
  int _currentIndex = 1;
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
            Text('Sua localização atual: ${appState.latitude} | ${appState.longitude}'),
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
                      keyboardType: TextInputType.number,
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
                if (_editandoDados && appState.idade < 18) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Idade inválida'),
                        content: Text('A idade deve ser maior ou igual a 18'),
                        actions: [
                          ElevatedButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  setState(() {
                    _editandoDados = !_editandoDados;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Dados atualizados'),
                          content: Text('Seus dados foram atualizados com sucesso!'),

                        );
                      },
                    );
                  });
                }
              },
            ),



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
