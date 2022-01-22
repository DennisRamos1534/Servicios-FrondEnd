import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UiProvider extends ChangeNotifier {
  
  int _selectedMenuOpt = 1;
  String _imagePath = '';

  File? newPictureFile;

  int get selectedMenuOpt => this._selectedMenuOpt;
  set selectedMenuOpt(int valor) {
    this._selectedMenuOpt = valor;
    notifyListeners();
  }

  String get imagePath => this._imagePath;
  set imagePath(String valor) {
    this._imagePath = valor;
    notifyListeners();
  }

  void selectedImage(String path) {
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> cargarImagen() async {
    if(this.newPictureFile == null) return null;

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dufc4ce3v/image/upload?upload_preset=servicios');
    final imageUploadRequest = http.MultipartRequest( 'POST', url );

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}