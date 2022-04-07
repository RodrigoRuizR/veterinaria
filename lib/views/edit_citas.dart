import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/modelo_citas.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/views/citas.dart';
import 'package:pet_aplication/views/duenios.dart';
import 'package:pet_aplication/services/loginService.dart';

class edit_citas extends StatefulWidget {
  // final Usuario user;
  // const edit_duenio({Key? key, required, required this.user}) : super(key: key);
  const edit_citas({
    Key? key,
    required,
  }) : super(key: key);
  @override
  State<edit_citas> createState() => _edit_citasState(
      // user: user
      );
}

class _edit_citasState extends State<edit_citas> {
  // final Usuario user;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // _edit_duenioState({required this.user});
  late var fecha = TextEditingController();
  late var hora = TextEditingController();
  late var tipoServicio = TextEditingController();
  //late var citas_controller = TextEditingController();
  late List<String> datos_citas = [];
  late var iniciar = false;
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    fecha.dispose();
    hora.dispose();
    tipoServicio.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    local().getCitas().then((lista) {
      print(lista);
      print("aqui es getcitas");
      datos_citas = lista!;
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
    print(datos_citas);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Modificar Cita'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'citas');
          },
        ),
      ),
      body: iniciar == true
          ? RefreshIndicator(
              child: ListView(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                children: [
                  input(width_total, height_total, 'tipoServicio', tipoServicio),
                  input(width_total, height_total, 'hora', hora),
                  input(width_total, height_total, 'fecha', fecha),
                  //input(width_total, height_total, 'citass', citas_controller),
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
                        Citas citas = new Citas(
                            idCita: id_casteado,
                            fecha: fecha.text,
                            hora: hora.text,
                            tipoServicio: tipoServicio.text,
                            //citass: citas_controller.text,
                            );
                        print(citas);
                        local().getToken().then(
                          (token) {
                            updateCitas(citas, token!).then(
                              (value) {
                                print(value);
                                Navigator.pushReplacementNamed(
                                    context, 'citas');
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
          fecha = new TextEditingController(text: lista![1]);
          hora = new TextEditingController(text: lista[2]);
          tipoServicio= new TextEditingController(text: lista[3]);
          //citas_controller = new TextEditingController(text: lista[1]);
        });
      },
    );
    return null;
  }
}