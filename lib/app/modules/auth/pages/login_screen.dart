import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../../../../app_state.dart';
import '../../home/pages/home_screen.dart';
import '../../localizacao/pages/localizacao_screen.dart';
import '../../leitor/pages/leitor_screen.dart';
import '../../administrador/pages/administrador_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _exibeMensagemErro = false;

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlue, Colors.purple],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_KvK0ZJBQzu.json',
              width: 200,
              height: 200,
            ),

            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'CPF',
                ),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _senhaController,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                ),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_cpfController.text == '12345678900' &&
                      _senhaController.text == '123') {
                    appState.setLogado(true);
                    appState.setNivelAcesso('A');

                    if (appState.localizacao != false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocalizacaoScreen(),
                        ),
                      );
                    }
                  } else if (_cpfController.text == '12345678901' &&
                      _senhaController.text == '123') {
                    appState.setLogado(true);
                    appState.setNivelAcesso('L');

                    if (appState.localizacao != false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocalizacaoScreen(),
                        ),
                      );
                    }
                  } else {
                    // exibe uma mensagem de erro
                    _exibeMensagemErro = true;

                  }
                },
                // gradient: const LinearGradient(
                //   colors: [Colors.lightBlue, Colors.purple],
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_forward),
                    Text('Entrar'),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _exibeMensagemErro,
              child: Text(
                'Usuário ou senha inválidos',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    ));
  }

  void checkIsLoggedIn() async {
    final appState = Provider.of<AppState>(context, listen: false);
    if (appState.logado) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }
}
