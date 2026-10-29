import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/util/form_card_widget.dart';
import 'package:movegui_admin_panel/widgets/util/layout_buider_widget.dart';

class SearchFilterRow extends StatelessWidget {
  const SearchFilterRow({
    super.key,
    required this.hintText,
    required this.onSearchChanged,
    required this.filter,
  });

  final String hintText;
  final ValueChanged<String> onSearchChanged;
  final Widget filter;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderWidget(
      use2_1: true,
      children: [
        FormCardWidget(
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        FormCardWidget(child: filter),
      ],
    );

    /*
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: filter),
      ],
    );
    */
  }
}
