import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/services/romeiro/get_all_romeiro.dart';
import 'package:rota_da_fe_v2/services/user/get_all_login.dart';

Future<int> exportDatabase({required SqfliteHelper dbHelper}) async {
  try {
    // resgata os dados do meu login
    List<dynamic> user = await getAllLogin(dbHelper: dbHelper);
    // resgata os dados do meus pacientes
    List<dynamic> data = await getAllRomeiros(dbHelper: dbHelper);
    List dataQuery = [];

    // Verifica se há romeiros cadastrados
    if (data.isEmpty) {
      return 404; // Retorna código 404 se não houver romeiros cadastrados
    }

    Map<String, dynamic> usuario = {
      'idUser': user[0]['nome'],
      'nome': '',
      'idade': '',
      'cidade': '',
      'localDeAtendimento': '',
      'sexo': '',
      'patologia': '',
      'createdAt': '',
      'updatedAt': '',
    };
// createdAt
    for (var e in data) {
      usuario['nome'] = e['nome'];
      usuario['idade'] = e['idade'];
      usuario['cidade'] = e['cidade'];
      usuario['localDeAtendimento'] = e['localDeAtendimento'];
      usuario['sexo'] = e['sexo'];
      usuario['patologia'] = e['patologia'];
      usuario['createdAt'] = e['createdAt'];
      usuario['updatedAt'] = e['updatedAt'];
      dataQuery.add(usuario);
      usuario = {
        'idUser': user[0]['nome'],
        'nome': '',
        'idade': '',
        'cidade': '',
        'localDeAtendimento': '',
        'sexo': '',
        'patologia': '',
        'createdAt': '',
        'updatedAt': '',
      };
    }
    Map<String, dynamic> bodyRequest = {
      "romeiros": dataQuery,
      "password": user[0]['senha']
    };
    // server
    var baseURL = "https://api-cirio-2024.netlify.app";
    // local
    // var baseURL = "http://192.168.1.36:3000";
    var url = Uri.parse('$baseURL/api/romeiros');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(bodyRequest),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  } catch (e) {
    return 500;
  }
}

Future exportDatabaseCopy({required SqfliteHelper dbHelper}) async {
  try {
    // resgata os dados do meu login
    List<dynamic> user = await getAllLogin(dbHelper: dbHelper);
    // resgata os dados do meus pacientes
    List<dynamic> data = await getAllRomeiros(dbHelper: dbHelper);
    List dataQuery = [];
    Map<String, dynamic> usuario = {
      'idUser': user[0]['nome'],
      'nome': '',
      'idade': '',
      'cidade': '',
      'localDeAtendimento': '',
      'sexo': '',
      'patologia': '',
      'createdAt': '',
      'updatedAt': '',
    };

    for (var e in data) {
      usuario['nome'] = e['nome'];
      usuario['idade'] = e['idade'];
      usuario['cidade'] = e['cidade'];
      usuario['localDeAtendimento'] = e['localDeAtendimento'];
      usuario['sexo'] = e['sexo'];
      usuario['patologia'] = e['patologia'];
      usuario['createdAt'] = e['createdAt'];
      usuario['updatedAt'] = e['updatedAt'];
      dataQuery.add(usuario);
      usuario = {
        'idUser': user[0]['nome'],
        'nome': '',
        'idade': '',
        'cidade': '',
        'localDeAtendimento': '',
        'sexo': '',
        'patologia': '',
        'createdAt': '',
        'updatedAt': '',
      };
    }
    Map<String, dynamic> bodyRequest = {
      "romeiros": dataQuery,
    };
    return json.encode(bodyRequest);
  } catch (e) {
    return "";
  }
}
