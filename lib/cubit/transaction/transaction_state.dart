part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionModel>? transactions;

  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
