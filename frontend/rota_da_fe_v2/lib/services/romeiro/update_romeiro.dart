import 'package:rota_da_fe_v2/config/database_helper.dart';

Future updateRomeiro(
    {required SqfliteHelper dbHelper,
    required id,
    required nome,
    required idade,
    required cidade,
    required genero,
    required patologia,
    required localDeAtendimento}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  Map<String, String> user = {
    'nome': nome,
    'idade': idade.toString(),
    'cidade': cidade,
    'localDeAtendimento': localDeAtendimento,
    'sexo': genero,
    'patologia': patologia,
    'updatedAt': DateTime.now().toIso8601String()
  };

  int res = await dbHelper.updateUser(id, user);
  return res;
}
