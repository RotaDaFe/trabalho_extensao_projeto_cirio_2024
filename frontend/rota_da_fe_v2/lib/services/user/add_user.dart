import 'package:rota_da_fe_v2/models/user.model.dart';
import 'package:rota_da_fe_v2/repository/database_helper.dart';

Future<int> addUser(
    {required SqfliteHelper dbHelper,
    required nome,
    required posto,
    required senha}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();
  // Criação do objeto User
  UserModel user = UserModel(
    nome: nome,
    posto: posto,
    senha: senha,
  );
  int res = await dbHelper.insertLogin(user.toMap());

  // Retorna uma lista de mapas simulando os dados do banco de dados
  return res;
}
