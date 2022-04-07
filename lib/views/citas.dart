import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/modelo_citas.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/services/loginService.dart';

class citas extends StatefulWidget {
  const citas({Key? key}) : super(key: key);

  @override
  State<citas> createState() => _citasState();
}

class _citasState extends State<citas> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  late List<String> lista_Datos = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int tamLista = 0;
  List lista_datos = [];
  void initState() {
    super.initState();
    local().getToken().then((token) => {
          get_citas_all(token!).then((lista) {
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
        title: const Text('Citas'),
      ),
      body: 
      tamLista > 0
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
        "idCitas": index,
        "title": "Servicio: " + lista[index]['tipoServicio'],
        "subtitle": "Fecha: " +
            lista[index]['fecha'] +
            " | Hora: " +
            lista[index]['hora']
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
                  lista_Datos.add(lista[index]['idCita'].toString());
                  lista_Datos.add(lista[index]['fecha']);
                  lista_Datos.add(lista[index]['hora']);
                  lista_Datos.add(lista[index]['tipoServicio']);

                  print(lista_datos);
                  late List ListaNavigador = [];
                  ListaNavigador.add(lista[index]['idCita'].toString());
                  ListaNavigador.add(lista[index]['tipoServicio']);
                  local().setCitas(lista_Datos);
                  Navigator.pushReplacementNamed(context, 'edit_citas',
                      arguments: ListaNavigador);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  // String id_STR = lista_navigator.toString()[1];
                  // int id_casteado = int.parse(lista_navigator.toString()[1]);

                  // ignore: unnecessary_new
                  Citas citas = new Citas(
                      idCita: lista[index]['idCita'],
                      fecha: lista[index]['fecha'],
                      hora: lista[index]['hora'],
                      tipoServicio: lista[index]['tipoServicio'],);

                  local().getToken().then(
                    (token) {
                      deleteCitas(citas, token!).then(
                        (value) {
                          print(value);
                          Navigator.pushReplacementNamed(context, 'citas');
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
