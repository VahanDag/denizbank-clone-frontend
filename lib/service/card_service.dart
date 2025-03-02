import 'dart:convert';

import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/models/card_model.dart';
import 'package:denizbank_clone/service/auth_service.dart';
import 'package:http/http.dart' as http;

class CardService {
  final String baseUrl;
  final AuthService authService;
  CardService({required this.baseUrl, required this.authService});

  Future<List<CardModel>> getCards() async {
    final token = await authService.getToken();
    if (token == null) return [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/myCards'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => CardModel.fromJson(item)).toList();
      } else {
        print('Kart bilgileri alınamadı: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Kart bilgileri alınırken hata: $e');
      return [];
    }
  }

  Future<CardModel?> createCard() async {
    final token = await authService.getToken();
    if (token == null) return null;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Cards/createCard'),
        body: jsonEncode({
          'cardType': 'Debit',
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CardModel.fromJson(data);
      } else {
        print('Kart oluşturulamadı: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Kart oluşturulurken hata: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getTransactions({TransactionTypeEnum? transactionType}) async {
    final token = await authService.getToken();
    if (token == null) return null;

    try {
      // URL'ye transactionType parametresi ekleyin (eğer belirtilmişse)
      String url = '$baseUrl/Transactions/getTransactions';
      if (transactionType != null) {
        url += '?transactionType=${transactionType.index}';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        print('İşlem bilgileri alınamadı: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('İşlem bilgileri alınırken hata: $e');
      return null;
    }
  }
}
