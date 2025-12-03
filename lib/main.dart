import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // ← IMPORTANTE: este es el que generó flutterfire

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase con la configuración generada
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CBTa Petaquillas',
      home: const Scaffold(
        body: Center(
          child: Text(
            'CBTa Petaquillas + Firebase listo 🔥',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
