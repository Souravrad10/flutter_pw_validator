import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/SizeConfig.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_play/constants/app_theme.dart';
import 'package:just_play/constants/colors.dart';

/// ValidationTextWidget that represent style of each one of them and shows as list of condition that you want to the app user
class ValidationTextWidget extends StatelessWidget {
  final Color color;
  final SvgPicture? svgPicture;
  final String text;
  final int? value;

  const ValidationTextWidget(
      {Key? key, required this.color, required this.text, required this.value, this.svgPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.width! * 0.03,
          height: SizeConfig.width! * 0.03,
          child: CircleAvatar(
            child: svgPicture,
            backgroundColor: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.width! * 0.03),
          child: Text(
            text.replaceFirst("-", value.toString()),
            style: themeData.textTheme.bodyText2?.copyWith(color: color,
          fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.25,
              letterSpacing: 0.41
    ),
          ),
        )
      ],
    );
  }
}
