// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
      required this.nombre,
      required this.numero,
      required this.uid,
    });

    String nombre;
    String numero;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      nombre: json["nombre"],
      numero: json["numero"],
      uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
      "nombre": nombre,
      "numero": numero,
      "uid": uid,
    };
}
