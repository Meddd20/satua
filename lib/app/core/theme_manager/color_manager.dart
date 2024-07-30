import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryGreen = HexColor.fromHex('#00B567');
  static Color secondaryGreen = HexColor.fromHex('#8FDEBC');
  static Color grey = HexColor.fromHex('#777675');
  static Color lightGrey = HexColor.fromHex('#E8E8E8');
  static Color disableAndConstrast = HexColor.fromHex('#B2B2B2');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black4 = HexColor.fromHex('#393938');
  static Color secondaryBlack = HexColor.fromHex('#535353');
  static Color secondaryGrey = HexColor.fromHex('#B9B9B9');
  static Color primaryYellow = HexColor.fromHex('#FFDE00');
  static Color secondaryYellow = HexColor.fromHex('#FFF08A');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

MaterialColor getMaterialColor(Color color) {
  final Map<int, Color> shades = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };
  return MaterialColor(color.value, shades);
}
