import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/pages/mostraCadastros.page.dart';
import 'package:rota_da_fe_v2/pages/splash_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}
