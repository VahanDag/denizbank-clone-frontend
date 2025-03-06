// Note: Some algorithms used in this class (eg TC No Validation)
// are written using AI.
class Validators {
  /// TC Kimlik Numarası doğrulama
  /// 11 haneli olmalı ve tüm karakterler rakam olmalıdır
  /// ex: 70446690950
  static String? validateTCKN(String? value) {
    if (value == null || value.isEmpty) {
      return 'TC Kimlik Numarası boş olamaz';
    }

    // Uzunluk kontrolü
    if (value.length != 11) {
      return 'TC Kimlik Numarası 11 haneli olmalıdır';
    }

    // Sadece rakam kontrolü
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'TC Kimlik Numarası sadece rakamlardan oluşmalıdır';
    }

    // İlk hane 0 olamaz
    if (value[0] == '0') {
      return 'TC Kimlik Numarası 0 ile başlayamaz';
    }

    // TC Kimlik Numarası algoritma kontrolü
    try {
      List<int> digits = value.split('').map((e) => int.parse(e)).toList();

      // 1. 2. 3. 4. 5. 6. 7. 8. 9. ve 10. hanelerin toplamından elde edilen
      // sonucun 10'a bölümünden kalan, son haneyi vermektedir.
      int sum1 = 0;
      for (int i = 0; i < 10; i++) {
        sum1 += digits[i];
      }
      if (sum1 % 10 != digits[10]) {
        return 'Geçersiz TC Kimlik Numarası';
      }

      // 1, 3, 5, 7, 9 basamaklarının toplamının 7 katından, 2, 4, 6, 8 basamaklarının
      // toplamını çıkarttığımızda, elde ettiğimiz sonucun 10'a bölümünden kalan, 10. basamaktır.
      int oddSum = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
      int evenSum = digits[1] + digits[3] + digits[5] + digits[7];

      int result = ((oddSum * 7) - evenSum) % 10;
      if (result < 0) {
        result += 10;
      }

      if (result != digits[9]) {
        return 'Geçersiz TC Kimlik Numarası';
      }

      return null; // Geçerli TCKN
    } catch (e) {
      return 'Geçersiz TC Kimlik Numarası';
    }
  }

  /// Şifre doğrulama
  /// 6 haneli sayı olmalıdır
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre boş olamaz';
    }

    // Uzunluk kontrolü
    if (value.length != 6) {
      return 'Şifre 6 haneli olmalıdır';
    }

    // Sadece rakam kontrolü
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Şifre sadece rakamlardan oluşmalıdır';
    }

    return null; // Geçerli şifre
  }

  /// IBAN validasyonu
  /// TR prefix'i UI tarafında ekleniyor, burada sadece sayı kısmını valide ediyoruz
  static String? validateIban(String? value) {
    if (value == null || value.isEmpty) {
      return 'IBAN numarası boş olamaz';
    }

    // Türkiye IBAN numarası TR + 24 haneden oluşur (sadece rakam kısmını kontrol ediyoruz)
    if (value.length < 24) {
      return 'IBAN numarası eksik, 24 hane olmalıdır';
    }

    // Rakam dışında karakter kontrolü (aslında inputFormatter ile zaten engelleniyor)
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'IBAN numarası sadece rakamlardan oluşmalıdır';
    }

    // Daha karmaşık IBAN doğrulama algoritması (opsiyonel)
    // Bu basit bir implementasyon, gerçek IBAN algoritması daha karmaşıktır
    bool isValid = _validateIbanChecksum("TR$value");
    if (!isValid) {
      return 'Geçersiz IBAN numarası';
    }

    return null;
  }

  /// İsim Soyisim validasyonu
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Alıcı adı soyadı boş olamaz';
    }

    if (value.length < 5) {
      return 'Alıcı adı soyadı çok kısa';
    }

    // Sadece harf ve boşluklar
    if (!RegExp(r'^[a-zA-ZğüşöçıİĞÜŞÖÇ ]+$').hasMatch(value)) {
      return 'Alıcı adı soyadı sadece harflerden oluşmalıdır';
    }

    // En az bir boşluk olmalı (ad ve soyad ayrımı için)
    if (!value.contains(' ')) {
      return 'Lütfen ad ve soyadı birlikte giriniz';
    }

    return null;
  }

  /// Para miktarı validasyonu
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tutar boş olamaz';
    }

    // Sayısal değer kontrolü
    try {
      double amount = double.parse(value);

      if (amount <= 0) {
        return 'Tutar sıfırdan büyük olmalıdır';
      }

      // Maksimum tutar kontrolü ( örnek: 50,000 TL)
      if (amount > 50000) {
        return 'Maksimum transfer tutarı 50.000 TL\'dir';
      }
    } catch (e) {
      return 'Geçersiz tutar';
    }

    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Maksimum uzunluk kontrolü (aslında inputFormatter ile zaten engelleniyor)
    if (value.length > 50) {
      return 'Açıklama en fazla 50 karakter olabilir';
    }

    if (RegExp(r'[<>{}[\]\\]').hasMatch(value)) {
      return 'Açıklama özel karakterler içeremez';
    }

    return null;
  }

  /// IBAN checksum doğrulama (basit implementasyon)
  /// Gerçek implementasyon daha karmaşıktır
  static bool _validateIbanChecksum(String iban) {
    // Gerçek IBAN algoritması bu şekilde değildir.
    // Gerçek algoritma:
    // 1. İlk 4 karakteri sona taşı (TR ve checksum)
    // 2. Harfleri sayılara dönüştür (A=10, B=11...)
    // 3. Sayıyı 97'ye böl ve kalan 1 ise IBAN geçerlidir

    // Bu basit bir kontrol - gerçek projelerde tam IBAN doğrulama kullanılmalı
    if (iban.length != 26) return false; // TR + 24 haneli sayı

    // Basit bir kontrol - uzunluk kontrolü ve ülke kodu kontrolü
    return iban.startsWith('TR');
  }
}
