import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'izodiac.dart';

class ZodiacSignVirgo implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_virgo.svg');

  @override
  String get date => '23 AGO - 22 SET';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone => Image.asset(
        'assets/images/zodiac/icon_virgo/virgo.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Virgem';
}
