enum AuthStatus {
  initial, // Başlangıç durumu
  loading, // Yükleniyor durumu
  authenticated, // Giriş yapılmış
  unauthenticated, // Giriş yapılmamış
  error, // Hata durumu
}

enum ActionsEnum {
  sendMoney,
  payBill,
  qrActions,
  publishIBAN,
  cardDetail,
  payDebt,
  cashAdvance, // nakit avans
  updateLimits
}

enum IconEnum {
  sendMoney,
  payBill,
  qrActions,
  publishIBAN,
  cardDetail,
  payDebt,
  cashAdvance,
  updateLimits,
  information,
  identity,
  shake_hands
}

enum CardTypeEnum { Credit, Debit }

enum UserStatus { initial, loading, loaded, error }
