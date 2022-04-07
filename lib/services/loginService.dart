// import 'dart:_http';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/loginProvider.dart';
import 'package:pet_aplication/providers/modelo_citas.dart';

Future<List<dynamic>> login(String usuario, String password) async {
  try {
    final response = await http.post(
        Uri.http('192.168.1.72:18080', '/user/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"username": usuario, "password": password}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> get_duenios_all(String token) async {
  var resultado;
  print(LoginProvider().jwt);
  print('object');
  try {
    final response = await http
        .get(Uri.http('192.168.1.72:18080', '/user/listUser'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    });

    // body: json.encode({"username": usuario, "password": password}));
    resultado = json.decode(response.body);
    // print(resultado);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> updateDuenio(Usuario usuario, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.72:18080', '/user/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
        "id": usuario.id,
        "username": usuario.username,
        "password": usuario.password,
        "rol": usuario.rol,
        "edad": usuario.edad,
        "nombre": usuario.nombre,
        "apellidos": usuario.apellidos
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> deleteDuenio(Usuario usuario, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.72:18080', '/user/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode(
        {
          "id": usuario.id,
          "username": usuario.username,
          "password": usuario.password,
          "rol": usuario.rol,
          "edad": usuario.edad,
          "nombre": usuario.nombre,
          "apellidos": usuario.apellidos
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

//////////////////////////////////////////////////////////////////////////

Future<List<dynamic>> get_citas_all(String token) async {
  var resultado;
  print(LoginProvider().jwt);
  print('object');
  try {
    final response = await http
        .get(Uri.http('192.168.1.72:9999', '/listCita'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    });

    // body: json.encode({"username": usuario, "password": password}));
    resultado = json.decode(response.body);
    print(resultado);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> updateCitas(Citas citas, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.72:9999', '/cita/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
          "idCita": citas.idCita,
          "fecha": citas.fecha,
          "hora": citas.hora,
          "tipoServicio": citas.tipoServicio,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> deleteCitas(Citas citas, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.72:9999', '/citas/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode(
        {
          "idCita": citas.idCita,
          "fecha": citas.fecha,
          "hora": citas.hora,
          "tipoServicio": citas.tipoServicio,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}
