import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:fluttermoji/fluttermojiThemeData.dart';
import 'package:provider/provider.dart';

import '../../../app_state.dart';

class EditionAvatar extends StatefulWidget {
  const EditionAvatar({Key? key}) : super(key: key);

  @override
  State<EditionAvatar> createState() => _EditionAvatarState();
}

class _EditionAvatarState extends State<EditionAvatar> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Avatar'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[200],
                ),
              ),
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
                  keyboardType: TextInputType.number,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: FluttermojiCustomizer(
                  attributeTitles: const [
                    'Cabelo',
                    'Cor do Cabelo',
                    'Barba',
                    'Cor da Barba',
                    'Roupa',
                    'Cor da Roupa',
                    'Olhos',
                    'Sobrancelhas',
                    'Boca',
                    'Pele',
                    'Acessórios'
                  ],
                  // scaffoldWidth: min(600, _width * 0.85),
                  scaffoldHeight: MediaQuery.of(context).size.height * 0.40,
                  autosave: true,
                  theme: FluttermojiThemeData(
                      primaryBgColor: Colors.lightBlue[50],
                      secondaryBgColor: Colors.grey[200],
                      selectedTileDecoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      unselectedIconColor: Colors.grey[400],
                      iconColor: Colors.white,
                      unselectedTileDecoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      boxDecoration:
                          const BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
