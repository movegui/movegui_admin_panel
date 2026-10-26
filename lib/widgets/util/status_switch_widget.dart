import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class StatusSwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const StatusSwitchWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: value
              ? colorScheme.primary.withValues(alpha: 0.08)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value
                ? colorScheme.primary.withValues(alpha: 0.30)
                : colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              value ? Icons.check_circle_outline : Icons.pause_circle_outline,
              size: 20,
              color: value ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),

            const SizedBox(width: 8),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                value
                    ? AppLocalizations.of(context)!.actif
                    : AppLocalizations.of(context)!.deactif,
                key: ValueKey(value),
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: value
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(width: 6),

            Switch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
