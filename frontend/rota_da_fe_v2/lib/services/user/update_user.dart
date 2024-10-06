import 'package:rota_da_fe_v2/models/user.model.dart';
import 'package:rota_da_fe_v2/repository/database_helper.dart';

Future<int> updateUser(
    {required SqfliteHelper dbHelper,
    required id,
    required nome,
    required posto,
    required senha}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();
  UserModel user = UserModel(
    nome: nome,
    posto: posto,
    senha: senha,
  );

  int res = await dbHelper.updateLogin(id, user.toMap());

  return res;
}
