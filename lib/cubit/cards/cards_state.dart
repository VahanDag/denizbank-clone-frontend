part of 'cards_cubit.dart';

// @immutable
// sealed class CardsState {}

// final class CardsInitial extends CardsState {}

// final class CardsSelected extends CardsState {
//   final CardModel? selectedDebitCard;
//   final CardModel? selectedCreditCard;

//   CardsSelected(this.selectedDebitCard, this.selectedCreditCard);
// }

// final class CardsLoading extends CardsState {}

// final class CardsLoaded extends CardsState {
//   final TransactionModel? transactions;

//   CardsLoaded(this.transactions);
// }

class CardsState {
  final CardsStatus status;
  final List<CardModel> cards;
  final String? errorMessage;

  CardsState({
    this.status = CardsStatus.initial,
    this.cards = const [],
    this.errorMessage,
  });

  CardsState copyWith({
    CardsStatus? status,
    List<CardModel>? cards,
    String? errorMessage,
  }) {
    return CardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
