import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/services/text/truncate_text.dart';

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
                  image: AssetImage("images/iconAccount.png"),
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
