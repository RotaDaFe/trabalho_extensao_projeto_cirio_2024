import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/build_textfield.dart';
import 'package:rota_da_fe_v2/components/button_type_a.dart';
// PageCadastroRomeiro
// String? selectedCity;
// String? selectedLocation;
// String? gender;

import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/messageAlerts/alerts.dart';
import 'package:rota_da_fe_v2/components/build_dropdown.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';
import 'package:rota_da_fe_v2/services/cidades/data.dart';
import 'package:rota_da_fe_v2/services/patologias/data.dart';
import 'package:rota_da_fe_v2/services/romeiro/add_romeiro.dart';

class PageCadastroRomeiro extends StatefulWidget {
  const PageCadastroRomeiro({super.key});

  @override
  State<PageCadastroRomeiro> createState() => _PageCadastroRomeiroState();
}

class _PageCadastroRomeiroState extends State<PageCadastroRomeiro> {
  SqfliteHelper dbHelper = SqfliteHelper();

  List<String> locaDeAtendimento = ["Selecione", "casa de placido", "tribunal"];
  List<String> sexo = ["Selecione", "Feminino", "Masculino", "Outros"];

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerIdade = TextEditingController();
  TextEditingController dropdowncontrollerCondicaoFisica =
      TextEditingController();
  TextEditingController controllerCondicaoFisica = TextEditingController();
  TextEditingController dropdownControllerLocalDeAtendimento =
      TextEditingController();
  TextEditingController dropdownControllerCidade = TextEditingController();
  TextEditingController dropdownControllerSexo = TextEditingController();
  List<String> patologiaMaisVistas = patologiasMaisVistas;
  bool inputPersonalizado = false;
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
                        keyboardType: TextInputType.name,
                        label: "Nome",
                        controller: controllerNome,
                        width: largura),
                    buildTextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        label: "Idade",
                        isNumber: true,
                        controller: controllerIdade,
                        width: largura),
                    buildDropdownButton(
                        onChanged: () {},
                        label: "Cidade",
                        items: cidades, // Lista de opções
                        controller: dropdownControllerCidade,
                        initialValue: "Selecione",
                        width: largura),
                    buildDropdownButton(
                        onChanged: () {},
                        label: "Sexo",
                        items: sexo, // Lista de opções
                        controller: dropdownControllerSexo,
                        initialValue: "Selecione",
                        width: largura),
                    buildDropdownButton(
                        onChanged: () {},
                        label: "Local de atendimento",
                        items: locaDeAtendimento, // Lista de opções
                        controller: dropdownControllerLocalDeAtendimento,
                        initialValue: "Selecione",
                        width: largura),
                    // verifique se foi selecionado "Outros"
                    // caso sim então exiba o input personalizado

                    buildDropdownButton(
                        label: "Condição Física",
                        items: patologiaMaisVistas, // Lista de opções
                        controller: dropdowncontrollerCondicaoFisica,
                        initialValue: "Selecione",
                        width: largura,
                        onChanged: () {
                          setState(() {
                            inputPersonalizado =
                                dropdowncontrollerCondicaoFisica.text ==
                                    "Outros";
                          });
                        }),
                    inputPersonalizado
                        ? buildTextField(
                            keyboardType: TextInputType.text,
                            label: "Condição Física",
                            controller: controllerCondicaoFisica,
                            width: largura)
                        : Container(),
                    const SizedBox(height: 20),
                    buttonTypeA(
                        text: "Cadastrar",
                        ontap: () async {
                          // verifica se os campos estão preenchidos
                          if (controllerNome.text.isNotEmpty &&
                              controllerIdade.text.isNotEmpty &&
                              dropdownControllerCidade.text != 'Selecione' &&
                              dropdownControllerLocalDeAtendimento.text !=
                                  'Selecione' &&
                              dropdownControllerSexo.text != 'Selecione' &&
                              dropdowncontrollerCondicaoFisica.text !=
                                  'Selecione' &&
                              dropdowncontrollerCondicaoFisica
                                  .text.isNotEmpty &&
                              dropdownControllerLocalDeAtendimento
                                  .text.isNotEmpty &&
                              dropdownControllerSexo.text.isNotEmpty) {
                            //
                            // verifica se o input personalizado ta ativado
                            if (inputPersonalizado) {
                              //
                              // veerifica se  controller CondicaoFisica tem algo
                              if (controllerCondicaoFisica.text.isEmpty) {
                                alertFailField(context);
                              } else {
                                //
                                // Caso input personalizado esteja ativado E controller esteja preenchido
                                // então rode
                                alertSucess(context);
                                // falta atualizar
                                await addRomeiro(
                                    dbHelper: dbHelper,
                                    nome: controllerNome.text,
                                    idade: controllerIdade.text,
                                    cidade: dropdownControllerCidade.text,
                                    localDeAtendimento:
                                        dropdownControllerLocalDeAtendimento
                                            .text,
                                    genero: dropdownControllerSexo.text,
                                    patologia: controllerCondicaoFisica.text);
                                // ignore: use_build_context_synchronously
                                navigateAndRemoveUntil(
                                    context, const PageInicio());
                              }
                            } else {
                              // caso o  input personalizado esteja desativado
                              // então rodee
                              alertSucess(context);
                              // falta atualizar
                              await addRomeiro(
                                  dbHelper: dbHelper,
                                  nome: controllerNome.text,
                                  idade: controllerIdade.text,
                                  cidade: dropdownControllerCidade.text,
                                  localDeAtendimento:
                                      dropdownControllerLocalDeAtendimento.text,
                                  genero: dropdownControllerSexo.text,
                                  patologia:
                                      dropdowncontrollerCondicaoFisica.text);
                              // ignore: use_build_context_synchronously
                              navigateAndRemoveUntil(
                                  context, const PageInicio());
                            }
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
