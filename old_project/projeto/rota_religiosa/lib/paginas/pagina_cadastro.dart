import 'package:flutter/material.dart';
import 'package:rota_religiosa/components/widget_bottomBar.dart';
import 'package:rota_religiosa/components/widget_buttom.dart';
import 'package:rota_religiosa/components/widget_drop_buttom_component.dart';
import 'package:rota_religiosa/components/widget_input_component.dart';
import 'package:rota_religiosa/components/widget_radio_component.dart';
import 'package:rota_religiosa/components/widget_titulo.dart';
import 'package:rota_religiosa/components/widget_topbar.dart';
import 'package:rota_religiosa/controller/router_settings.dart';
import 'package:rota_religiosa/model/database.dart';
import 'package:rota_religiosa/model/stream.dart';
import 'package:rota_religiosa/paginas/pagina_mensagem_sis_cad.dart';

//==============================
//StatefulWidget da página de Cadastro
class PaginaCadastro extends StatefulWidget {
  const PaginaCadastro({super.key});
//=====================================
//
  @override
  State<PaginaCadastro> createState() => _PaginaCadastroState();
}

//===================================
//Formulários de cadastro
class _PaginaCadastroState extends State<PaginaCadastro> {
  TextEditingController nomeCampo = TextEditingController();
  TextEditingController idadeCampo = TextEditingController();
  TextEditingController distanciaCampo = TextEditingController();
  StreamDados streamDados = StreamDados();
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    streamDados.atualizarcidade('');
    streamDados.atualizarOpSexo('');
    streamDados.atualizarListaAtendimento('');
    nomeCampo = TextEditingController(text: '');
    idadeCampo = TextEditingController(text: '');
  }

  bool erro = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 237, 182, 55),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEBE9EC),
          body: Column(
            children: [
              Widgettopbar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Título da página
                      WidgetTitulo(
                        titulo: 'CADASTRO',
                        height: 75,
                      ),
                      // Campo de texto 'Nome'
                      WidgetInputComponent(
                        campo: nomeCampo,
                        titulo: 'Nome',
                        mode: TextInputType.name,
                      ),
                      // Campo de texto 'Idade'
                      WidgetInputComponent(
                        idade: true,
                        modeFormater: true,
                        campo: idadeCampo,
                        titulo: 'Idade',
                        mode: TextInputType.number,
                      ),
                      // Campo de texto 'Cidade de Origem'
                      WidgetDropComponent(
                        campo: distanciaCampo,
                        titulo: 'Cidade de Origem',
                      ),
                      // Componente 'Atendimento'
                      WidgetRadioComponentAtendimento(
                        titulo: 'Atendimento',
                      ),
                      // Componente 'Sexo'
                      WidgetRadioComponentSexo(
                        titulo: 'Sexo',
                      ),
                      // Exibir erro se algum campo estiver vazio
                      !erro
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.only(top: 18, bottom: 4),
                              child: const Text(
                                'Preencha todos os campos',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                      // Botão 'Cadastrar'
                      Widgetbuttom(
                        titulo: 'Cadastrar',
                        onTap: () async {
                          if (nomeCampo.text.isNotEmpty &&
                              idadeCampo.text.isNotEmpty &&
                              streamDados.opSexo.isNotEmpty &&
                              streamDados.cidadex.isNotEmpty &&
                              streamDados.atendimento.isNotEmpty) {
                            try {
                              dynamic data = {
                                'nome': nomeCampo.text,
                                'idade': int.parse(idadeCampo.text),
                                'atendimento': streamDados.atendimento,
                                'sexo': streamDados.opSexo,
                                'distancia': streamDados.cidadex,
                              };
                              int result =
                                  await dbHelper.insertCad(data: data);
                              if (result != 0) {
                                config_rota().animacao_2(
                                  context,
                                  novaPagina: PaginoMensagemSistemaCad(
                                    error: false,
                                  ),
                                );
                              } else {
                                config_rota().animacao_2(
                                  context,
                                  novaPagina: PaginoMensagemSistemaCad(
                                    error: true,
                                  ),
                                );
                              }
                            } catch (e) {
                              config_rota().animacao_2(
                                context,
                                novaPagina: PaginoMensagemSistemaCad(
                                  error: true,
                                  error1: true,
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              erro = true;
                            });
                          }
                        },
                      ),
                      // Rodapé
                      const Widgetbottom(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
