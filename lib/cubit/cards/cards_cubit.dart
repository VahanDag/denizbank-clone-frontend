import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:denizbank_clone/models/card_model.dart';
import 'package:denizbank_clone/service/card_service.dart';
part 'cards_state.dart';

// Card durumları için enum
enum CardsStatus { initial, loading, loaded, error }

class CardsCubit extends Cubit<CardsState> {
  final CardService _cardService;

  CardsCubit(this._cardService) : super(CardsState());

  // Seçilen kartlar için değişkenler
  CardModel? _selectedDebitCard;
  CardModel? _selectedCreditCard;

  // Getter'lar
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

      // Kartlar yüklendiğinde varsayılan kartları seç
      _selectDefaultCards(cards);
    } catch (e) {
      emit(state.copyWith(
        status: CardsStatus.error,
        errorMessage: 'Kart bilgileri alınamadı: ${e.toString()}',
      ));
    }
  }

  // Varsayılan kartları seçme işlemi
  void _selectDefaultCards(List<CardModel> cards) {
    if (cards.isEmpty) return;

    // Varsayılan banka kartını seç
    final debitCards = cards.where((card) => card.cardType.cardType == CardTypeEnum.Debit).toList();
    print("selecting debit card");
    if (debitCards.isNotEmpty && _selectedDebitCard == null) {
      print("selected debit card");
      _selectedDebitCard = debitCards.first;
    }

    // Varsayılan kredi kartını seç
    final creditCards = cards.where((card) => card.cardType.cardType == CardTypeEnum.Credit).toList();
    if (creditCards.isNotEmpty && _selectedCreditCard == null) {
      _selectedCreditCard = creditCards.first;
    }
  }

  Future<void> createCard() async {
    emit(state.copyWith(status: CardsStatus.loading));

    try {
      final newCard = await _cardService.createCard();
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

  // Kart seçme fonksiyonu
  void selectCard(CardModel card) {
    // Kart tipine göre farklı değişkenlere ata
    if (card.cardType.cardType == CardTypeEnum.Debit) {
      _selectedDebitCard = card;
    } else if (card.cardType.cardType == CardTypeEnum.Credit) {
      _selectedCreditCard = card;
    }

    // State güncellemesi yap (UI yenilensin diye)
    emit(state.copyWith(status: state.status));
  }
}
