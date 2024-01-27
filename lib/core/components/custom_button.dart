import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:mobile_customer/core/utilities/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.backgroundColor,
    this.radius,
    this.isLoading,
    required this.onPressed,
    required this.title,
    required this.titleStyle,
  });

  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final String title;
  final bool? isLoading;
  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
            )),
        onPressed: isLoading == true ? null : onPressed,
        child: isLoading == true
            ? const LoadingIndicator(
                indicatorType: Indicator.ballBeat,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                ],
              )
            : Text(
                title,
                style: Style.title2(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
        // Text(
        //   title,
        //   style: titleStyle,
        // ),
      ),
    );
  }
}
