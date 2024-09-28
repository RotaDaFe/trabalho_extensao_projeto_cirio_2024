import 'package:rota_da_fe_v2/config/database_helper.dart';

Future<int> updateUser(
    {required SqfliteHelper dbHelper,
    required id,
    required nome,
    required posto,
    required senha}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();
  Map<String, dynamic> user = {
    "nome": nome,
    "posto": posto,
    "senha": senha,
  };
  int res = await dbHelper.updateLogin(id, user);

  // Retorna uma lista de mapas simulando os dados do banco de dados
  return res;
}
