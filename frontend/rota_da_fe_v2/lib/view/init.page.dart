import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/build_textfield.dart';
import 'package:rota_da_fe_v2/components/button_type_a.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/repository/database_helper.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/messageAlerts/alerts.dart';
import 'package:rota_da_fe_v2/view/inicio.page.dart';
import 'package:rota_da_fe_v2/services/user/add_user.dart';

class PageInit extends StatefulWidget {
  const PageInit({super.key});

  @override
  State<PageInit> createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {
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
                  disable_icon: true,
                  onTap: () {
                    // navigateAndRemoveUntil(context, const PageInicio());
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
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        label: "Senha",
                        controller: controllerSenha,
                        width: largura),
                    const SizedBox(height: 20),
                    buttonTypeA(
                        text: "Iniciar app",
                        ontap: () async {
                          if (controllerEmail.text.isNotEmpty &&
                              controllerBloco.text.isNotEmpty &&
                              controllerSenha.text.isNotEmpty) {
                            alertSucess(context);
                            await addUser(
                                dbHelper: dbHelper,
                                nome: controllerEmail.text,
                                posto: controllerBloco.text,
                                senha: controllerSenha.text);
                            navigateAndRemoveUntil(context, const PageInicio());
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
