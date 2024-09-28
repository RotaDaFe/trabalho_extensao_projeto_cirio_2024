import 'package:flutter/material.dart';

Widget buildDropdownButton({
  required String label,
  required List<String> items, // Lista de valores
  required TextEditingController
      controller, // Controlador para o valor selecionado
  required String initialValue, // Valor inicial
  required double width, // Largura do widget
}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          child: Row(
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 0),
                  SizedBox(
                      width: 50,
                      child: Image.asset("images/icon_santinha.png")),
                ],
              ),
              const SizedBox(width: 0),
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(label,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: initialValue,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(125, 66, 116, 67),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(125, 66, 116, 67),
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_downward),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.text = newValue; // Atualiza o controlador
                        }
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
