import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clinica_app_taller/models/models.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  List<User> personalMed = [];

  bool isLoading = false;

  Future<List<User>> getPersonalMed() async {
    final url = '$_baseUrl/api/personal_med';
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
    final url = '$_baseUrl/api/pacientes';
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
