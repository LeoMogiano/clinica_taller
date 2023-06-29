import 'dart:convert';
import 'package:flutter/material.dart';

class Analisis {
  Analisis({
    this.id,
    required this.descripcion,
    required this.motivo,
    required this.fecha,
    required this.hora,
    required this.emergenciaId,
  });

  int? id;
  String descripcion;
  String motivo;
  DateTime fecha;
  TimeOfDay hora;
  int emergenciaId;

  factory Analisis.fromJson(String str) => Analisis.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Analisis.fromMap(Map<String, dynamic> json) => Analisis(
        id: json["id"],
        descripcion: json["descripcion"],
        motivo: json["motivo"],
        fecha: DateTime.parse(json["fecha"]),
        hora: _parseTimeOfDay(json["hora"]),
        emergenciaId: json["emergencia_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descripcion": descripcion,
        "motivo": motivo,
        "fecha": fecha.toIso8601String(),
        "hora": _formatTimeOfDay(hora),
        "emergencia_id": emergenciaId,
      };

  static List<Analisis> parseAnalisisList(String jsonString) {
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((analisis) => Analisis.fromMap(analisis)).toList();
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final dateTime = DateTime.parse(timeString);
    return TimeOfDay.fromDateTime(dateTime);
  }

  static String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return dateTime.toIso8601String();
  }
}
