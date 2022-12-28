import 'package:flutter/material.dart';
import 'package:mobile_outkey/administrador_screen.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'leitor_screen.dart';

class LocalizacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitação de localização'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Solicitamos acesso à sua localização atual'),
            ElevatedButton(
              child: Text('Dar permissão'),
              onPressed: () {
                // Dê a permissão de acesso à localização aqui
                appState.setLocalizacaoAtual('São Paulo, SP');
                if (appState.nivelAcesso == 'A') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdministradorScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeitorScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

