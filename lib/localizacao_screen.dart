import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobile_outkey/administrador_screen.dart';
import 'package:mobile_outkey/home_screen.dart';
import 'package:mobile_outkey/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';

import 'app_state.dart';
import 'leitor_screen.dart';

class LocalizacaoScreen extends StatefulWidget {
  @override
  State<LocalizacaoScreen> createState() => _LocalizacaoScreenState();
}

class _LocalizacaoScreenState extends State<LocalizacaoScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Solicitação de localização'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ChangeNotifierProvider<UserController>(
                create: (context) => UserController(),

                child: Builder(builder: (context) {
                  final local = context.watch<UserController>();


                  String mensagem = local.erro == ''
                      ? 'Latitude: ${local.lat} | Longitude: ${local.long}'
                      : local.erro;

                  return Center(child: Text(mensagem));
                })),

            //botao para atualizar a pagina e depois de um duration 3 segundos ir para a tela de home screen\
            ElevatedButton(
                onPressed: () {

                  //salvar a latitude e longitude no appState
                  appState.setLatitude(1);




                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                  });
                },
                child: Text('Atualizar')),


          ],
        ));
  }
}
