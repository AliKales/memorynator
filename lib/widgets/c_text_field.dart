import 'package:flutter/material.dart';

class CTextField extends TextField {
  CTextField(
      {super.key,
      String? labelText,
      TextEditingController? controller,
      bool readOnly = false,
      Widget? suffixIcon,
      void Function(String)? onChanged,
      int? maxLines = 1})
      : super(
          onChanged: onChanged,
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            suffixIcon: suffixIcon,
          ),
        );
}

class CTextFormField extends TextFormField {
  CTextFormField({
    super.key,
    String? labelText,
    TextEditingController? controller,
    bool readOnly = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
    int? maxLines = 1,
    String? Function(String?)? validator,
  }) : super(
          onChanged: onChanged,
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            suffixIcon: suffixIcon,
          ),
        );
}
