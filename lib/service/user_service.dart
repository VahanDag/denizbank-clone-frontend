// service/user_service.dart
import 'dart:convert';
import 'package:denizbank_clone/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class UserService {
  final String baseUrl;
  final AuthService authService;

  UserService({required this.baseUrl, required this.authService});

  Future<User?> getCurrentUser() async {
    final token = await authService.getToken();
    if (token == null) return null;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Accounts/me'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
