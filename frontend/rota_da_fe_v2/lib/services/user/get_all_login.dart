import 'package:rota_da_fe_v2/repository/database_helper.dart';

Future<List> getAllLogin({required SqfliteHelper dbHelper}) async {
  // SqfliteHelper dbHelper = SqfliteHelper();

  List data = await dbHelper.getAllLogins();

  return data;
}
