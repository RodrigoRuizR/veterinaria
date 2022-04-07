import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/loginProvider.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/services/loginService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isObscure = true;
  String? user = '';
  String? pass = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 280, bottom: 8),
                margin: const EdgeInsets.only(right: 270),
                child: const Text(
                  'Usuario',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: TextField(
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                  autofocus: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    hintText: 'User',
                  ),
                  onChanged: (text) {
                    user = text;
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.only(right: 250, top: 25),
                child: const Text(
                  'Contraseña',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: TextField(
                  obscureText: _isObscure,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                  autofocus: false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    hintText: 'Password',
                  ),
                  onChanged: (password) {
                    pass = password;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: size.width - 70,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (user == '' && pass == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 1000),
                            content: Text('Rellene los campos'),
                          ),
                        );
                      } else {
                        login(user!, pass!).then((value) {
                          if (value.length > 1) {
                            // provider.saveData(
                            //     token: value[1], idUser: value[0]);
                            local().setToken(value[1]);
                            Navigator.pushReplacementNamed(context, 'duenios');
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(milliseconds: 1000),
                              content: Text('Credenciales Invalidas'),
                            ));
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿Aún no tienes cuenta?',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text(
                      'Registrate',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
