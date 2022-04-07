import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String jwt = "";
  int id = 0;
  void saveData({required String token, required int idUser}) {
    jwt = token;
    id = idUser;

    notifyListeners();

    // Future.delayed(const Duration(milliseconds: 10000), () {
    //   jwt = '';
    //   id = 0;
    //   notifyListeners();
    // });
  }
}
