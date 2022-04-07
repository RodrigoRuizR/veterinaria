import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/services/loginService.dart';

class duenios extends StatefulWidget {
  const duenios({Key? key}) : super(key: key);

  @override
  State<duenios> createState() => _dueniosState();
}

class _dueniosState extends State<duenios> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  late List<String> lista_Datos = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int tamLista = 0;
  List lista_datos = [];
  void initState() {
    super.initState();
    local().getToken().then((token) => {
          get_duenios_all(token!).then((lista) {
            // listaDatos(value.length, value);
            tamLista = lista.length;
            lista_datos = lista;
          }),
        });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Dueños'),
      ),
      body: tamLista > 0
          ? RefreshIndicator(
              child: listaDatos(tamLista, lista_datos, context),
              onRefresh: refreshList,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 1));
    setState(
      () {
        local().getToken().then(
              (token) => {
                get_duenios_all(token!).then(
                  (lista) {
                    tamLista = lista.length;
                    lista_datos = lista;
                  },
                ),
              },
            );
      },
    );
    return null;
  }

  //https://www.kindacode.com/article/flutter-listtile/
  Widget listaDatos(int lenghtLista, List lista, BuildContext context) {
    final List<Map<String, dynamic>> _items = List.generate(
      lenghtLista,
      (index) => {
        "id": index,
        "title": "Usuario: " + lista[index]['username'],
        "subtitle": "Nombre: " +
            lista[index]['nombre'] +
            " | Apellido: " +
            lista[index]['apellidos']
      },
    );
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (_, index) => Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            _items[index]['title'],
          ),
          subtitle: Text(
            _items[index]['subtitle'],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  lista_Datos.add(lista[index]['id'].toString());
                  lista_Datos.add(lista[index]['username']);
                  lista_Datos.add(lista[index]['password']);
                  lista_Datos.add(lista[index]['edad'].toString());
                  lista_Datos.add(lista[index]['nombre']);
                  lista_Datos.add(lista[index]['apellidos']);

                  // print(lista_datos);
                  late List ListaNavigador = [];
                  ListaNavigador.add(lista[index]['id'].toString());
                  ListaNavigador.add(lista[index]['rol']);
                  local().setDuenio(lista_Datos);
                  Navigator.pushReplacementNamed(context, 'edit_duenios',
                      arguments: ListaNavigador);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  // String id_STR = lista_navigator.toString()[1];
                  // int id_casteado = int.parse(lista_navigator.toString()[1]);

                  // ignore: unnecessary_new
                  Usuario user = new Usuario(
                      id: lista[index]['id'],
                      nombre: lista[index]['nombre'],
                      apellidos: lista[index]['apellidos'],
                      edad: lista[index]['edad'],
                      rol: 'Cliente',
                      username: lista[index]['username'],
                      password: lista[index]['password']);

                  local().getToken().then(
                    (token) {
                      deleteDuenio(user, token!).then(
                        (value) {
                          print(value);
                          Navigator.pushReplacementNamed(context, 'duenios');
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
