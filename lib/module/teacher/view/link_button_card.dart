import 'package:flutter/material.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/teacher/model/teacher_model.dart';

class LinkButtonCard extends StatelessWidget {

  final TeacherModel teacher;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const LinkButtonCard({
    super.key,
    required this.teacher,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColor.baseColorShade300,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon,size: TextSize.font16(context),),
              Text(title,style: TextStyle(fontSize: TextSize.font14(context)),),
            ],
          ),
        ),
      ),
    );
  }

}