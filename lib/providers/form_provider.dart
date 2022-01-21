import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>(); 
   
  String usuario = '';
  String password = '';
  String numero = '';

  bool isValidForm() {
    
    return loginFormKey.currentState?.validate() ?? false;
  }
}