import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final String baseUrl;
  static const String _tokenKey = 'jwt_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthService({required this.baseUrl});

  Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    if (token == null) return false;

    try {
      bool isTokenExpired = JwtDecoder.isExpired(token);

      return !isTokenExpired;
    } catch (e) {
      print('Token decode edilirken hata oluştu: $e');
      return false;
    }
  }

  Future<bool> login({required int tcNo, required int password}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Accounts/login'),
        body: jsonEncode({
          'tcNo': tcNo,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, token);

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  Future<bool> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString(_refreshTokenKey);

    if (refreshToken == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/refresh-token'),
        body: jsonEncode({'refreshToken': refreshToken}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newToken = data['token'];
        final newRefreshToken = data['refreshToken'];

        await prefs.setString(_tokenKey, newToken);
        await prefs.setString(_refreshTokenKey, newRefreshToken);

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
