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

  //white
  Color get white50 => const Color(0x80FFFFFF);

  //grey
  Color get grey66 => const Color(0xFF666666);
  Color get grey99 => const Color(0xFF999999);
  Color get greyEEE => const Color(0xFFEEEDED);
  Color get greyF2F => const Color(0xFFF2F2F2);
  Color get greyD9D => const Color(0xFFD9D9D9);
  Color get greyCBC => const Color(0xFFCBCCCB);
  Color get greyBFB => const Color(0xFFFBFBFB);
  Color get greyDBD => const Color(0xFFBDBDBD);
  Color get greyDED => const Color(0xFFEEEDED);

  //blue
  Color get blueC2E => const Color(0xFFC2E7D6);
  Color get blueA3C => const Color(0xFFA3CDBA);
  Color get blue8DD => const Color(0xFF8DD0B1);

  //yellow
  Color get yellowFFC => const Color(0xFFFFC24F);

  //red
  Color get redE42 => const Color(0xFFE4290D);
  Color get red232 => const Color(0xFFD83232);
  Color get redE66 => const Color(0xFFE66451);

  //green
  Color get green008 => const Color(0xBB00894A);

  Color get facebook => const Color(0xFF1877F2);

  Color get blackB0B => const Color(0xFF0B0B0B);
}
