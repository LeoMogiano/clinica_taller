// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clinica_app_taller/models/models.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User? user;
  bool isLoading = false;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> login(String email, String password) async {

    logout();
    bool isLoading = true;
    notifyListeners();

    final url = '$_baseUrl/api/login';

    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {

      final responseData = json.decode(response.body);
      final token = responseData['token'];
     
      final userResponse =
          await http.get(Uri.parse('$_baseUrl/api/user'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (userResponse.statusCode == 200) {
    
        user = User.fromJson(userResponse.body);
        final userData = jsonDecode(userResponse.body) as Map<String, dynamic>;
        print(userData);
        await storageWrite(token, userData['id'], userData['email'], userData['name']);
        
        bool isLoading = false;
        notifyListeners();

        return true;
      } else {
         print('Failed to login: ${response.statusCode}');
         print('Error response: ${response.body}');
        return false;
        //throw Exception('Failed to fetch user data');
      }
    } else {
       print('Failed to login: ${response.statusCode}');
       print('Error response: ${response.body}');
      return false;
      //throw Exception('Failed to login');
    }
  }

  Future<bool> checkAuth() async {
    final token = await _storage.read(key: 'token');
    if (token == null) {
      return false;
    }
    final url = '$_baseUrl/api/user';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      await _storage.delete(key: 'token');
      return false;
    }
  }

  

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future storageWrite(
      String idToken, int id, String email, String name) async {
    await _storage.write(key: 'token', value: idToken);
    await _storage.write(key: 'id', value: id.toString());
    await _storage.write(key: 'name', value: name);
    await _storage.write(key: 'email', value: email);

  }

  Future<User> readUser() async {
    final id = await _storage.read(key: 'id');
    final name = await _storage.read(key: 'name');
    final email = await _storage.read(key: 'email');

    return User(
      id: int.tryParse(id ?? ''),
      name: name ?? '',
      email: email ?? '',

    );
  }


  

}
