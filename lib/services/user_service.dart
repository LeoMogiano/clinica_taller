import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clinica_app_taller/models/models.dart';

class UserService extends ChangeNotifier {

  static const String _baseUrl = 'http://192.168.0.18/api_clinica/public';
  List<User> personalMed = [];

  bool isLoading = false;

  Future<List<User>> getPersonalMed() async {
    const url = '$_baseUrl/api/personal_med';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = true;
      notifyListeners();
      
      final List<User> personal = User.parseUsers(response.body);
      personalMed = personal;
      isLoading = false;
      notifyListeners();
      
      return personal;
      
    } else if (response.statusCode == 204) {
      return [];
    } else {
     
      throw Exception('Error en cargar los datos de personal médico');
    }
  }

  Future<List<User>> getPacientes() async {
    const url = '$_baseUrl/api/pacientes';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = true;
      notifyListeners();
      
      final List<User> personal = User.parseUsers(response.body);
      personalMed = personal;
      isLoading = false;
      notifyListeners();
      
      return personal;
      
    } else if (response.statusCode == 204) {
      return [];
    } else {
     
      throw Exception('Error en cargar los datos de los pacientes');
    }
  }
}
