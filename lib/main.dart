import 'package:flutter/material.dart';
import 'package:pet_aplication/views/citas.dart';
import 'package:pet_aplication/views/duenios.dart';
import 'package:pet_aplication/views/edit_citas.dart';
import 'package:pet_aplication/views/home.dart';
import 'package:pet_aplication/views/login.dart';
import 'package:pet_aplication/views/vista_edit_edunio.dart';
import 'package:provider/provider.dart';

import 'providers/loginProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Vet-App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'citas',
        routes: {
          'edit_citas': (_) => const edit_citas(),
          'citas': (_) => const citas(),
          'login': (_) => const Login(),
          'home': (_) => Home(),
          'duenios': (_) => const duenios(),
          'edit_duenios': (_) => const edit_duenio(),
        },
      ),
    );
  }
}
