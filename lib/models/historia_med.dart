import 'dart:convert';

class HistoriaMedica {
  HistoriaMedica({
    this.id,
    required this.antMedFam,
    required this.antMedPers,
    required this.medisAct,
    required this.alergias,
    required this.hEnfermedades,
    required this.hCirugias,
    required this.saludActual,
    required this.notas,
    required this.userId,
  });

  int? id; // Antecedentes Medicos Familiares
  String antMedFam;
  String antMedPers;
  String medisAct;
  String alergias;
  String hEnfermedades;
  String hCirugias;
  String saludActual;
  String notas;
  int userId;

  factory HistoriaMedica.fromJson(String str) =>
      HistoriaMedica.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoriaMedica.fromMap(Map<String, dynamic> json) => HistoriaMedica(
      id: json["id"],
      antMedFam: json["antmed_fam"],
      antMedPers: json["antmed_pers"],
      medisAct: json["medis_act"],
      alergias: json["alergias"],
      hEnfermedades: json["h_enfermedades"],
      hCirugias: json["h_cirugias"],
      saludActual: json["salud_actual"],
      notas: json["notas"],
      userId: json["user_id"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "antmed_fam": antMedFam,
        "antmed_pers": antMedPers,
        "medis_act": medisAct,
        "alergias": alergias,
        "h_enfermedades": hEnfermedades,
        "h_cirugias": hCirugias,
        "salud_actual": saludActual,
        "notas": notas,
        "user_id": userId
      };

  static List<HistoriaMedica> parseHistorias(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? historiaListJson = parsedJson['historias'];
    if (historiaListJson != null) {
      return historiaListJson
          .map((historia) => HistoriaMedica.fromMap(historia))
          .toList();
    } else {
      return [];
    }
  }
}
