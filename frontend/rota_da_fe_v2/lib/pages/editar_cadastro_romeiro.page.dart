import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/components/build_textfield.dart';
import 'package:rota_da_fe_v2/components/button_type_a.dart';
import 'package:rota_da_fe_v2/components/header.dart';
import 'package:rota_da_fe_v2/config/database_helper.dart';
import 'package:rota_da_fe_v2/effects/slide_transition_page_remove.dart';
import 'package:rota_da_fe_v2/messageAlerts/alerts.dart';
import 'package:rota_da_fe_v2/components/build_dropdown.dart';
import 'package:rota_da_fe_v2/pages/inicio.page.dart';
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

  List<String> cidades = [
    "Selecione",
    "Belem",
    "Ananindeua",
    "Abaetetuba",
    "Barcarena",
    "Castanhal",
    "maranhao",
    "Abel Figueiredo",
    "Acará",
    "Afuá",
    "Água Azul do Norte",
    "Alenquer",
    "Almeirim",
    "Altamira",
    "Anajás",
    "Anapu",
    "Augusto Corrêa",
    "Aurora do Pará",
    "Aveiro",
    "Bagre",
    "Baião",
    "Bannach",
    "Belterra",
    "Benevides",
    "Bom Jesus do Tocantins",
    "Bonito",
    "Bragança",
    "Brasil Novo",
    "Brejo Grande do Araguaia",
    "Breu Branco",
    "Breves",
    "Bujaru",
    "Cachoeira do Arari",
    "Cachoeira do Piriá",
    "Cametá",
    "Canaã dos Carajás",
    "Capanema",
    "Capitão Poço",
    "Chaves",
    "Colares",
    "Conceição do Araguaia",
    "Concórdia do Pará",
    "Cumaru do Norte",
    "Curionópolis",
    "Curralinho",
    "Curuá",
    "Curuçá",
    "Dom Eliseu",
    "Eldorado dos Carajás",
    "Faro",
    "Floresta do Araguaia",
    "Garrafão do Norte",
    "Goianésia do Pará",
    "Gurupá",
    "Igarapé-Açu",
    "Igarapé-Miri",
    "Inhangapi",
    "Ipixuna do Pará",
    "Irituia",
    "Itaituba",
    "Itupiranga",
    "Jacareacanga",
    "Jacundá",
    "Juruti",
    "Limoeiro do Ajuru",
    "Mãe do Rio",
    "Magalhães Barata",
    "Marabá",
    "Maracanã",
    "Marapanim",
    "Marituba",
    "Medicilândia",
    "Melgaço",
    "Mocajuba",
    "Moju",
    "Monte Alegre",
    "Muaná",
    "Nova Esperança do Piriá",
    "Nova Ipixuna",
    "Nova Timboteua",
    "Novo Progresso",
    "Novo Repartimento",
    "Óbidos",
    "Oeiras do Pará",
    "Oriximiná",
    "Ourém",
    "Ourilândia do Norte",
    "Pacajá",
    "Palestina do Pará",
    "Paragominas",
    "Parauapebas",
    "Pau D'Arco",
    "Peixe-Boi",
    "Piçarra",
    "Placas",
    "Ponta de Pedras",
    "Portel",
    "Porto de Moz",
    "Prainha",
    "Primavera",
    "Quatipuru",
    "Redenção",
    "Rio Maria",
    "Rondon do Pará",
    "Rurópolis",
    "Salinópolis",
    "Salvaterra",
    "Santa Bárbara do Pará",
    "Santa Cruz do Arari",
    "Santa Isabel do Pará",
    "Santa Luzia do Pará",
    "Santa Maria das Barreiras",
    "Santa Maria do Pará",
    "Santana do Araguaia",
    "Santarém",
    "Santarém Novo",
    "Santo Antônio do Tauá",
    "São Caetano de Odivelas",
    "São Domingos do Araguaia",
    "São Domingos do Capim",
    "São Félix do Xingu",
    "São Francisco do Pará",
    "São Geraldo do Araguaia",
    "São João da Ponta",
    "São João de Pirabas",
    "São João do Araguaia",
    "São Miguel do Guamá",
    "São Sebastião da Boa Vista",
    "Sapucaia",
    "Senador José Porfírio",
    "Soure",
    "Tailândia",
    "Terra Alta",
    "Terra Santa",
    "Tomé-Açu",
    "Tracuateua",
    "Trairão",
    "Tucumã",
    "Tucuruí",
    "Ulianópolis",
    "Uruará",
    "Vigia",
    "Viseu",
    "Vitória do Xingu",
    "Xinguara"
  ];

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerIdade = TextEditingController();
  TextEditingController dropdownControllerLocalDeAtendimento =
      TextEditingController();
  TextEditingController dropdownControllerCidade = TextEditingController();
  TextEditingController dropdownControllerSexo = TextEditingController();

  String? selectedCity;
  String? selectedLocation;
  String? gender;

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

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double margem = 100.0;

    return SafeArea(
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
                      child: Column(children: [
                        const SizedBox(height: 30),
                        const Center(
                            child: Text("EDITAR CADASTRO",
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
                            label: "Cidade",
                            items: cidades, // Lista de opções
                            controller: dropdownControllerCidade,
                            initialValue:
                                dropdownControllerCidade.text.isNotEmpty
                                    ? dropdownControllerCidade.text
                                    : "Selecione",
                            width: largura),
                        buildDropdownButton(
                            label: "Sexo",
                            items: sexo, // Lista de opções
                            controller: dropdownControllerSexo,
                            initialValue: dropdownControllerSexo.text.isNotEmpty
                                ? dropdownControllerSexo.text
                                : "Selecione",
                            width: largura),
                        buildDropdownButton(
                            label: "Local de atendimento",
                            items: locaDeAtendimento, // Lista de opções
                            controller: dropdownControllerLocalDeAtendimento,
                            initialValue: dropdownControllerLocalDeAtendimento
                                    .text.isNotEmpty
                                ? dropdownControllerLocalDeAtendimento.text
                                : "Selecione",
                            width: largura),
                        const SizedBox(height: 20),
                        buttonTypeA(
                            text: "Atualizar",
                            ontap: () async {
                              if (controllerNome.text.isNotEmpty &&
                                  controllerIdade.text.isNotEmpty &&
                                  dropdownControllerCidade.text !=
                                      'Selecione' &&
                                  dropdownControllerLocalDeAtendimento.text !=
                                      'Selecione' &&
                                  dropdownControllerSexo.text != 'Selecione') {
                                alertSucess(context);
                                await updateRomeiro(
                                  id: id,
                                  dbHelper: dbHelper,
                                  nome: controllerNome.text,
                                  idade: int.parse(controllerIdade.text),
                                  cidade: dropdownControllerCidade.text,
                                  localDeAtendimento:
                                      dropdownControllerLocalDeAtendimento.text,
                                  genero: dropdownControllerSexo.text,
                                );
                                // ignore: use_build_context_synchronously
                                navigateAndRemoveUntil(
                                    context, const PageInicio());
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
    ));
  }
}
