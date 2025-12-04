class UserModel {
  final String uid;
  final String nombre;
  final String apellidos;
  final String rol;
  final String email;

  UserModel({
    required this.uid,
    required this.nombre,
    required this.apellidos,
    required this.rol,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      nombre: data["nombre"] ?? "",
      apellidos: data["apellidos"] ?? "",
      rol: data["rol"] ?? "",
      email: data["email"] ?? "",
    );
  }
}
