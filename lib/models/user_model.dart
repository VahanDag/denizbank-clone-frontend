// Account.cs ve AccountDto'ya karşılık gelir
import 'package:denizbank_clone/models/card_model.dart';

class User {
  final int id; // uint -> int
  final String name;
  final int tcNo; // ulong -> int
  final List<CardModel> cards;

  User({
    required this.id,
    required this.name,
    required this.tcNo,
    required this.cards,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'] as int,
        name: json['name'] as String,
        tcNo: _parseTcNo(json['tcNo']),
        cards: (json['cards'] as List<dynamic>).map((e) => CardModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
    } catch (e) {
      print('Error parsing User.fromJson: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tcNo': tcNo,
      'cards': cards.map((e) => e.toJson()).toList(),
    };
  }

  // TC kimlik numarası için yardımcı metod
  static int _parseTcNo(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, tcNo: $tcNo, cards: ${cards.length})';
  }
}
