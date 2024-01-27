import 'package:flutter/material.dart';
import 'package:mobile_customer/core/utilities/style.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.title,
    required this.bgColor,
  });
  final String title;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Center(
          child: Text(
            _getTitle(title),
            style: Style.white,
          ),
        ),
      ),
    );
  }

  static Color getColor(String status) {
    switch (status) {
      case 'initial':
        return Colors.orange;
      case 'down_payment':
        return Colors.blue;
      case 'paid':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  String _getTitle(String title) {
    switch (title) {
      case 'initial':
        return "Initial";
      case 'down_payment':
        return "DP";
      case 'paid':
        return "Lunas";
      default:
        return "Dibatalkan";
    }
  }
}
