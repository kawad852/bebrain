import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class ColorPalette {
  final BuildContext _context;

  ColorPalette(this._context);

  static of(BuildContext context) => ColorPalette(context);

  bool get _isLightTheme => MyTheme.isLightTheme(_context);

  ///common
  Color get white => Colors.white;
  Color get black => Colors.black;

  //black
  Color get black33 => const Color(0xFF333333);



  //grey
  Color get grey66 => const Color(0xFF666666);
  Color get grey99 => const Color(0xFF999999);
  Color get greyEEE => const Color(0xFFEEEDED);
  Color get greyF2F => const Color(0xFFF2F2F2);




  //blue
  Color get blueC2E => const Color(0xFFC2E7D6);
  Color get blueA3C => const Color(0xFFA3CDBA);




}
