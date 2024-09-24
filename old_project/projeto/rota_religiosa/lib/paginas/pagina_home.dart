import 'package:flutter/material.dart';
import 'package:rota_religiosa/components/widget_menu.dart';
import 'package:rota_religiosa/components/widget_topbar.dart';
import 'package:rota_religiosa/controller/router_settings.dart';
import 'package:rota_religiosa/paginas/pagina_mensagem_sis_confirm.dart';

class PaginoHome extends StatefulWidget {
  const PaginoHome({super.key});

  @override
  State<PaginoHome> createState() => _PaginoHomeState();
}

class _PaginoHomeState extends State<PaginoHome> {
  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xFFECCB83),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            config_rota().animacao_2(context,
                novaPagina: const PaginoMensagemSistema_confirm());
            return false;
          },
          child: Scaffold(
              backgroundColor: const Color(0xffEBE9EC),
              body: Column(
                children: [
                  Widgettopbar(
                    home: true,
                  ),
                  Expanded(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          // ignore: prefer_const_constructors
                          child: SingleChildScrollView(
                              // ignore: prefer_const_constructors
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: alturaTela > 750
                                      ? 0
                                      : alturaTela > 710
                                          ? 50
                                          : 10),
                              // =============================================
                              Positioned.fill(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(
                                        0.5), // Aplica uma cor preta com 50% de opacidade
                                    BlendMode
                                        .darken, // Modo de mesclagem para escurecer
                                  ),
                                  child: Image.asset(
                                    'assets/image 33.png', // Substitua pelo caminho correto
                                  ),
                                ),
                              ),
                     

                              //==============================================
                              const Widgetmenu(),
                            ],
                          )))),

                  //=======================================
                ],
              )),
        ),
      ),
    );
  }
}
