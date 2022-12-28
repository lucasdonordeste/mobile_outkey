import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class LeitorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bem-vindo, leitor!'),
            Text('Seu nome: ${appState.nome}'),
            Text('Sua idade: ${appState.idade}'),
            Text('Sua localização atual: ${appState.localizacaoAtual}'),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: appState.outrosLeitores.length,
                itemBuilder: (context, index) {
                  final leitor = appState.outrosLeitores[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(leitor['nome'][0]),
                      ),
                      title: Text(leitor['nome']),
                      subtitle: Text(leitor['localizacaoAtual']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
