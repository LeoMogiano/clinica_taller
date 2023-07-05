import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clinica_app_taller/models/models.dart';

class HistoriaService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  List<HistoriaMedica> historias = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<User> pacHistoria = [];

  HistoriaService() {
    getHistorias();
   
  }

  Future<List<HistoriaMedica>> getHistorias() async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = '$_baseUrl/api/historias';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final parsedEmergencies = HistoriaMedica.parseHistorias(response.body);
        historias = parsedEmergencies;
      
        await getUsersFromHistorias(historias);
        return parsedEmergencies;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error al cargar los datos de emergencias');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      throw Exception('Error al cargar los datos de emergencias');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User> getUsuarioById(String id) async {
    final url = '$_baseUrl/api/user/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      /* _isLoading = true;
      notifyListeners(); */
      final Map<String, dynamic> userData = json.decode(response.body);
      final User user = User.fromMap(userData['user']);

      /* _isLoading = false;
      notifyListeners(); */
      return user;
    } else if (response.statusCode == 404) {
      throw Exception('Usuario no encontrado');
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }

  Future<List<User>> getUsersFromHistorias(
      List<HistoriaMedica> historias) async {
    List<User> usuarios = [];

    for (var historia in historias) {
      try {
        User usuario = await getUsuarioById(historia.userId.toString());
        usuarios.add(usuario);
      } catch (e) {
        print(
            'Error al obtener el usuario para la historia médica con ID ${historia.id}: $e');
      }
    }
    pacHistoria = usuarios;
    return usuarios;
  }
}
