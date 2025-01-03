import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/module/login/controller/login_controller.dart';

import '../../userInfo/view/user_info_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height / 4,
              width: Get.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp1h3qYy8OpOB4geiNhLYaIQshlHIcnkO_putaGmngO-4EEiL59av-DcDsLCdQdIEJZ8&usqp=CAU"))),
            ),
            inputHeader(context, "Email"),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: loginController.emailController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColor.baseColor,
                  )),
              child: TextField(
                controller: loginController.emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'HindSiliguri',
                    // color: HexColor('#7A7A7A'),
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: "Enter your email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: loginController.emailController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColor.baseColor,
                  ),
                  hintStyle: TextStyle(
                      fontFamily: 'HindSiliguri',
                      color: Colors.grey.shade400,
                      fontSize: 16),
                  //hintStyle: const TextStyle(color: Colors.orangeAccent),
                ),
                onChanged: (value) {
                  loginController.saveButtonEnable();
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            actionButton(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don\'t have an account?",
                  style: TextStyle(
                      fontSize: TextSize.font16(context),
                      fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserInfoScreen()),
                    );
                  },
                  child: Text(
                    " Register",
                    style: TextStyle(
                        fontSize: TextSize.font18(context),
                        fontWeight: FontWeight.w700,
                        color: AppColor.baseColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding inputHeader(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: TextSize.font15(context),
          fontWeight: FontWeight.w600,
          color: const Color(0xff5E6579),
        ),
      ),
    );
  }

  Widget actionButton() {
    return Obx(
      () {
        return loginController.saveButtonEnableFlag.value
            ? InkWell(
                onTap: () {
                  SmartDialog.showLoading();
                  loginController.login(loginController.emailController.text);
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(colors: [
                          AppColor.baseColor,
                          AppColor.baseColorShade700
                        ]),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black, offset: Offset(1.5, 1.5))
                        ]),
                    height: 50,
                    width: double.maxFinite,
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'HindSiliguri',
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: TextSize.font20(context)),
                        textAlign: TextAlign.center,
                      ),
                    )))
            : Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey.shade500,
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
                    ]),
                height: 50,
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'HindSiliguri',
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: TextSize.font20(context)),
                    textAlign: TextAlign.center,
                  ),
                ));
      },
    );
  }
}
