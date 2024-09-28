import 'package:rota_da_fe_v2/config/database_helper.dart';

Future<List> getAllRomeiros({required SqfliteHelper dbHelper}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  List data = await dbHelper.getAllUsers();

  // Retorna uma lista de mapas simulando os dados do banco de dados
  return data;
}
