class UsuarioList {
  final List<Usuario> usuario;

  UsuarioList({
    required this.usuario,
  });

  factory UsuarioList.fromJson(Map<String, dynamic> parsedJson) {
    Iterable list = parsedJson['user'];

    List<Usuario> usuario = list.map((i) => Usuario.fromJson(i)).toList();

    return new UsuarioList(usuario: usuario);
  }
}

class Usuario {
  final int id;
  final String nombre;
  final String apellidos;
  final int edad;
  final String rol;
  final String username;
  final String password;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.edad,
    required this.rol,
    required this.username,
    required this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nombre: json['nombre'],
        apellidos: json['apellidos'],
        edad: json['edad'],
        rol: json['rol'],
        username: json['username'],
        password: json['password'],
      );
}
