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

  Future<void> filterTransactions(TransactionTypeEnum transactionType) async {
    await loadTransactions(transactionType: transactionType);
  }

  Future<void> loadAllTransactions() async {
    await loadTransactions();
  }

  Future<bool> sendMoney({
    required String fromIBAN,
    required String toIBAN,
    required double amount,
    String? description,
  }) async {
    emit(TransactionLoading());

    try {
      final result = await _cardService.transferMoney(
        fromIBAN,
        toIBAN,
        amount,
        description,
      );

      if (result != null) {
        await loadTransactions();
        return true;
      } else {
        emit(TransactionError('Para transferi başarısız oldu.'));
        return false;
      }
    } catch (e) {
      emit(TransactionError('Para transferi sırasında hata: ${e.toString()}'));
      return false;
    }
  }
}
