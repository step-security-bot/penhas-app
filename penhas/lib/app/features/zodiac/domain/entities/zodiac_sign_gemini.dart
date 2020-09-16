import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'izodiac.dart';

class ZodiacSignGemini implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_gemini.svg');

  @override
  String get date => '21 MAI - 20 JUN';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone => Image.asset(
        'assets/images/zodiac/icon_gemini/gemini.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Gêmeos';
}
