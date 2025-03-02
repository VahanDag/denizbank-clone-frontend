import 'package:denizbank_clone/core/constants/enums.dart';

// DenizBankCard sınıfına karşılık gelir
class CardType {
  final int id;
  final String cardName;
  final CardTypeEnum cardType;
  final String cardDescription;
  final String imageURI;

  CardType({
    required this.id,
    required this.cardName,
    required this.cardType,
    required this.cardDescription,
    required this.imageURI,
  });

  factory CardType.fromJson(Map<String, dynamic> json) {
    return CardType(
      id: json['id'] as int,
      cardName: json['cardName'] as String,
      cardType: _parseCardTypeEnum(json['cardType']),
      cardDescription: json['cardDescription'] as String,
      // Backend'de varsayılan bir değer var, ancak API null dönebilir
      imageURI: json['imageURI'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardName': cardName,
      'cardType': cardType.toString().split('.').last,
      'cardDescription': cardDescription,
      'imageURI': imageURI,
    };
  }

  static CardTypeEnum _parseCardTypeEnum(String value) {
    return CardTypeEnum.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => CardTypeEnum.Credit,
    );
  }

  @override
  String toString() {
    return 'CardType(id: $id, name: $cardName, type: $cardType)';
  }
}

// Card.cs sınıfına karşılık gelir
class CardModel {
  final int id;
  final int accountId; // uint -> int
  final String cardNumber;
  final CardType cardType;
  final int csv; // ushort -> int
  final String expirationDate;
  final double balance; // decimal -> double
  final double? balanceLimit; // nullable, decimal? -> double?
  final double? debt; // nullable, decimal? -> double?
  final int? cutOfDate; // nullable, ushort? -> int?
  final String? iban; // nullable

  CardModel({
    required this.id,
    required this.accountId,
    required this.cardNumber,
    required this.cardType,
    required this.csv,
    required this.expirationDate,
    required this.balance,
    this.balanceLimit,
    this.debt,
    this.cutOfDate,
    this.iban,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int,
      accountId: json['accountId'] as int,
      cardNumber: json['cardNumber'] as String,
      cardType: CardType.fromJson(json['cardType'] as Map<String, dynamic>),
      csv: json['csv'] as int,
      expirationDate: json['expirationDate'] as String,
      balance: _parseDouble(json['balance']),
      balanceLimit: json['balanceLimit'] != null ? _parseDouble(json['balanceLimit']) : null,
      debt: json['debt'] != null ? _parseDouble(json['debt']) : null,
      cutOfDate: json['cutOfDate'] as int?,
      iban: json['iban'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'cardNumber': cardNumber,
      'cardType': cardType.toJson(),
      'csv': csv,
      'expirationDate': expirationDate,
      'balance': balance,
      'balanceLimit': balanceLimit,
      'debt': debt,
      'cutOfDate': cutOfDate,
      'iban': iban,
    };
  }

  // Sayısal değerleri güvenli bir şekilde double'a dönüştürmek için yardımcı metod
  static double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  @override
  String toString() {
    return 'CardModel(id: $id, number: $cardNumber, type: ${cardType.cardName})';
  }
}
