import 'package:rota_da_fe_v2/models/romeiro.model.dart';
import 'package:rota_da_fe_v2/repository/database_helper.dart';

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

  RomeiroModel newUser = RomeiroModel(
      nome: nome,
      idade: idade,
      cidade: cidade,
      localDeAtendimento: localDeAtendimento,
      sexo: genero,
      patologia: patologia,
      updatedAt: DateTime.now().toIso8601String());

  int res = await dbHelper.updateUser(id, newUser.toMap());
  return res;
}
