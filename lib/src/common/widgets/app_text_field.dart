import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    this.onTap,
    required this.placeholder,
    this.readOnly = false,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController controller;
  final String placeholder;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      maxLength: maxLength,
      placeholder: placeholder,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
