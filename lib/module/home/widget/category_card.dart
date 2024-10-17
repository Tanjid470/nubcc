import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';


class CategoryCard extends StatelessWidget {

  final String image;
  final String title;
  final VoidCallback onTap;
  const CategoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                height: Get.height/6,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image:  DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.baseColor.withOpacity(.5),
                        blurRadius:1,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 2
                      )
                    ]
                ),
              ),
            ),
            Text(title,
              style: TextStyle(
                  fontSize: TextSize.font18(context),
                fontWeight: FontWeight.w500,
              ))
          ],
        )
    );
  }
}