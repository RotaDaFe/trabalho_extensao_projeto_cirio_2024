import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rota_da_fe_v2/components/buttton_dropdow.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/pages/edite_user.page.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/services/exportDB/fetch.dart'; // Para a função exportDatabase
import 'package:flutter/services.dart'; // Para a função de copiar para a área de transferência

class PageConfiguracao extends StatefulWidget {
  const PageConfiguracao({super.key});

  @override
  State<PageConfiguracao> createState() => _PageConfiguracaoState();
}

class _PageConfiguracaoState extends State<PageConfiguracao> {
  final SqfliteHelper dbHelper = SqfliteHelper();

  // Função para mostrar a confirmação de exportação
  Future<void> _showConfirmExportDialog(BuildContext context) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Exportar dados',
      text: 'Você deseja exportar os dados do aplicativo?',
      confirmBtnText: 'Sim',
      cancelBtnText: 'Não',
      onConfirmBtnTap: () {
        Navigator.of(context).pop(); // Fechar o popup de confirmação
        _exportData(context); // Iniciar o processo de exportação
      },
    );
  }

  // Função para exportar os dados e tratar erro/sucesso
  Future<void> _exportData(BuildContext context) async {
    // Exibir popup de loading
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Exportando',
      text: 'Aguarde enquanto os dados estão sendo exportados...',
      barrierDismissible: false, // Impede fechar o loading
    );

    try {
      // Chamar a função real de exportação e verificar o status
      int statusCode = await exportDatabase(dbHelper: dbHelper);

      // Fechar o popup de loading
      Navigator.of(context).pop();

      // Verificar o status da exportação e exibir mensagens adequadas
      if (statusCode == 200 || statusCode == 201) {
        // Exibir popup de sucesso
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Exportação concluída!',
          text: 'Os dados foram exportados com sucesso.',
        );
      } else {
        // Exibir popup de erro
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erro na exportação',
          text: 'Houve um erro ao exportar os dados. Código: $statusCode',
        );
      }
    } catch (error) {
      // Fechar o popup de loading
      Navigator.of(context).pop();

      // Exibir popup de erro
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Erro na exportação',
        text: 'Houve um erro ao exportar os dados. Tente novamente.',
      );
    }
  }

  // Função para copiar os dados de exportDatabaseCopy para a área de transferência
  Future<void> _copyExportDataToClipboard(BuildContext context) async {
    try {
      String dataCopy = await exportDatabaseCopy(dbHelper: dbHelper);

      if (dataCopy.isNotEmpty) {
        Clipboard.setData(ClipboardData(text: dataCopy));

        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Dados copiados!',
          text: 'Os dados foram copiados para a área de transferência.',
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erro',
          text: 'Não foi possível copiar os dados.',
        );
      }
    } catch (error) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Erro',
        text: 'Ocorreu um erro ao copiar os dados. Tente novamente.',
      );
    }
  }

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
                height: 80.0,
              ),
              Center(
                child: SizedBox(
                  width: largura - margem,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Center(
                        child: Text(
                          "Configuração",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(218, 66, 116, 67),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: butttonDropdow(
                          width: largura - margem,
                          ontap: () {
                            Navigator.of(context).push(SlideTransitionPage(
                                page: const PageEditeUser()));
                          },
                          text: "Editar cadastro",
                          textSub: "Clique e saiba mais",
                          icon: Icons.edit_outlined,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: butttonDropdow(
                          width: largura - 100,
                          ontap: () {
                            _showConfirmExportDialog(context);
                          },
                          text: "Exportar dados",
                          textSub: "Clique e saiba mais",
                          icon: Icons.dashboard,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: butttonDropdow(
                          width: largura - 100,
                          ontap: () {
                            _copyExportDataToClipboard(context);
                          },
                          text: "Copiar dados para área de transferência",
                          textSub: "Clique para copiar os dados exportados",
                          icon: Icons.copy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
