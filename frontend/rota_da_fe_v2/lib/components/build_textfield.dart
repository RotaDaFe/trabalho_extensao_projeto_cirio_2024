import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField(
    {enabled = true,
    obscureText = false,
    required TextInputType keyboardType,
    required String label,
    required TextEditingController controller,
    required double width,
    isNumber = false}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          child: Row(
            children: [
              Column(children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                const SizedBox(height: 0),
                SizedBox(
                    width: 50, child: Image.asset("images/icon_santinha.png"))
              ]),
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
                    TextFormField(
                      obscureText: obscureText,
                      enabled: enabled,
                      maxLength: isNumber ? 3 : 256,
                      controller: controller,
                      keyboardType: keyboardType,
                      inputFormatters: isNumber
                          ? <TextInputFormatter>[
                              FilteringTextInputFormatter
                                  .digitsOnly, // Permite apenas números
                            ]
                          : [],
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
                        labelText: "Digite $label",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(125, 66, 116, 67),
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
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
