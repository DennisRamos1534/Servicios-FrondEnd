// To parse this JSON data, do
//
//     final reporte = reporteFromJson(jsonString);

import 'dart:convert';

Reporte reporteFromJson(String str) => Reporte.fromJson(json.decode(str));

String reporteToJson(Reporte data) => json.encode(data.toJson());

class Reporte {
  Reporte({
    required this.nombre,
    required this.numero,
    this.urlImagen,
    required this.direccion,
    required this.descripcion,
    required this.tipoServicio,
    required this.eliminado,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
  });

  String nombre;
  String numero;
  String? urlImagen;
  String direccion;
  String descripcion;
  String tipoServicio;
  bool eliminado;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;
  String uid;

  factory Reporte.fromJson(Map<String, dynamic> json) => Reporte(
    nombre: json["nombre"],
    numero: json["numero"],
    urlImagen: json["urlImagen"],
    direccion: json["direccion"],
    descripcion: json["descripcion"],
    tipoServicio: json["tipoServicio"],
    eliminado: json["eliminado"],
    estado: json["estado"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "numero": numero,
    "urlImagen": urlImagen,
    "direccion": direccion,
    "descripcion": descripcion,
    "tipoServicio": tipoServicio,
    "eliminado": eliminado,
    "estado": estado,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "uid": uid,
  };
}
