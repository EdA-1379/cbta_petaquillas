import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<User?> login(String email, String pass) async {
    final result = await auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return result.user;
  }

  Future<void> logout() async => await auth.signOut();

  User? get currentUser => auth.currentUser;
}
