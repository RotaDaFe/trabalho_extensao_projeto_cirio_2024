import 'package:flutter/material.dart';

Widget walpaperBackground(
    {required Widget child, String image = "images/banner1.png", width}) {
  return SizedBox(
    height: 300,
    child: Stack(children: [
      Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image),
                  fit: width > 450 ? BoxFit.fitWidth : BoxFit.fitHeight))),
      child
    ]),
  );
}
