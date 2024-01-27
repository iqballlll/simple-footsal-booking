import 'package:flutter/material.dart';
import 'package:mobile_customer/core/utilities/extension.dart';

class Style {
  static TextStyle title(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle title2(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle subtitle1(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle subtitle2(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle subtitle3(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle body1(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle body2(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: Theme.of(context).textTheme.bodyMedium!.color,
      );

  static TextStyle body3(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: Theme.of(context).textTheme.bodySmall!.color,
      );

  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: Theme.of(context).textTheme.bodySmall!.color,
      );

  static TextStyle button(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: context.isDarkMode
            ? Theme.of(context).textTheme.bodySmall!.color
            : Theme.of(context).scaffoldBackgroundColor,
      );

  static const TextStyle tooltip = TextStyle(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    fontFamily: 'PlusJakartaSans',
    height: 1.2,
  );

  static const TextStyle white = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontFamily: 'PlusJakartaSans',
    height: 1.2,
  );

  static const TextStyle red = TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontFamily: 'PlusJakartaSans',
    height: 1.2,
  );

  static const TextStyle green = TextStyle(
    fontSize: 16,
    color: Colors.green,
    fontFamily: 'PlusJakartaSans',
    height: 1.2,
  );

  static const TextStyle yellow = TextStyle(
    fontSize: 16,
    color: Colors.yellow,
    fontFamily: 'PlusJakartaSans',
    height: 1.2,
  );

  ///use this function return "TextStyle" to deal with style changes to text based on state.
  // ignore: long-parameter-list
  static TextStyle dynamic(
    BuildContext context, {
    Color? color,
    double? size,
    FontWeight? fontWeight,
    String? fontFamily,
    TextOverflow? textOverflow,
  }) =>
      TextStyle(
        height: 1.2,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: size ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? 'PlusJakartaSans',
        overflow: textOverflow ?? TextOverflow.ellipsis,
      );
}
