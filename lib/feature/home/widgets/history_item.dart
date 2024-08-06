import 'package:athena_ai/core/extension/context.dart';
import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {super.key,
      required this.label,
      required this.imagePath,
      required this.color});

  final String label;
  final String imagePath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface,
            foregroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side:
                    BorderSide(color: context.colorScheme.outline, width: 0.5)),
            padding: const EdgeInsets.all(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(imagePath),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.95)),
            )),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: context.colorScheme.onSurface,
              ),
            )
          ],
        ),
      ),
    );
  }
}
