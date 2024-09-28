import 'package:rota_religiosa/controller/router_settings.dart';
import 'package:rota_religiosa/pages/pagina_cadastro.dart';
import 'package:rota_religiosa/pages/pagina_config.dart';
import 'package:rota_religiosa/pages/pagina_consulta.dart';
import 'package:rota_religiosa/pages/pagina_mensagem_sis_suporte.dart';
import 'package:flutter/material.dart';

//=======================================
//Componentes para página de menu
//=======================================

class Widgetmenu extends StatelessWidget {
  const Widgetmenu({super.key});

  get child => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 500,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                //Total de Cadastros
                const SizedBox(height: 15),

                Stack(
                  children: [
                    // Imagem com filtro
                    Positioned.fill(
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(
                              0.5), // Aplica uma cor preta com 50% de opacidade
                          BlendMode.darken, // Modo de mesclagem para escurecer
                        ),
                        child: Image.asset(
                          'assets/image 33.png', // Caminho correto da imagem
                          fit: BoxFit.cover, // Para cobrir todo o espaço
                        ),
                      ),
                    ),
                    // Container de fundo
                    Container(
                      width: double.infinity,
                      height: 100,
                      color: Color(0xFF427443),
                    ),
                    // Botão "Total de Cadastros"
                    Align(
                      alignment: Alignment.center,
                      child: BtnsMenu(
                        icon: Icons.people,
                        titulo: 'Total de Cadastros',
                        ontap: () {
                          config_rota().animacao_2(
                            context,
                            novaPagina: const PaginaConsulta(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // BTN 1
                BtnsMenu(
                  icon: Icons.person_add,
                  titulo: 'Cadastrar participante',
                  ontap: () {
                    config_rota().animacao_2(
                      context,
                      novaPagina: const PaginaCadastro(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // BTN 2
                BtnsMenu(
                  icon: Icons.assignment,
                  titulo: 'Visualizar cadastros',
                  ontap: () {
                    config_rota().animacao_2(
                      context,
                      novaPagina: const PaginaConsulta(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // BTN 3
                BtnsMenu(
                  icon: Icons.settings,
                  titulo: 'Configurações',
                  ontap: () {
                    config_rota().animacao_2(
                      context,
                      novaPagina: const PaginoConfig(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // BTN 4
                BtnsMenu(
                  icon: Icons.info,
                  titulo: 'Sobre o app',
                  ontap: () {
                    config_rota().animacao_2(
                      context,
                      novaPagina: PaginoMensagemSistemaSobre(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BtnsMenu extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final VoidCallback ontap;

  const BtnsMenu({
    super.key,
    required this.icon,
    required this.titulo,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: InkWell(
        onTap: ontap,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF427443),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                titulo,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
