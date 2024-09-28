// ignore: file_names
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission(context, Function? fn) async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    fn;
  } else if (status.isDenied) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Permissão Necessária'),
              content: const Text(
                  'Você precisa conceder a permissão de armazenamento para usar o aplicativo.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  } else if (status.isPermanentlyDenied) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Permissão Negada Permanentemente'),
              content: const Text(
                  'A permissão de armazenamento foi negada permanentemente. Habilite nas configurações do aplicativo.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ir para Configurações'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                )
              ]);
        });
  }
}
