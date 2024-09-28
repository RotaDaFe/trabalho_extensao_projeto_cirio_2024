import 'package:flutter/material.dart';

Widget buttonTypeA({text = '', required Function ontap}) {
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
          color: const Color(0xff427443),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1), // Cor da sombra
              offset: const Offset(0, 4), // Deslocamento da sombra
              blurRadius: 4, // Desfoque
              spreadRadius: 0, // Expansão da sombra
            ),
          ]),
      child: Center(
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
