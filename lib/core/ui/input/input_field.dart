import 'package:athena_ai/core/extension/context.dart';
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
  }) : this(
            key: key,
            controller: controller,
            label: label,
            textInputAction: textInputAction,
            textInputType: TextInputType.url,
            autofillHints: const [AutofillHints.url],
            validator: Validators.apiKey);

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
  late bool obscureText;
  late bool isPassword;

  @override
  void initState() {
    isPassword = widget.textInputType == TextInputType.visiblePassword;
    obscureText = isPassword;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    if (oldWidget.textInputType != widget.textInputType) {
      isPassword = widget.textInputType == TextInputType.visiblePassword;
      obscureText = isPassword;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final validator =
        widget.validator ?? Validators.getValidator(widget.textInputType);
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: obscureText,
      validator: validator,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () => setState(() => obscureText = !obscureText),
                  icon: obscureText
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility_sharp))
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.colorScheme.onSurface))),
    );
  }
}
