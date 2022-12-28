import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_outkey/app/modules/administrador/pages/administrador_screen.dart';
import 'package:mobile_outkey/app/modules/home/pages/home_screen.dart';
import 'package:mobile_outkey/app/shared/services/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';

import '../../../../app_state.dart';
import '../../leitor/pages/leitor_screen.dart';

class LocalizacaoScreen extends StatefulWidget {
  @override
  State<LocalizacaoScreen> createState() => _LocalizacaoScreenState();
}

class _LocalizacaoScreenState extends State<LocalizacaoScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
          child: Column(
            children: [

              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'Solicitação de Localização',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_0u6cgYoyOw.json',
                height: 200,
                width: 200,
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
const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    appState.setLatitude(1);

                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
                    });
                  },
                  child: const Text('Continuar')),
            ],
          ),
        ));
  }
}
