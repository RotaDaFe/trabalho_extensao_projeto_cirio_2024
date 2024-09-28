import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/build_textfield.dart';
import 'package:rota_da_fe_v2/components/button_type_a.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/messageAlerts/alerts.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';
import 'package:rota_da_fe_v2/services/user/get_all_login.dart';
import 'package:rota_da_fe_v2/services/user/update_user.dart';

class PageEditeUser extends StatefulWidget {
  const PageEditeUser({super.key});

  @override
  State<PageEditeUser> createState() => _PageEditeUserState();
}

class _PageEditeUserState extends State<PageEditeUser> {
  SqfliteHelper dbHelper = SqfliteHelper();
  List<String> locaDeAtendimento = ["Selecione", "casa de placido", "tribunal"];
  List<String> sexo = ["Selecione", "Feminino", "Masculino", "Outros"];

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerBloco = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController dropdownControllerLocalDeAtendimento =
      TextEditingController();
  TextEditingController dropdownControllerCidade = TextEditingController();
  TextEditingController dropdownControllerSexo = TextEditingController();
  String? selectedCity;
  String? selectedLocation;
  String? gender;

  @override
  void initState() {
    super.initState();

    // Buscar dados do banco de dados e preencher os campos
    getAllLogin(dbHelper: dbHelper).then((data) {
      if (data.isNotEmpty) {
        setState(() {
          // Supondo que 'data' retorne um mapa ou lista com os dados de login
          controllerEmail.text = data[0]['nome'] ?? '';
          controllerBloco.text = data[0]['posto'] ?? '';
          controllerSenha.text = data[0]['senha'] ?? '';
        });
      }
    }).catchError((error) {
      // Em caso de erro, você pode lidar com a exceção aqui
      // print('Erro ao buscar dados do login: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double margem = 100.0;
    return Container(
      color: Color(0xffEDB637).withOpacity(.58),
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(
                  onTap: () {
                    navigateAndRemoveUntil(context, const PageInicio());
                  },
                  height: 80.0),
              Center(
                child: SizedBox(
                  width: largura > 400 ? 400 - 50 : (largura - margem),
                  child: Column(children: [
                    const SizedBox(height: 30),
                    const Center(
                        child: Text("CADASTRO",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff427443)))),
                    const SizedBox(height: 15),
                    buildTextField(
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        label: "Email",
                        controller: controllerEmail,
                        width: largura),
                    buildTextField(
                        keyboardType: TextInputType.text,
                        label: "Bloco",
                        controller: controllerBloco,
                        width: largura),
                    buildTextField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        label: "Senha",
                        controller: controllerSenha,
                        width: largura),
                    const SizedBox(height: 20),
                    buttonTypeA(
                        text: "Editar cadastro",
                        ontap: () async {
                          if (controllerEmail.text.isNotEmpty &&
                              controllerBloco.text.isNotEmpty &&
                              controllerSenha.text.isNotEmpty) {
                            alertSucessUpdate(context);
                            await updateUser(
                                dbHelper: dbHelper,
                                id: 1,
                                nome: controllerEmail.text,
                                posto: controllerBloco.text,
                                senha: controllerSenha.text);
                            Navigator.of(context).pop();
                          } else {
                            alertFailField(context);
                          }
                        })
                  ]),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      )),
    );
  }
}
