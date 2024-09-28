import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:rota_da_fe_v2/pages/splash_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  // Variável para ativar/desativar o Device Preview
  bool isPreviewEnabled = false; // Mude para 'false' para desativar o preview

  runApp(
    DevicePreview(
      enabled: isPreviewEnabled,
      builder: (context) =>
          const MyApp(), // Substitua pelo seu widget principal
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery:
          true, // Necessário para o Device Preview funcionar
      locale: DevicePreview.locale(context), // Obtém a localização do preview
      builder:
          DevicePreview.appBuilder, // Constrói a interface com Device Preview
      home: const SplashScreen(),
    );
  }
}
