import 'package:athena_ai/core/util/validators.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.controller,
      required this.label,
      required this.textInputAction,
      required this.textInputType,
      this.autofillHints,
      this.validator,
      this.onFieldSubmitted});

      const InputField.api({
        required TextEditingController controller,
        String label = "Gemini API Key",
        TextInputAction textInputAction = TextInputAction.done,
        Key? key,
      }): this(
        key: key,
        controller: controller,
        label: label,
        textInputAction: textInputAction,
        textInputType: TextInputType.url,
        autofillHints: const [AutofillHints.url],
        validator: Validators.apiKey
      );

  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final List<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
