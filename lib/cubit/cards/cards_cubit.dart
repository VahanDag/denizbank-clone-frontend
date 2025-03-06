import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:denizbank_clone/models/card_model.dart';
import 'package:denizbank_clone/service/card_service.dart';
part 'cards_state.dart';

enum CardsStatus { initial, loading, loaded, error }

class CardsCubit extends Cubit<CardsState> {
  final CardService _cardService;

  CardsCubit(this._cardService) : super(CardsState());

  CardModel? _selectedDebitCard;
  CardModel? _selectedCreditCard;

  CardModel? get selectedDebitCard => _selectedDebitCard;
  CardModel? get selectedCreditCard => _selectedCreditCard;

  Future<void> loadCards() async {
    emit(state.copyWith(status: CardsStatus.loading));

    try {
      final cards = await _cardService.getCards();
      emit(state.copyWith(
        status: CardsStatus.loaded,
        cards: cards,
      ));

      _selectDefaultCards(cards);
    } catch (e) {
      emit(state.copyWith(
        status: CardsStatus.error,
        errorMessage: 'Kart bilgileri alınamadı: ${e.toString()}',
      ));
    }
  }

  void _selectDefaultCards(List<CardModel> cards) {
    if (cards.isEmpty) return;

    final debitCards = cards.where((card) => card.cardType.cardType == CardTypeEnum.Debit).toList();
    if (debitCards.isNotEmpty && _selectedDebitCard == null) {
      _selectedDebitCard = debitCards.first;
    }

    final creditCards = cards.where((card) => card.cardType.cardType == CardTypeEnum.Credit).toList();
    if (creditCards.isNotEmpty && _selectedCreditCard == null) {
      _selectedCreditCard = creditCards.first;
    }
  }

  Future<void> createCard(int cardID, bool isDebit) async {
    emit(state.copyWith(status: CardsStatus.loading));

    try {
      final newCard = await _cardService.createCard(cardID, isDebit);
      if (newCard != null) {
        final updatedCards = [...state.cards, newCard];
        emit(state.copyWith(
          status: CardsStatus.loaded,
          cards: updatedCards,
        ));
      } else {
        emit(state.copyWith(
          status: CardsStatus.error,
          errorMessage: 'Kart oluşturulamadı',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CardsStatus.error,
        errorMessage: 'Kart oluşturulurken hata: ${e.toString()}',
      ));
    }
  }

  void selectCard(CardModel card) {
    if (card.cardType.cardType == CardTypeEnum.Debit) {
      _selectedDebitCard = card;
    } else if (card.cardType.cardType == CardTypeEnum.Credit) {
      _selectedCreditCard = card;
    }

    emit(state.copyWith(status: state.status));
  }

  Future<List<CompanyCardModel>> getCompanyCards(bool isDebitCard) async {
    final response = await _cardService.getCompanyCards(isDebitCard ? CardTypeEnum.Debit : CardTypeEnum.Credit);
    if (response != null) {
      return response;
    } else {
      return [];
    }
  }
}
