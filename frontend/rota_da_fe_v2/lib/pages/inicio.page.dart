import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/banner_indicator.dart';
import 'package:rota_da_fe_v2/components/buttton_dropdow.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/components/section_logo_extensao.dart';
import 'package:rota_da_fe_v2/components/walpaper_background.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page.dart';
import 'package:rota_da_fe_v2/pages/cadastro_romeiro.page.dart';
import 'package:rota_da_fe_v2/pages/configuracao.page.dart';
import 'package:rota_da_fe_v2/pages/mostraCadastros.page.dart';
import 'package:rota_da_fe_v2/pages/sobre.page.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart'; // Importa o helper do banco de dados

class PageInicio extends StatefulWidget {
  const PageInicio({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageInicioState createState() => _PageInicioState();
}

class _PageInicioState extends State<PageInicio> {
  final SqfliteHelper dbHelper = SqfliteHelper();

  // Função para buscar o número de usuários cadastrados
  Future<int> _getUserCount() async {
    List<dynamic> usuarios = await dbHelper.getAllUsers();
    return usuarios.length; // Retorna a quantidade de usuários
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
                    // navigateAndRemoveUntil(context, PageInicio());
                  },
                  height: 80.0,
                ),
                // Usar FutureBuilder para buscar e exibir o número de usuários cadastrados
                FutureBuilder<int>(
                  future: _getUserCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Exibe um indicador de carregamento enquanto os dados estão sendo buscados
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Se houver erro, exibe uma mensagem
                      return const Center(
                          child: Text('Erro ao carregar dados.'));
                    } else {
                      // Exibe o número de usuários cadastrados
                      return walpaperBackground(
                        width: largura,
                        image: "images/banner1.png",
                        child: bannerIndicator(
                          text: snapshot.data.toString(), // Número de usuários
                          width:
                              largura > 400.0 ? 400.0 - 50 : (largura - margem),
                        ),
                      );
                    }
                  },
                ),
                Center(
                  child: SizedBox(
                    width: largura > 400 ? 400 - 50 : (largura - margem),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: butttonDropdow(
                            width: largura - margem,
                            ontap: () {
                              Navigator.of(context).push(SlideTransitionPage(
                                  page: const PageCadastroRomeiro()));
                            },
                            text: "Cadastrar participantes",
                            textSub: "Clique e saiba mais",
                            icon: Icons.group_add,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: butttonDropdow(
                            width: largura - 100,
                            ontap: () {
                              Navigator.of(context).push(SlideTransitionPage(
                                  page: const PageMostraCadastros()));
                            },
                            text: "Visualizar cadastros",
                            textSub: "Clique e saiba mais",
                            icon: Icons.dashboard,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: butttonDropdow(
                            width: largura - 100,
                            ontap: () {
                              Navigator.of(context).push(SlideTransitionPage(
                                  page: const PageSobreApp()));
                            },
                            text: "Sobre o app",
                            textSub: "Clique e saiba mais",
                            icon: Icons.view_timeline,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: butttonDropdow(
                            width: largura - 100,
                            ontap: () {
                              Navigator.of(context).push(SlideTransitionPage(
                                  page: const PageConfiguracao()));
                            },
                            text: "Configuração",
                            textSub: "Clique e saiba mais",
                            icon: Icons.settings,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                sectionLogoExtensao(),
                const SizedBox(height: 15),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
