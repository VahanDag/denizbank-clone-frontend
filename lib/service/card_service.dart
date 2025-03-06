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

  Future<CardModel?> createCard(int cardID, bool isDebit) async {
    final token = await authService.getToken();
    if (token == null) return null;

    try {
      print(cardID);
      final requestBody = {
        'cardType': isDebit ? CardTypeEnum.Debit.name : CardTypeEnum.Credit.name,
        'denizBankCardId': cardID,
      };
      print('İstek gövdesi: $requestBody');

      final response = await http.post(
        Uri.parse('$baseUrl/createCardForUser'),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CardModel.fromJson(data);
      } else {
        print('Kart oluşturulamadı: ${response.body}');
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

  Future<List<CompanyCardModel>?> getCompanyCards(CardTypeEnum? cardType) async {
    final token = await authService.getToken();
    if (token == null) return null;

    try {
      final uri = Uri.parse('$baseUrl/getDenizBankCards');

      final uriWithParams = cardType != null ? uri.replace(queryParameters: {'cardType': cardType.name}) : uri;

      final response = await http.get(
        uriWithParams,
        headers: {'accept': 'text/plain', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((e) => CompanyCardModel.fromJson(e)).toList();
      } else {
        print('Kartlar Çekilemedi: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Kartlar çekilirken hata: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> transferMoney(String fromIBAN, String toIBAN, double amount, String? description) async {
    final token = await authService.getToken();
    if (token == null) return null;

    try {
      final requestBody = {
        'fromIBAN': fromIBAN,
        'toIBAN': toIBAN,
        'amount': amount,
        'description': description ?? '',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/Transactions/transferMoney'),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print('Para transferi başarısız: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Para transferi sırasında hata: $e');
      return null;
    }
  }
}
