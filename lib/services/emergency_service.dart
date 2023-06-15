import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clinica_app_taller/models/models.dart';

class EmergencyService extends ChangeNotifier {
  static const String _baseUrl = 'http://192.168.0.18/api_clinica/public';

  List<Emergency> emergencies = [];
  User? user;
  bool isLoading = false;

  

  Future<List<Emergency>> getEmergencies() async {
    const url = '$_baseUrl/api/emergencias';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = true;
      notifyListeners();

      final List<Emergency> parsedEmergencies = Emergency.parseEmergencies(response.body);
      emergencies = parsedEmergencies;
      isLoading = false;
      notifyListeners();

      return parsedEmergencies;
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Error al cargar los datos de emergencias');
    }
  }

  Future<Emergency> getEmergencyById(int id) async {
    final url = '$_baseUrl/api/emergencia/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final Emergency emergency = Emergency.fromMap(jsonData);

      return emergency;
    } else {
      throw Exception('Error al cargar los datos de la emergencia');
    }
  }

  
}
