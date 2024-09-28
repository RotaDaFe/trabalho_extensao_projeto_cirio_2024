import 'package:rota_da_fe_v2/config/database_helper.dart';

Future<List> getAllLogin({required SqfliteHelper dbHelper}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  List data = await dbHelper.getAllLogins();

  // Retorna uma lista de mapas simulando os dados do banco de dados
  return data;
}
