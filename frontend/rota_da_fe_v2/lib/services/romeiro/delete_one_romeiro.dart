import 'package:rota_da_fe_v2/config/database_helper.dart';

Future deleteRomeiro({
  required SqfliteHelper dbHelper,
  required id,
}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  int res = await dbHelper.deleteUser(id);
  return res;
}
