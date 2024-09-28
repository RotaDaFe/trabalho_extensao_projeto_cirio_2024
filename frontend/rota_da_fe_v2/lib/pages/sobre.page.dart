import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/components/section_logo_extensao.dart';
import 'package:rota_da_fe_v2/components/text_section.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';

// ignore: constant_identifier_names
const EQUIPE = """
Orientador
- Erminio Paixão

FullStack
- Marco Antonio da Silva Mesquita

Frontend
- Mathias 
- Felipe 
- Iago 
- Mateus 
- Jackeline 
- Tales 

Backend
- Pedro Gabriel Raiol Frade 
- Gabriel Henrique Pinheiro Maia 
- Arthemyo Rodrigues 
- Paulo Eduardo Melo Pereira 

Design e documentação
- salomão trindade moraes 
- Alexsandro Fernandes Nascimento 
- Iago Weycker Viana Oliveira 
- Melize Rocha 
""";

class PageSobreApp extends StatelessWidget {
  const PageSobreApp({super.key});
  final String rodapeTexto =
      "O Rota da Fé é um projeto de extensão criado para facilitar a jornada dos romeiros durante o Círio de Nazaré, a maior manifestação religiosa da Amazônia. Lançado em 2023, o app acompanha os peregrinos e fornece informações em tempo real sobre a rota e pontos de interesse. A cada edição, o aplicativo evolui, tornando o evento mais organizado, seguro e acessível. Nossa missão é continuar inovando e apoiando os romeiros nessa tradição tão importante.";

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double margem = 100.0;
    return SafeArea(
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
                  SizedBox(
                    width: largura - margem,
                    child: Column(children: [
                      textSection(title: "Sobre", text: rodapeTexto),
                      textSection(
                          image: "images/banner1.png",
                          title: "Nossa motivação",
                          text:
                              "A fé do Círio de Nazaré nos inspira a aprimorar a experiência dos romeiros. O Rota da Fé une tradição e tecnologia para facilitar a jornada com uma ferramenta simples e eficiente. Nosso compromisso é garantir segurança e respeito à devoção, sempre evoluindo para ser um aliado na espiritualidade e bem-estar dos participantes."),
                      const SizedBox(height: 15),
                      sectionLogoExtensao(),
                      const SizedBox(height: 15),
                      textSection(title: "Equipe", text: EQUIPE),
                      const SizedBox(height: 100),
                    ]),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    ));
  }
}
