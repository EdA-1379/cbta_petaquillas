import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/login/login_page.dart';

// === HOMES DE ROLES ===
//import 'pages/roles/admin/admin_home.dart';
//import 'pages/roles/docente/docente_home.dart';
//import 'pages/roles/alumno/alumno_home.dart';
//import 'pages/roles/padre/padre_home.dart';
//import 'pages/roles/servicios_escolares/servicios_home.dart';
//import 'pages/roles/subdirector_academico/sub_acad_home.dart';
//import 'pages/roles/subdirector_administrativo/sub_admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const CBTaApp());
}

class CBTaApp extends StatelessWidget {
  const CBTaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CBTa Petaquillas",
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",

      routes: {
        "/login": (context) => const LoginPage(),

      //  "/admin/home": (context) => const AdminHomePage(),
      //  "/docente/home": (context) => const DocenteHomePage(),
      //  "/alumno/home": (context) => const AlumnoHomePage(),
      //  "/padre/home": (context) => const PadreHomePage(),
      //  "/servicios/home": (context) => const ServiciosHomePage(),
      //  "/subacad/home": (context) => const SubAcadHomePage(),
      //  "/subadmin/home": (context) => const SubAdminHomePage(),
      },

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (!snap.hasData) return const LoginPage();

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("usuarios")
                .doc(snap.data!.uid)
                .get(),
            builder: (context, userSnap) {
              if (!userSnap.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final rol = userSnap.data!["rol"];

              switch (rol) {
            //    case "admin": return const AdminHomePage();
            //    case "docente": return const DocenteHomePage();
            //    case "alumno": return const AlumnoHomePage();
            //    case "padre": return const PadreHomePage();
            //    case "servicios": return const ServiciosHomePage();
            //    case "subacad": return const SubAcadHomePage();
            //    case "subadmin": return const SubAdminHomePage();
                default:
                  return const Scaffold(
                    body: Center(child: Text("Rol no reconocido")),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
