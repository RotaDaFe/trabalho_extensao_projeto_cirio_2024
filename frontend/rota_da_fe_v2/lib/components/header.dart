import 'package:flutter/material.dart';

Widget header({required Function onTap, height = 90.0}) {
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.1), // Cor da sombra
        offset: const Offset(0, 4), // Deslocamento da sombra
        blurRadius: 4, // Desfoque
        spreadRadius: 0, // Expansão da sombra
      ),
    ], color: const Color(0xffEDB637)),
    child: Row(
      children: [
        const Spacer(flex: 20),
        InkWell(
          onTap: () {
            onTap();
          },
          child: const SizedBox(
              height: 70,
              child: Image(
                image: AssetImage("images/iconHome.png"),
                fit: BoxFit.fill,
              )),
        ),
        const Spacer(flex: 50),
        const Text("Círio 2024",
            style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        const Spacer(flex: 100),
      ],
    ),
  );
}
