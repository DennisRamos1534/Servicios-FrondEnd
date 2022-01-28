import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:servicios/global/environment.dart';
import 'package:servicios/models/reporte.dart';
import 'package:servicios/models/reporte_response.dart';


class ReporteProvider extends ChangeNotifier {

  List<Reporte> reportes = [];

  ReporteProvider() {
    // this.reporteFiltrado('9994862138');
  }

  Future reporteFiltrado(String numero) async {

    final data = {
      'numero': numero,
    };

    final uri = Uri.parse('${ Environment.apiUrl }/reporte/filtrado');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    if(resp.statusCode == 200) {
      final reporteResponse = reporteResponseFromJson(resp.body);
      this.reportes = reporteResponse.reporte;
      notifyListeners();
      return this.reportes;
      // return true;
    } else {
      return false;
    }
  }
}