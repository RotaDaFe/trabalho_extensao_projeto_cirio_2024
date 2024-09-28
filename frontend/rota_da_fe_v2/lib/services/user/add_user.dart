import 'package:rota_da_fe_v2/config/database_helper.dart';

Future<int> addUser(
    {required SqfliteHelper dbHelper,
    required nome,
    required posto,
    required senha}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();
  Map<String, String> user = {
    "nome": nome,
    "posto": posto,
    "senha": senha,
  };
  int res = await dbHelper.insertLogin(user);

  // Retorna uma lista de mapas simulando os dados do banco de dados
  return res;
}
