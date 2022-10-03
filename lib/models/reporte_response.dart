// To parse this JSON data, do
//
//     final reporteResponse = reporteResponseFromJson(jsonString);

import 'dart:convert';

import 'package:servicios/models/reporte.dart';

ReporteResponse reporteResponseFromJson(String str) => ReporteResponse.fromJson(json.decode(str));

String reporteResponseToJson(ReporteResponse data) => json.encode(data.toJson());

class ReporteResponse {
    ReporteResponse({
      required this.ok,
      required this.reporte,
    });

    bool ok;
    List<Reporte> reporte;

    factory ReporteResponse.fromJson(Map<String, dynamic> json) => ReporteResponse(
        ok: json["ok"],
        reporte: List<Reporte>.from(json["reporte"].map((x) => Reporte.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "reporte": List<dynamic>.from(reporte.map((x) => x.toJson())),
    };
}
