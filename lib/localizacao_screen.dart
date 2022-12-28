import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobile_outkey/administrador_screen.dart';
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

  late StreamSubscription<Position> positionStream;
  String status = 'Aguardando GPS';
  late Position positionLocation = Position(
    latitude: 0,
    longitude: 0,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    timestamp: DateTime.now(),
  );

  String city = '';
  String country = '';

  @override
  void initState() {
    listenPosition();
    super.initState();
  }

  listenPosition() async {
    ph.PermissionStatus permission = await ph.Permission.location.request();

    if (permission.isDenied)
      _showMessage(
          'Parece que você não permitiu o uso do GPS, abra as configurações do aplicativo e libere a permissão');
    else {
      bool gpsIsEnabled = await Geolocator.isLocationServiceEnabled();

      if (!gpsIsEnabled)
        _showMessage
          ('Parece que o GPS está desativado, ative-o e tente novamente');
      setState(() {
        status = 'Obtendo a localização';
      });

      positionStream =
          Geolocator.getPositionStream().listen((Position position) async {
            // garante que o trecho abaixo seja executado somente uma vez
            if (positionLocation == null) {
              positionLocation = position;

              // Obtém a cidade e o país através do geocoding
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  position.latitude, position.longitude);
              if (placemarks != null && placemarks.isNotEmpty) {
                Placemark placemark = placemarks[0];
                city = placemark.locality!;
                country = placemark.country!;
              }

              setState(() {
                status = 'Localização obtida';
              });
            }
          });
    }
  }

  _showMessage(String message) =>
      SnackBar(
        content: Text(message),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      );


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
            Text('Latitude: ${positionLocation.latitude.toString()}'),
        Text('Longitude: ${positionLocation.longitude.toString()}'),
        Text('Cidade: $city'),
        Text('País: $country'),
        Text(
          status,
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(

          onPressed: () {
// Dê a permissão de acesso à localização aqui
            appState.setLocalizacaoAtual('$city, $country');
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
          }, child: const Text('Continuar')),
        ),
      ])),
    );
  }
}