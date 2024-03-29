import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:servicios/global/environment.dart';
import 'package:servicios/models/login_response.dart';
import 'package:servicios/models/reporte.dart';
import 'package:servicios/models/reporte_response.dart';
import 'package:servicios/models/usuario.dart';

class AuthProvider with ChangeNotifier {

  List<Reporte> reportes = [];

  late Usuario usuario;
  bool _autenticando = false;

  // pantalla usuario
  String _nombreUsuario = '';

  String get nombreUsuario => this._nombreUsuario;
  set nombreUsuario(String valor) {
    this._nombreUsuario = valor;
    notifyListeners();
  }
  // pantalla usuario

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners();
  }

  // getters gel token de forma estatica 
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String numero, String password) async {

    this.autenticando = true;

    final data = {
      'numero': numero,
      'password': password
    };

    final uri = Uri.parse('${ Environment.apiUrl }/login');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      
      // Guardar token en lugar seguro
      await this._guardarToken(loginResponse.token!);

      return true;
    } else {
       return false;
    }
  }

  Future registro(String nombre, String numero, String password) async {

    this.autenticando = true;

    final data = {
      'nombre': nombre,
      'numero': numero,
      'password': password
    };

    final uri = Uri.parse('${ Environment.apiUrl }/login/new');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );
    
    this.autenticando = false;

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      
      // Guardar token en lugar seguro
      await this._guardarToken(loginResponse.token!);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
       return respBody['msg'];
    }
  }

  Future reporte(String nombre, String numero, String urlImage, String direccion, String descripcion, String tipoServicio) async {

    final data = {
      'nombre': nombre,
      'numero': numero,
      'urlImagen': urlImage,
      'direccion': direccion,
      'descripcion': descripcion,
      'tipoServicio': tipoServicio,
      'eliminado': false,
      'estado': false
    };

    final uri = Uri.parse('${ Environment.apiUrl }/reporte/new');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    if(resp.statusCode == 200) {
      final reporteResponse = reporteResponseFromJson(resp.body);
      this.reportes = reporteResponse.reporte;
      return this.reportes[0].uid;
      // return true;
    } else {
      
      // return [];
      return false;
    }
  }


  Future borrarReporte( String uid) async {

    final uri = Uri.parse('${ Environment.apiUrl }/reporte/$uid');

    final resp = await http.delete(uri,
      headers: { 'Content-Type': 'application/json' }
    );

    if(resp.statusCode == 200) {

      return true;
    } else {
      
      return false;
    }
  }


  Future actualizarUsuario(String nombre,String password, String uid) async {

    final data = {
      'nombre': nombre,
      'password': password
    };

    final uri = Uri.parse('${ Environment.apiUrl }/actualizar/$uid');

    final resp = await http.put(uri,
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    if(resp.statusCode == 200) {
      
      return true;
    } else {
      
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    
    final token = await this._storage.read(key: 'token');
    if(token == null) {
      return false;
    }
    
    final uri = Uri.parse('${ Environment.apiUrl }/login/renovar');

    final resp = await http.get(uri,
      headers: { 
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      
      // Guardar token en lugar seguro
      await this._guardarToken(loginResponse.token!);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}