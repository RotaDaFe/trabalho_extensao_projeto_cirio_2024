import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rota_da_fe_v2/models/romeiro.model.dart';
import 'package:rota_da_fe_v2/repository/database_helper.dart';
import 'package:rota_da_fe_v2/services/romeiro/get_all_romeiro.dart';
import 'package:rota_da_fe_v2/services/user/get_all_login.dart';

Future<int> exportDatabase({required SqfliteHelper dbHelper}) async {
  try {
    // Resgata os dados do usuário (login)
    List user = await getAllLogin(dbHelper: dbHelper);
    List data = await getAllRomeiros(dbHelper: dbHelper);
    List<Map<String, dynamic>> dataQuery = [];

    // Verifica se há romeiros cadastrados
    if (data.isEmpty) {
      return 404; // Retorna código 404 se não houver romeiros cadastrados
    }

    for (var e in data) {
      // Converte cada entrada da lista de romeiros para um RomeiroModel
      RomeiroModel romeiro = RomeiroModel.fromMap(e);

      // Adiciona ao dataQuery o objeto convertido em mapa
      dataQuery.add({
        'idUser': user[0]['nome'], // Usa o nome do usuário logado
        'nome': romeiro.nome,
        'idade': romeiro.idade,
        'cidade': romeiro.cidade,
        'localDeAtendimento': romeiro.localDeAtendimento,
        'sexo': romeiro.sexo,
        'patologia': romeiro.patologia,
        'createdAt': romeiro.createdAt ?? '',
        'updatedAt': romeiro.updatedAt ?? '',
      });
    }

    Map<String, dynamic> bodyRequest = {
      "romeiros": dataQuery,
      "password": user[0]['senha'], // Usa a senha do usuário logado
    };

    // Envio para o servidor (API)
    var baseURL = "https://api-cirio-2024.netlify.app";
    // Debug
    // var baseURL = "http://192.168.1.36:3000";
    var url = Uri.parse('$baseURL/api/romeiros');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(bodyRequest),
    );
    // Retorna o status code
    return response.statusCode == 200 || response.statusCode == 201
        ? response.statusCode
        : response.statusCode;
  } catch (e) {
    return 500; // Retorna erro genérico em caso de exceção
  }
}

Future<String> exportDatabaseCopy({required SqfliteHelper dbHelper}) async {
  try {
    // Resgata os dados do usuário (login)
    List<dynamic> user = await getAllLogin(dbHelper: dbHelper);
    List<dynamic> data = await getAllRomeiros(dbHelper: dbHelper);
    List<Map<String, dynamic>> dataQuery = [];

    for (var e in data) {
      // Converte cada entrada da lista de romeiros para um RomeiroModel
      RomeiroModel romeiro = RomeiroModel.fromMap(e);

      // Adiciona ao dataQuery o objeto convertido em mapa
      dataQuery.add({
        'idUser': user[0]['nome'], // Usa o nome do usuário logado
        'nome': romeiro.nome,
        'idade': romeiro.idade.toString(),
        'cidade': romeiro.cidade,
        'localDeAtendimento': romeiro.localDeAtendimento,
        'sexo': romeiro.sexo,
        'patologia': romeiro.patologia,
        'createdAt': romeiro.createdAt ?? '',
        'updatedAt': romeiro.updatedAt ?? '',
      });
    }

    Map<String, dynamic> bodyRequest = {
      "romeiros": dataQuery,
    };

    // Retorna o JSON gerado
    return json.encode(bodyRequest);
  } catch (e) {
    return "";
  }
}
