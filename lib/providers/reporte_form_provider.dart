import 'package:flutter/material.dart';

class ReporteFormProvider extends ChangeNotifier {

  GlobalKey<FormState> reporteFormKey = new GlobalKey<FormState>(); 
  
  String direccion = '';
  String descripcion = '';

  bool isValidForm() {
    
    return reporteFormKey.currentState?.validate() ?? false;
  }
}