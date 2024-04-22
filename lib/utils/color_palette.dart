import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class ColorPalette {
  final BuildContext _context;

  ColorPalette(this._context);

  static of(BuildContext context) => ColorPalette(context);

  bool get _isLightTheme => MyTheme.isLightTheme(_context);

  //black
  Color get black33 => const Color(0xFF333333);
}
