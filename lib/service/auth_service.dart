import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl;
  static const String _tokenKey = 'jwt_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthService({required this.baseUrl});

  // Token kontrolü - geçerli token var mı?
  Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    if (token == null) return false;

    // Token'ın süresi dolmuş mu kontrolü yapabilirsiniz
    // JWT decode ederek expiry date kontrolü yapılabilir

    try {
      // Opsiyonel: Backend'e token kontrolü için istek atabilirsiniz
      final response = await http.get(
        Uri.parse('$baseUrl/api/validate-token'),
        headers: {'Authorization': 'Bearer $token'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Giriş işlemi
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

        // Token'ları kaydet
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

  // Çıkış işlemi
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);

    // Opsiyonel: Backend'e logout isteği gönderebilirsiniz
  }

  // Token yenileme
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

        // Yeni token'ları kaydet
        await prefs.setString(_tokenKey, newToken);
        await prefs.setString(_refreshTokenKey, newRefreshToken);

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // JWT token'ı al
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
