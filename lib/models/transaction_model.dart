class TransactionModel {
  final String? fromIBAN;
  final String? toIBAN;
  final DateTime? date; // String yerine DateTime kullanıldı
  final String fromName;
  final String toName;
  final String? description;
  final double? amount;
  final String? status;
  final String? transactionType; // Eksik olan transactionType alanını ekledim

  TransactionModel({
    this.fromIBAN,
    this.toIBAN,
    this.date,
    required this.fromName,
    required this.toName,
    this.description,
    this.amount,
    this.status,
    this.transactionType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      fromIBAN: json['fromIBAN'] as String?,
      toIBAN: json['toIBAN'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      fromName: json['fromName'] as String,
      toName: json['toName'] as String,
      description: json['description'] as String?,
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null, // num to double conversion
      status: json['status'] as String?,
      transactionType: json['transactionType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromIBAN'] = fromIBAN;
    data['toIBAN'] = toIBAN;
    data['date'] = date?.toIso8601String();
    data['fromName'] = fromName;
    data['toName'] = toName;
    data['description'] = description;
    data['amount'] = amount;
    data['status'] = status;
    data['transactionType'] = transactionType;
    return data;
  }
}
