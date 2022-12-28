class Usuario {
  String cpf;
  String senha;
  String nivelAcesso;

  Usuario({required this.cpf, required this.senha, required this.nivelAcesso});

  bool senhaValida(String senhaInformada) {
    return senhaInformada == senha;
  }
}
