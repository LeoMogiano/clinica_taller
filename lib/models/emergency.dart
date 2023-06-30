import 'dart:convert';
import 'package:flutter/material.dart';

class Emergency {
  Emergency({
    this.id,
    this.motivo,
    this.gravedad,
    this.observacion,
    required this.estado,
    required this.fecha,
    required this.hora,
   
    this.diagnostico,
    required this.userId,
    this.nameUser,
    required this.medicoId,
  });

  int? id;
  String? motivo;
  String? gravedad;
  String? observacion;
  String estado;
  DateTime fecha;
  TimeOfDay hora;

  String? diagnostico;
  int userId;
  String? nameUser;
  int medicoId;

  factory Emergency.fromJson(String str) => Emergency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Emergency.fromMap(Map<String, dynamic> json) => Emergency(
        id: json["id"],
        motivo: json["motivo"],
        gravedad: json["gravedad"],
        observacion: json["observacion"],
        estado: json["estado"],
        fecha: DateTime.parse(json["fecha"]),
        hora: _parseTimeOfDay(json["hora"]),
     
        diagnostico: json["diagnostico"],
        userId: json["user_id"],
        nameUser: json["name_user"],
        medicoId: json["medico_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "motivo": motivo,
        "gravedad": gravedad,
        "observacion": observacion,
        "estado": estado,
        "fecha": fecha.toIso8601String(),
        "hora": _formatTimeOfDay(hora),

        "diagnostico": diagnostico,
        "user_id": userId,
        "name_user": nameUser,
        "medico_id": medicoId,
      };

  bool get isEmpty =>
      id == null &&
      motivo == null &&
      gravedad == null &&
      observacion == null &&
      diagnostico == null;

  static List<Emergency> parseEmergencies(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? emergencyListJson = parsedJson['emergencias'];
    if (emergencyListJson != null) {
      return emergencyListJson
          .map((emergency) => Emergency.fromMap(emergency))
          .toList();
    } else {
      return [];
    }
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
