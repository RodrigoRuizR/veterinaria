import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/views/duenios.dart';
import 'package:pet_aplication/services/loginService.dart';

class edit_duenio extends StatefulWidget {
  // final Usuario user;
  // const edit_duenio({Key? key, required, required this.user}) : super(key: key);
  const edit_duenio({
    Key? key,
    required,
  }) : super(key: key);
  @override
  State<edit_duenio> createState() => _edit_duenioState(
      // user: user
      );
}

class _edit_duenioState extends State<edit_duenio> {
  // final Usuario user;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // _edit_duenioState({required this.user});
  late var nombre = TextEditingController();
  late var apellidos = TextEditingController();
  late var edad = TextEditingController();
  late var usuario_controller = TextEditingController();
  late var contrasenia = TextEditingController();
  late List<String> datos_duenio = [];
  late var iniciar = false;
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombre.dispose();
    apellidos.dispose();
    edad.dispose();
    usuario_controller.dispose();
    contrasenia.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    local().getDuenio().then((lista) {
      print(lista);
      datos_duenio = lista!;
    });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    double width_total = MediaQuery.of(context).size.width;
    double height_total = MediaQuery.of(context).size.height;
    final Object? lista_navigator = ModalRoute.of(context)!.settings.arguments;
    iniciar = true;
    print('object');
    print(datos_duenio);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Modificar Dueño'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'duenios');
          },
        ),
      ),
      body: iniciar == true
          ? RefreshIndicator(
              child: ListView(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                children: [
                  input(width_total, height_total, 'Nombre', nombre),
                  input(width_total, height_total, 'Apellidos', apellidos),
                  input(width_total, height_total, 'Edad', edad),
                  input(
                      width_total, height_total, 'Usuario', usuario_controller),
                  input(width_total, height_total, 'Contraseña', contrasenia),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    // width: 300,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // print(nombre.text + apellidos.text);
                        // print(lista_navigator.toString()[0]);
                        String id_STR = lista_navigator.toString()[1];
                        int id_casteado =
                            int.parse(lista_navigator.toString()[1]);

                        // ignore: unnecessary_new
                        Usuario user = new Usuario(
                            id: id_casteado,
                            nombre: nombre.text,
                            apellidos: apellidos.text,
                            edad: int.parse(edad.text),
                            rol: 'Cliente',
                            username: usuario_controller.text,
                            password: contrasenia.text);
                        print(user);
                        local().getToken().then(
                          (token) {
                            updateDuenio(user, token!).then(
                              (value) {
                                print(value);
                                Navigator.pushReplacementNamed(
                                    context, 'duenios');
                              },
                            );
                          },
                        );
                      },
                      child: const Text('Editar Usuario'),
                    ),
                  ),
                ],
              ),
              onRefresh: refreshList)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget input(width_total, height_total, nombre_input,
      TextEditingController controlador) {
    return Container(
      width: width_total * 0.8,
      height: height_total * 0.1,
      margin: const EdgeInsets.only(top: 1),
      child: TextField(
        controller: controlador,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: nombre_input,
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 30));
    setState(
      () {
        local().getDuenio().then((lista) {
          print(lista);
          nombre = new TextEditingController(text: lista![4]);
          apellidos = new TextEditingController(text: lista[5]);
          edad = new TextEditingController(text: lista[3]);
          usuario_controller = new TextEditingController(text: lista[1]);
          contrasenia = new TextEditingController(text: lista[2]);
        });
      },
    );
    return null;
  }
}
