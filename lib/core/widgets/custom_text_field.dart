import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool obscureText;
  final String hint;
  final TextInputType keyboardType;
  final bool enabled;
  final Widget? prefix;
  final Widget? suffix;
  final FormFieldValidator<String>? onValidator;
  final Function(String)? onChanged;
  const CustomTextField({
    this.enabled = true,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
     this.label,
     this.onValidator,
     this.onChanged,
    this.prefix,
    this.suffix,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label!=null)...[
          Text(label??"", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 7)
        ]
        ,

        TextFormField(
          validator: onValidator,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          onChanged: onChanged?? (String value){},
          decoration: InputDecoration(
            prefixIcon: prefix,
            hintText: hint,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
