import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/section_logo_extensao.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';
import 'package:rota_da_fe_v2/pages/init.page.dart';
import 'package:rota_da_fe_v2/services/user/get_all_login.dart';
import 'package:permission_handler/permission_handler.dart'; // Adicione este pacote

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SqfliteHelper dbHelper = SqfliteHelper();
  List userData = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions(); // Solicita as permissões ao iniciar

    // Busca dados de login no banco de dados após permissões
    getAllLogin(dbHelper: dbHelper).then((data) {
      setState(() {
        userData = data;
      });
    });

    // Adiciona um atraso de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      // Navega para a próxima tela após 3 segundos
      if (userData.isNotEmpty) {
        Navigator.of(context)
            .pushReplacement(SlideTransitionPage(page: const PageInicio()));
      } else {
        Navigator.of(context)
            .pushReplacement(SlideTransitionPage(page: const PageInit()));
      }
    });
  }

  // Função para solicitar permissões de armazenamento
  Future<void> _requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/walpaper.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: largura - 100,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(.9)),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "Iniciando app",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 40),
                          Center(
                              child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                          SizedBox(height: 50),
                        ])),
                const SizedBox(height: 20),
                Container(
                  width: largura - 100,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(.9)),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      sectionLogoExtensao(),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
