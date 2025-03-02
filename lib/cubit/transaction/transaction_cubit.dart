import 'package:denizbank_clone/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/service/card_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final CardService _cardService;

  TransactionCubit(this._cardService) : super(TransactionInitial());

  Future<void> loadTransactions({TransactionTypeEnum? transactionType}) async {
    emit(TransactionLoading());

    try {
      final transactions = await _cardService.getTransactions(
        transactionType: transactionType,
      );

      if (transactions != null) {
        final transactionsModel = transactions.map((transaction) => TransactionModel.fromJson(transaction)).toList();
        emit(TransactionLoaded(transactionsModel));
      } else {
        emit(TransactionError('İşlem bilgileri alınamadı'));
      }
    } catch (e) {
      emit(TransactionError('İşlem bilgileri alınamadı: ${e.toString()}'));
    }
  }

  // Belirli bir işlem tipine göre işlemleri filtreleme
  Future<void> filterTransactions(TransactionTypeEnum transactionType) async {
    await loadTransactions(transactionType: transactionType);
  }

  // Tüm işlemleri yükleme
  Future<void> loadAllTransactions() async {
    await loadTransactions();
  }
}
