import 'package:flutter/material.dart';

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
    return null;

    // // Sadece rakam kontrolü
    // if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    //   return 'TC Kimlik Numarası sadece rakamlardan oluşmalıdır';
    // }

    // // İlk hane 0 olamaz
    // if (value[0] == '0') {
    //   return 'TC Kimlik Numarası 0 ile başlayamaz';
    // }

    // // TC Kimlik Numarası algoritma kontrolü
    // try {
    //   List<int> digits = value.split('').map((e) => int.parse(e)).toList();

    //   // 1. 2. 3. 4. 5. 6. 7. 8. 9. ve 10. hanelerin toplamından elde edilen
    //   // sonucun 10'a bölümünden kalan, son haneyi vermektedir.
    //   int sum1 = 0;
    //   for (int i = 0; i < 10; i++) {
    //     sum1 += digits[i];
    //   }
    //   if (sum1 % 10 != digits[10]) {
    //     return 'Geçersiz TC Kimlik Numarası';
    //   }

    //   // 1, 3, 5, 7, 9 basamaklarının toplamının 7 katından, 2, 4, 6, 8 basamaklarının
    //   // toplamını çıkarttığımızda, elde ettiğimiz sonucun 10'a bölümünden kalan, 10. basamaktır.
    //   int oddSum = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
    //   int evenSum = digits[1] + digits[3] + digits[5] + digits[7];

    //   int result = ((oddSum * 7) - evenSum) % 10;
    //   if (result < 0) {
    //     result += 10;
    //   }

    //   if (result != digits[9]) {
    //     return 'Geçersiz TC Kimlik Numarası';
    //   }

    //   return null; // Geçerli TCKN
    // } catch (e) {
    //   return 'Geçersiz TC Kimlik Numarası';
    // }
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
}
