import 'package:flutter/material.dart';
import 'package:nubcc/const/app_colors.dart';


TextStyle whiteText(double fontSize){
  return  TextStyle(
            letterSpacing: 2,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color:Colors.white
  );
}

TextStyle baseColorText(double fontSize){
  return  TextStyle(
            letterSpacing: 2,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColor.baseColor
  );
}
TextStyle baseColorText2(double fontSize){
  return TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColor.baseColor
  );
}