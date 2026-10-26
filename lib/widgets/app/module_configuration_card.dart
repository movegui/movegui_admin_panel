import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/widgets/util/icon_badge_widget.dart';

class ModuleConfigurationCard extends StatelessWidget {
  const ModuleConfigurationCard({super.key, required this.module});

  final ModuleConfigurationItemModel module;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 225),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF9E191F).withValues(alpha: 0.10),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBadgeWidget(icon: module.item.icon, color: module.item.color),
              const SizedBox(width: 13),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    module.item.title,
                    style: const TextStyle(
                      color: Color(0xFF172554),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            module.item.subtitle,
            style: const TextStyle(
              color: Color(0xFF536078),
              height: 1.45,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF7FB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.item.value,
                        style: const TextStyle(
                          color: Color(0xFF172554),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        module.valueLabel,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: module.onPressed,
                style: ElevatedButton.styleFrom(
                //  backgroundColor: PressingConfigurationPage.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(module.buttonLabel),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward, size: 17),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}