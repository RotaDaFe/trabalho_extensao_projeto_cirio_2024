import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/component_identificador.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/pages/editar_cadastro_romeiro.page.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';
import 'package:rota_da_fe_v2/services/romeiro/get_all_romeiro.dart';
import 'package:rota_da_fe_v2/services/text/truncate_text.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/services/user/get_all_login.dart'; // Importa o helper do banco de dados

class PageMostraCadastros extends StatefulWidget {
  const PageMostraCadastros({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageMostraCadastrosState createState() => _PageMostraCadastrosState();
}

class _PageMostraCadastrosState extends State<PageMostraCadastros> {
  final SqfliteHelper dbHelper =
      SqfliteHelper(); // Instância do helper do banco de dados
  List<dynamic> usuarios = []; // Lista que conterá os usuários vindos do banco
  List<dynamic> usuariosApp =
      []; // Lista que conterá os usuários vindos do banco

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Carregar os dados do banco ao iniciar
    _loadUserApp(); // Carregar os dados do banco ao iniciar
  }

  Future<void> _loadUsers() async {
    // Busca todos os usuários do banco
    List<dynamic> data = await getAllRomeiros(dbHelper: dbHelper);
    setState(() {
      usuarios = data; // Atualiza a lista de usuários
    });
  }

  Future<void> _loadUserApp() async {
    // Busca todos os usuários do banco
    List<dynamic> data = await getAllLogin(dbHelper: dbHelper);
    setState(() {
      usuariosApp = data; // Atualiza a lista de usuários
    });
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double margem = 100.0;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(
              onTap: () {
                navigateAndRemoveUntil(context, const PageInicio());
              },
              height: 80.0,
            ),
            Expanded(
              child: usuariosApp.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(child: SizedBox(height: 30)),
                          const SliverToBoxAdapter(
                              child: Center(
                            child: Text("Cadastrados",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(218, 66, 116, 67),
                                )),
                          )),
                          const SliverToBoxAdapter(child: SizedBox(height: 30)),
                          SliverToBoxAdapter(
                            child: componentIdentificador(
                              width: largura,
                              margem: margem,
                              email: usuariosApp[0]['nome'],
                              bloco: usuariosApp[0]['posto'],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 20),
                          ),
                          SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Número de colunas na grade
                              crossAxisSpacing: 10, // Espaçamento entre colunas
                              mainAxisSpacing: 10, // Espaçamento entre linhas
                              childAspectRatio:
                                  0.7, // Proporção dos itens (altura/largura)
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // Dados do usuário
                                final user = usuarios[index];
                                return itemUser(
                                  ontap: () {
                                    Navigator.of(context).push(
                                        SlideTransitionPage(
                                            page: PageEditarCadastroRomeiro(
                                                userId: user['id'])));
                                  },
                                  width: (largura - margem - 10) / 2,
                                  nome: user['nome'],
                                  idade: user['idade'],
                                  sexo: user['sexo'],
                                  cidade: user['cidade'],
                                );
                              },
                              childCount: usuarios.length,
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 40),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 80),
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text(
                            "verifique se existe algum\ndado cadastrado",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ), // Mostra um indicador de carregamento enquanto os dados são carregados
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemUser(
    {required Function ontap,
    required double width,
    required String nome,
    required int idade,
    required String sexo,
    required String cidade}) {
  nome = truncateText(nome, maxLength: 20);
  cidade = truncateText(cidade, maxLength: 8);
  // "Feminino", "Masculino", "Outros"
  sexo = sexo[0];
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Container(
      height: 200,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1), // Cor da sombra
            offset: const Offset(0, 4), // Deslocamento da sombra
            blurRadius: 4, // Desfoque
            spreadRadius: 0, // Expansão da sombra
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 100,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/imageIlustator.png"),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            flex: 40,
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  nome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 40,
            child: Container(
              padding: const EdgeInsets.all(2),
              child: AutoSizeText("Idade: $idade Sexo: $sexo Cidade: $cidade"),
            ),
          ),
        ],
      ),
    ),
  );
}
