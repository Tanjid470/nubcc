

import 'package:flutter/material.dart';
import 'package:nubcc/const/app_colors.dart';

import '../../../const/font_constant.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColor.baseColorShade300
        ),
        child: Center(
          child: Text("Loaction",
            style: TextStyle(
                color: Colors.white,
                fontSize: TextSize.font30(context),
                fontWeight:FontWeight.w500
            ),),
        ),
      ),
    );
  }
}
