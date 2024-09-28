import 'package:flutter/material.dart';

//====================================
//        WIDGET DE BOTAO
//====================================

Widget buttonNext({required Function onTap}) {
  return InkWell(onTap: () {
    onTap();
  });
}
