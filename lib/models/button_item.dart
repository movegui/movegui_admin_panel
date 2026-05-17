

import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/widget_item.dart';

class ButtonItem extends WidgetItem{
  final String tooltipText;
  final double fontSize;
  final bool enabled;
  final  Function() onPress;
  ButtonItem(super.title,{required  this.onPress, required this.tooltipText, required this.enabled, this.fontSize=WidgetConstants.buttonFonsize, required super.routeName});
}