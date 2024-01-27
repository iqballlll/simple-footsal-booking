import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DarkMode on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;

    return brightness == Brightness.dark;
  }
}

extension Capitalize on String {
  String capitalFirstWord() {
    return this[0].toUpperCase() + substring(1);
  }
}

extension BoolExtension on bool {
  bool get isTrue => this == true;
  bool get isFalse => this == false;
}

extension ToConvert on String {
  String toYMD() {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(this);
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  String toIndonesianDate() {
    List<String> dateParts = split('-');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[2]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[0]);

      final List<String> monthNames = [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];

      String monthName = monthNames[month - 1];

      return '$day $monthName $year';
    } else {
      return 'Invalid date format';
    }
  }

  String toIDR() {
    try {
      double amount = double.parse(this);

      NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp',
        decimalDigits: 0,
      );
      return currencyFormatter.format(amount);
    } catch (e) {
      return 'Invalid Input';
    }
  }
}
