import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool? autoFocus;
  final bool? readOnly;
  final int? maxLines;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final String? helperText;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final double? borderRadius;
  final String? hintText;
  final bool? showPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    this.autoFocus,
    this.readOnly,
    this.maxLines,
    this.onSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.inputFormatter,
    this.keyboardType,
    this.inputAction,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius,
    this.hintText,
    this.showPassword,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showPassword,
      builder: (_, __, ___) => TextField(
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        obscureText: widget.showPassword == true ? showPassword.value : false,
        autofocus: widget.autoFocus ?? false,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines ?? 1,
        onSubmitted: widget.onSubmitted,
        inputFormatters: widget.inputFormatter ?? [],
        controller: widget.controller,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textInputAction: widget.inputAction ?? TextInputAction.done,
        decoration: InputDecoration(
          helperText: widget.helperText,
          suffixIcon: widget.suffixIcon ??
              (widget.showPassword == true
                  ? IconButton(
                      onPressed: () {
                        showPassword.value = !showPassword.value;
                      },
                      icon: showPassword.value == true
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off),
                    )
                  : null),
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
