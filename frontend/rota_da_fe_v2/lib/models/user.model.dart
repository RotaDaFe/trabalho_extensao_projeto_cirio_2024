class UserModel {
  String nome;
  String posto;
  String senha;

  // Construtor da classe
  UserModel({
    required this.nome,
    required this.posto,
    required this.senha,
  });

  // Método que cria um objeto User a partir de um Map
  factory UserModel.fromMap(Map<String, String> map) {
    return UserModel(
      nome: map['nome'] ?? '',
      posto: map['posto'] ?? '',
      senha: map['senha'] ?? '',
    );
  }

  // Método que converte o objeto User em um Map
  Map<String, String> toMap() {
    return {
      'nome': nome,
      'posto': posto,
      'senha': senha,
    };
  }
}
