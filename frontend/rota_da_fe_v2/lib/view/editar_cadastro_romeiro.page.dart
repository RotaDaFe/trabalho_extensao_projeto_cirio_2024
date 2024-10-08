import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rota_da_fe_v2/components/build_textfield.dart';
import 'package:rota_da_fe_v2/components/button_type_a.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/repository/database_helper.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/messageAlerts/alerts.dart';
import 'package:rota_da_fe_v2/components/build_dropdown.dart';
import 'package:rota_da_fe_v2/services/cidades/data.dart';
import 'package:rota_da_fe_v2/view/inicio.page.dart';
import 'package:rota_da_fe_v2/services/patologias/data.dart';
import 'package:rota_da_fe_v2/services/romeiro/delete_one_romeiro.dart';
import 'package:rota_da_fe_v2/services/romeiro/get_one_romeiro.dart';
import 'package:rota_da_fe_v2/services/romeiro/update_romeiro.dart';

class PageEditarCadastroRomeiro extends StatefulWidget {
  final int userId; // Receberá o ID do romeiro a ser editado

  const PageEditarCadastroRomeiro({required this.userId, super.key});

  @override
  State<PageEditarCadastroRomeiro> createState() =>
      _PageEditarCadastroRomeiroState();
}

class _PageEditarCadastroRomeiroState extends State<PageEditarCadastroRomeiro> {
  int id = 0;
  final SqfliteHelper dbHelper = SqfliteHelper();
  bool isLoading = true; // Variável para controlar o estado de carregamento
  List<String> locaDeAtendimento = ["Selecione", "casa de placido", "tribunal"];
  List<String> sexo = ["Selecione", "Feminino", "Masculino", "Outros"];

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerIdade = TextEditingController();
  TextEditingController dropdownControllerLocalDeAtendimento =
      TextEditingController();
  TextEditingController dropdownControllerCidade = TextEditingController();
  TextEditingController dropdownControllerSexo = TextEditingController();
  TextEditingController dropdowncontrollerCondicaoFisica =
      TextEditingController();
  TextEditingController controllerCondicaoFisica = TextEditingController();
  bool inputPersonalizado = false;

  @override
  void initState() {
    super.initState();
    _loadRomeiroData(); // Carregar os dados do romeiro ao iniciar a página
  }

  Future<void> _loadRomeiroData() async {
    Map<String, dynamic> romeiroData = await getRomeiroById(
      dbHelper: dbHelper,
      userId: widget.userId,
    );

    // Preenche os campos com os dados do romeiro

    var condicaoFisica = romeiroData['patologia'];
    //
    // verifica se condição fisica existe em patologiasMaisVistas
    if (patologiasMaisVistas.contains(condicaoFisica)) {
      setState(() {
        dropdowncontrollerCondicaoFisica.text = condicaoFisica;
        inputPersonalizado = false;
      });
    } else {
      // caso não exista
      setState(() {
        dropdowncontrollerCondicaoFisica.text = "Outros";
        controllerCondicaoFisica.text = condicaoFisica;
        inputPersonalizado = true;
      });
    }
    // set os demais estados
    setState(() {
      id = romeiroData['id'];
      controllerNome.text = romeiroData['nome'];
      controllerIdade.text = romeiroData['idade'].toString();
      dropdownControllerCidade.text = romeiroData['cidade'];
      dropdownControllerLocalDeAtendimento.text =
          romeiroData['localDeAtendimento'];
      dropdownControllerSexo.text = romeiroData['sexo'];

      // Depois que os dados são carregados, desativa o estado de carregamento
      isLoading = false;
    });
  }

  // Função para mostrar o QuickAlert de confirmação
  Future<void> _showDeleteConfirmation(BuildContext context) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Confirmar exclusão',
      text: 'Tem certeza que deseja deletar este romeiro?',
      confirmBtnText: 'Sim',
      cancelBtnText: 'Não',
      onConfirmBtnTap: () async {
        // Deleta o romeiro
        await deleteRomeiro(dbHelper: dbHelper, id: widget.userId);
        alertSucessDelete(context);
        Navigator.pop(context); // Fechar o QuickAlert
        navigateAndRemoveUntil(context, const PageInicio()); // Navegar de volta
      },
      onCancelBtnTap: () {
        Navigator.pop(context); // Fechar o QuickAlert se o usuário cancelar
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double margem = 100.0;

    return Container(
      color: Color(0xffEDB637).withOpacity(.58),
      child: SafeArea(
          child: Scaffold(
        body: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Mostra o indicador de carregamento
            : SingleChildScrollView(
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
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            const Center(
                              child: Text(
                                "EDITAR CADASTRO",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff427443)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            buildTextField(
                                keyboardType: TextInputType.name,
                                label: "Nome",
                                controller: controllerNome,
                                width: largura),
                            buildTextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
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
                                initialValue:
                                    dropdownControllerCidade.text.isNotEmpty
                                        ? dropdownControllerCidade.text
                                        : "Selecione",
                                width: largura),
                            buildDropdownButton(
                                onChanged: () {},
                                label: "Sexo",
                                items: sexo, // Lista de opções
                                controller: dropdownControllerSexo,
                                initialValue:
                                    dropdownControllerSexo.text.isNotEmpty
                                        ? dropdownControllerSexo.text
                                        : "Selecione",
                                width: largura),
                            buildDropdownButton(
                                onChanged: () {},
                                label: "Local de atendimento",
                                items: locaDeAtendimento, // Lista de opções
                                controller:
                                    dropdownControllerLocalDeAtendimento,
                                initialValue:
                                    dropdownControllerLocalDeAtendimento
                                            .text.isNotEmpty
                                        ? dropdownControllerLocalDeAtendimento
                                            .text
                                        : "Selecione",
                                width: largura),

                            // verifique se foi selecionado "Outros"
                            // caso sim então exiba o input personalizado

                            buildDropdownButton(
                                label: "Condição Física",
                                items: patologiasMaisVistas, // Lista de opções
                                controller: dropdowncontrollerCondicaoFisica,
                                initialValue: dropdowncontrollerCondicaoFisica
                                        .text.isNotEmpty
                                    ? dropdowncontrollerCondicaoFisica.text
                                    : "Selecione",
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
                                text: "Atualizar",
                                ontap: () async {
                                  if (controllerNome.text.isNotEmpty &&
                                      controllerIdade.text.isNotEmpty &&
                                      dropdownControllerCidade.text !=
                                          'Selecione' &&
                                      dropdownControllerLocalDeAtendimento
                                              .text !=
                                          'Selecione' &&
                                      dropdownControllerSexo.text !=
                                          'Selecione' &&
                                      dropdowncontrollerCondicaoFisica.text !=
                                          'Selecione') {
                                    //
                                    // verifica se o input personalizado ta ativado
                                    if (inputPersonalizado) {
                                      //
                                      // veerifica se  controller CondicaoFisica tem algo
                                      if (controllerCondicaoFisica
                                          .text.isEmpty) {
                                        alertFailField(context);
                                      } else {
                                        //
                                        // Caso input personalizado esteja ativado E controller esteja preenchido
                                        // então rode
                                        alertSucess(context);
                                        // falta atualizar

                                        await updateRomeiro(
                                            id: id,
                                            dbHelper: dbHelper,
                                            nome: controllerNome.text,
                                            idade:
                                                int.parse(controllerIdade.text),
                                            cidade:
                                                dropdownControllerCidade.text,
                                            localDeAtendimento:
                                                dropdownControllerLocalDeAtendimento
                                                    .text,
                                            genero: dropdownControllerSexo.text,
                                            patologia:
                                                controllerCondicaoFisica.text);
                                        // ignore: use_build_context_synchronously
                                        navigateAndRemoveUntil(
                                            context, const PageInicio());
                                      }
                                    } else {
                                      // caso o  input personalizado esteja desativado
                                      // então rodee
                                      alertSucess(context);
                                      await updateRomeiro(
                                          id: id,
                                          dbHelper: dbHelper,
                                          nome: controllerNome.text,
                                          idade:
                                              int.parse(controllerIdade.text),
                                          cidade: dropdownControllerCidade.text,
                                          localDeAtendimento:
                                              dropdownControllerLocalDeAtendimento
                                                  .text,
                                          genero: dropdownControllerSexo.text,
                                          patologia:
                                              dropdowncontrollerCondicaoFisica
                                                  .text);
                                      // ignore: use_build_context_synchronously
                                      navigateAndRemoveUntil(
                                          context, const PageInicio());
                                    }
                                  } else {
                                    alertFailField(context);
                                  }
                                }),
                            const SizedBox(height: 20),
                            // Botão de deletar romeiro
                            buttonTypeA(
                              text: "Deletar",
                              ontap: () async {
                                _showDeleteConfirmation(context);
                              },
                              color: const Color.fromARGB(
                                  218, 244, 67, 54), // Botão vermelho
                            ),
                          ],
                        ),
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
