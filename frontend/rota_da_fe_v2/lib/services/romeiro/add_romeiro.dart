import 'package:rota_da_fe_v2/config/database_helper.dart';

Future addRomeiro({
  required SqfliteHelper dbHelper,
  required nome,
  required idade,
  required cidade,
  required localDeAtendimento,
  required genero,
}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  Map<String, dynamic> newUser = {
    'nome': nome,
    'idade': idade,
    'cidade': cidade,
    'localDeAtendimento': localDeAtendimento,
    'sexo': genero,
    // 'data_cadastro': DateTime.now().toIso8601String(),
  };

  int res = await dbHelper.insertUser(newUser);
  return res;
}
