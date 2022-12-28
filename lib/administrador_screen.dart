import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home_screen.dart';

class AdministradorScreen extends StatefulWidget {
  @override
  State<AdministradorScreen> createState() => _AdministradorScreenState();
}

class _AdministradorScreenState extends State<AdministradorScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Administrador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bem-vindo, administrador!'),
            Container(
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
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'CPF',
                ),
                onChanged: (value) {
                  appState.setCpf(value);
                },
              ),
            ),
            Container(
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
            ),
            Text('Seu nome: ${appState.nome}'),
            Text('Seu CPF: ${appState.cpf}'),
            Text('Sua idade: ${appState.idade}'),
            Text('Sua localização atual: ${appState.localizacaoAtual}'),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: appState.outrosAdministradores.length,
                itemBuilder: (context, index) {
                  final administrador = appState.outrosAdministradores[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Text(administrador['nome'][0]),
                      ),
                      title: Text(administrador['nome']),
                      subtitle: Text(administrador['localizacaoAtual']),
                    ),
                  );
                },
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
