import 'package:flutter/widgets.dart';

class DisplayWidget extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  

  const DisplayWidget({super.key, required this.text, this.textAlign = TextAlign.center});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(text ?? '',  textAlign: textAlign,),    
    );
  }
}
