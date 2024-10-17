import 'package:flutter/material.dart';
import 'package:nubcc/const/app_colors.dart';
import '../../../const/font_constant.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
          child: Text("Profile",
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
