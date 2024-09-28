import 'package:rota_da_fe_v2/config/database_helper.dart';

Future updateRomeiro(
    {required SqfliteHelper dbHelper,
    id,
    nome,
    idade,
    cidade,
    genero,
    localDeAtendimento}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  Map<String, String> user = {
    'nome': nome,
    'idade': idade.toString(),
    'cidade': cidade,
    'localDeAtendimento': localDeAtendimento,
    'sexo': genero,
  };

  int res = await dbHelper.updateUser(id, user);
  return res;
}
