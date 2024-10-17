import 'package:flutter/material.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/clubCommittee/widget/club_committee_card.dart';

class CustomTextFormat extends StatelessWidget {
  final ClubCommitteeCard widget;
  final String title;
  final String subtitle;

  const CustomTextFormat({
    super.key,
    required this.widget,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$subtitle : ",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: TextSize.font16(context),
                color: AppColor.baseColorShade700
            )
        ),
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: TextSize.font16(context),
                color: Colors.black
            )
        ),
      ],
    );
  }
}