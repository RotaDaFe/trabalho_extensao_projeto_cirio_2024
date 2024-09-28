import 'package:flutter/material.dart';

//---------------------------
// Display da pagina Sobre
//---------------------------

class WidgetDisplay extends StatelessWidget {
  const WidgetDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Projeto de extensão',
                  style: TextStyle(fontFamily: 'Arial', fontSize: 18)),
              SizedBox(
                height: 75,
                width: 75,
              )
            ]));
  }
}

/*
------------------------------------
ADICIONAR IMAGEM DO CODIGO ABAIXO
------------------------------------
*/

 /*child:
                Image(image: AssetImage(''))),
              Text('Universidade da Amazonia',
              style: TextStyle(fontFamily: 'Arial', fontSize: 18))*/