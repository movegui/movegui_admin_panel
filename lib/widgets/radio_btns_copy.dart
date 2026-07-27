import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

class MyRadioBtn extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const MyRadioBtn({super.key, required this.onChanged});

  @override
  _RadioBtnState createState() => _RadioBtnState();
}

class _RadioBtnState extends State<MyRadioBtn> {
  int? _selectedValue =1;

  @override
  Widget build(BuildContext context) {
    final options = [
      {"label": "KG", "value": 1},
      {"label": "Piece", "value": 2},
      {"label": "Litre", "value": 3},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<int>(
              activeColor: Colors.blue,
              focusColor: Colors.blue,
              value: int.parse(option['value'].toString()),
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onChanged(value!);
              },
            ),
            Text(option['label'].toString(), style: TextStyle( fontSize: 18),),
          ],
        );
      }).toList(),
    );
  }
}
