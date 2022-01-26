import 'package:flutter/material.dart';

class UsuarioFormProvider extends ChangeNotifier {

  GlobalKey<FormState> usuarioFormKey = new GlobalKey<FormState>(); 
   
  // String nombre = '';
  // String numero = '';
  String password = '';

  bool isValidForm() {
    
    return usuarioFormKey.currentState?.validate() ?? false;
  }
} 