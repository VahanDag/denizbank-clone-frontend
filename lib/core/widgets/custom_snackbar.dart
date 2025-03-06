import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Güvenli snackbar gösterme sistemi
class AppSnackBar {
  /// Snackbar gösterme temel fonksiyonu
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = AppColors.mainBlue,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    IconData? icon,
  }) {
    if (!context.mounted) return;

    try {
      final scaffold = ScaffoldMessenger.of(context);

      // Önceki snackbar'ları temizle
      scaffold.clearSnackBars();

      // Yeni snackbar oluştur
      final snackBar = SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );

      // Snackbar'ı göster
      scaffold.showSnackBar(snackBar);
    } catch (e) {
      print('SnackBar gösterilemiyor: $e');
    }
  }

  /// Başarı mesajı için
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      duration: duration,
      action: action,
    );
  }

  /// Hata mesajı için
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      duration: duration,
      action: action,
    );
  }

  /// Uyarı mesajı için
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
      duration: duration,
      action: action,
    );
  }

  /// Bilgi mesajı için
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: AppColors.mainBlue,
      icon: Icons.info,
      duration: duration,
      action: action,
    );
  }
}
