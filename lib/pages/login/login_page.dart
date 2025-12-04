import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  /// =====================================================
  /// LOGIN CON FIREBASE + DETECCIÓN DE ROL
  /// =====================================================
  Future<void> login() async {
    setState(() => loading = true);

    try {
      // 🔐 Login Firebase Auth
      UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = cred.user!.uid;

      // 🔥 Obtener datos de usuario en Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (!doc.exists || !doc.data().toString().contains("rol")) {
        throw "Usuario sin rol asignado";
      }

      String rol = doc["rol"].toString().toLowerCase();

      // 🧠 Importantísimo: verificar si el widget sigue montado tras el await
      if (!mounted) return;

      // 🚀 Redirección según rol
      switch (rol) {
        case "admin":
          Navigator.pushReplacementNamed(context, "/admin/home");
          break;
        case "docente":
          Navigator.pushReplacementNamed(context, "/docente/home");
          break;
        case "alumno":
          Navigator.pushReplacementNamed(context, "/alumno/home");
          break;
        case "padre":
          Navigator.pushReplacementNamed(context, "/padre/home");
          break;
        case "servicios_escolares":
          Navigator.pushReplacementNamed(context, "/servicios_escolares/home");
          break;
        case "planeacion":
          Navigator.pushReplacementNamed(context, "/planeacion/home");
          break;
        case "recursos_humanos":
          Navigator.pushReplacementNamed(context, "/recursos_humanos/home");
          break;
        case "recursos_materiales":
          Navigator.pushReplacementNamed(context, "/recursos_materiales/home");
          break;
        case "subdirector_academico":
          Navigator.pushReplacementNamed(context, "/subdirector_academico/home");
          break;
        case "subdirector_administrativo":
          Navigator.pushReplacementNamed(context, "/subdirector_administrativo/home");
          break;
        default:
          throw "Rol no reconocido";
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ Error al iniciar sesión: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) setState(() => loading = false);
  }

  /// =====================================================
  /// UI
  /// =====================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión CBTa")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Correo",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 30),

            loading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Ingresar"),
                ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/register"),
              child: const Text("Crear cuenta"),
            ),
          ],
        ),
      ),
    );
  }
}
