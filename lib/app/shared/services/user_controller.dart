import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserController extends ChangeNotifier {
 double lat = 0.0;
  double long = 0.0;
  String erro = '';


  UserController() {
    getPosition();
  }

  getPosition() async {
    try {
      final position = await _posicaoAtual();
      lat = position.latitude;
      long = position.longitude;
      notifyListeners();
    } catch (e) {
      erro = e.toString();
      notifyListeners();
    }
  }

  Future<Position>_posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
     return Future.error('GPS desativado');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Voce precisa permitir o uso do GPS');
      }

    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Voce precisa permitir o uso do GPS');
    }

    return await Geolocator.getCurrentPosition(

      desiredAccuracy: LocationAccuracy.high,

    );

  }
}