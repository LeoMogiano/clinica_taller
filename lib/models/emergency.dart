import 'dart:convert';

class Emergency {
  Emergency({
    this.id,
    this.motivo,
    this.gravedad,
    this.observacion,
    required this.estado,
    required this.fecha,
    required this.hora,
    this.detalleFin,
    this.diagnostico,
    required this.userId,
    this.nameUser, // Nuevo campo agregado
  });

  int? id;
  String? motivo;
  String? gravedad;
  String? observacion;
  String estado;
  DateTime fecha;
  DateTime hora;
  String? detalleFin;
  String? diagnostico;
  int userId;
  String? nameUser; // Nuevo campo agregado

  factory Emergency.fromJson(String str) =>
      Emergency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Emergency.fromMap(Map<String, dynamic> json) => Emergency(
        id: json["id"],
        motivo: json["motivo"],
        gravedad: json["gravedad"],
        observacion: json["observacion"],
        estado: json["estado"],
        fecha: DateTime.parse(json["fecha"]),
        hora: DateTime.parse(json["hora"]),
        detalleFin: json["detalle_fin"],
        diagnostico: json["diagnostico"],
        userId: json["user_id"],
        nameUser: json["name_user"], // Nuevo campo agregado
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "motivo": motivo,
        "gravedad": gravedad,
        "observacion": observacion,
        "estado": estado,
        "fecha": fecha.toIso8601String(),
        "hora": hora.toIso8601String(),
        "detalle_fin": detalleFin,
        "diagnostico": diagnostico,
        "user_id": userId,
        "name_user": nameUser, // Nuevo campo agregado
      };

  bool get isEmpty =>
      id == null &&
      motivo == null &&
      gravedad == null &&
      observacion == null &&
      detalleFin == null &&
      diagnostico == null;
      
  static List<Emergency> parseEmergencies(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? emergencyListJson = parsedJson['emergencias'];
    if (emergencyListJson != null) {
      return emergencyListJson.map((emergency) => Emergency.fromMap(emergency)).toList();
    } else {
      return [];
    }
  }
}
