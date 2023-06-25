import 'dart:convert';

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role,
    this.group,
    this.especialidad,
    this.sexo,
    this.carnet,
    this.fechaNac,
    this.telefono,
    this.contactoEmerg,
    this.tipoSangre,
    this.foto, 
  });

  int? id;
  String name;
  String email;
  String? password;
  String? role;
  String? group;
  String? especialidad;
  String? sexo;
  String? carnet;
  DateTime? fechaNac;
  String? telefono;
  String? contactoEmerg;
  String? tipoSangre;
  String? foto; 

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        group: json["group"],
        especialidad: json["especialidad"],
        sexo: json["sexo"],
        carnet: json["carnet"],
        fechaNac: json["fecha_nac"] != null ? DateTime.parse(json["fecha_nac"]) : null,
        telefono: json["telefono"],
        contactoEmerg: json["contacto_emerg"],
        tipoSangre: json["tipo_sangre"],
        foto: json["foto"], 
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "group": group,
        "especialidad": especialidad,
        "sexo": sexo,
        "carnet": carnet,
        "fecha_nac": fechaNac != null ? fechaNac!.toIso8601String() : null,
        "telefono": telefono,
        "contacto_emerg": contactoEmerg,
        "tipo_sangre": tipoSangre,
        "foto": foto,
      };

  bool get isEmpty => id == 0 && name.isEmpty && email.isEmpty;

  static List<User> parseUsers(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? userListJson = parsedJson['users'];
    if (userListJson != null) {
      return userListJson.map((user) => User.fromMap(user)).toList();
    } else {
      return [];
    }
  }
}
