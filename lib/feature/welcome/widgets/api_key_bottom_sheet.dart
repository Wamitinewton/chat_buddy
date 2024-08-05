import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/core/ui/input/input_field.dart';
import 'package:flutter/material.dart';

class ApiKeyBottomSheet extends StatefulWidget {
  const ApiKeyBottomSheet(
      {super.key,
      required this.apiKeyController,
      required this.isCalledFromHomePage});

  final TextEditingController apiKeyController;
  final bool isCalledFromHomePage;

  @override
  State<ApiKeyBottomSheet> createState() => _ApiKeyBottomSheetState();
}

class _ApiKeyBottomSheetState extends State<ApiKeyBottomSheet> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                      color: context.colorScheme.onSurface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(2)),
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                const SizedBox(
                  height: 16,
                ),
                InputField.api(controller: widget.apiKeyController),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.onSurface,
                        minimumSize: const Size(double.infinity, 50)),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: context.colorScheme.surface,
                          )
                        : Text(
                            'submit',
                            style: context.textTheme.labelLarge!
                                .copyWith(color: context.colorScheme.surface),
                          ))
              ],
            ),
          ),
        ));
  }
}
