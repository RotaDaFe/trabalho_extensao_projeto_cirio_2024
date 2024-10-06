class RomeiroModel {
  String nome;
  int idade;
  String cidade;
  String localDeAtendimento;
  String sexo;
  String patologia;
  String? createdAt; // Campo opcional
  String? updatedAt; // Campo opcional

  // Construtor da classe RomeiroModel
  RomeiroModel({
    required this.nome,
    required this.idade,
    required this.cidade,
    required this.localDeAtendimento,
    required this.sexo,
    required this.patologia,
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
  });

  // Método que cria um objeto RomeiroModel a partir de um Map
  factory RomeiroModel.fromMap(Map<String, dynamic> map) {
    return RomeiroModel(
      nome: map['nome'] ?? '',
      idade: map['idade'] ?? 0,
      cidade: map['cidade'] ?? '',
      localDeAtendimento: map['localDeAtendimento'] ?? '',
      sexo: map['sexo'] ?? '',
      patologia: map['patologia'] ?? '',
      createdAt:
          map['createdAt'] as String?, // Converte explicitamente para String?
      updatedAt:
          map['updatedAt'] as String?, // Converte explicitamente para String?
    );
  }

  // Método que converte um objeto RomeiroModel em um Map
  Map<String, dynamic> toMap() {
    final map = {
      'nome': nome,
      'idade': idade,
      'cidade': cidade,
      'localDeAtendimento': localDeAtendimento,
      'sexo': sexo,
      'patologia': patologia,
    };

    // Adiciona os campos opcionais somente se eles não forem nulos
    if (createdAt != null) {
      map['createdAt'] = createdAt as dynamic; // Faz casting para dynamic
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt as dynamic; // Faz casting para dynamic
    }

    return map;
  }
}
