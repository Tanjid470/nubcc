import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';
import 'package:nubcc/const/text_style.dart';

class CgpaCalculator extends StatefulWidget {
  const CgpaCalculator({super.key});

  @override
  _CgpaCalculatorState createState() => _CgpaCalculatorState();
}

class _CgpaCalculatorState extends State<CgpaCalculator> {
  final int maxSemesters = 12;
  List<Semester> semesters = List.generate(12, (_) => Semester());
  final TextEditingController resultController = TextEditingController();
  int selectedSemesters = 4;
  List<bool> errors = List.generate(12, (_) => false);

  double calculateCGPA() {
    double totalCredits = 0;
    double totalWeightedCGPA = 0;

    for (var i = 0; i < selectedSemesters; i++) {
      if (semesters[i].credits != null && semesters[i].cgpa != null) {
        totalCredits += semesters[i].credits!;
        totalWeightedCGPA += (semesters[i].credits! * semesters[i].cgpa!);
      }
    }

    return totalCredits > 0 ? totalWeightedCGPA / totalCredits : 0.0;
  }

  bool validateFields() {
    bool isValid = true;
    for (var i = 0; i < selectedSemesters; i++) {
      if (semesters[i].credits == null || semesters[i].cgpa == null) {
        errors[i] = true;
        isValid = false;
      } else {
        errors[i] = false;
      }
    }
    setState(() {}); // Refresh UI to show red borders
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CGPA Calculator",
          style: TextStyle(
              letterSpacing: 5,
              fontSize: TextSize.font24(context),
              fontWeight: FontWeight.w700,
              color: AppColor.baseColor),
        ),
        centerTitle: true,
        foregroundColor: AppColor.baseColor,
        shadowColor: AppColor.baseColorShade500,
        surfaceTintColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Column(
          children: [
            DropdownButton<int>(
              value: selectedSemesters,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              items: List.generate(
                maxSemesters,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text(
                    'Calculate for ${index + 1} semesters',
                    style: baseColorText2(TextSize.font16(context)),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedSemesters = value!;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: selectedSemesters,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semester ${index + 1}',
                        style: baseColorText2(TextSize.font15(context)),
                      ),
                      Row(
                        children: [
                          // Total Credits Input
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                hintText: "Total credits",
                                hintStyle: TextStyle(
                                  fontFamily: 'HindSiliguri',
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: errors[index] && semesters[index].credits == null
                                          ? Colors.red.shade300
                                          : AppColor.baseColorShade500), // Error border color if missing
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: AppColor.baseColorShade500), // Green if has value
                                ),
                              ),
                              maxLength: 2,
                              textAlign: TextAlign.justify,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  semesters[index].credits =
                                      double.tryParse(value);
                                  errors[index] = false; // Reset error state on input
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                hintText: "CGPA",
                                hintStyle: TextStyle(
                                  fontFamily: 'HindSiliguri',
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: errors[index] && semesters[index].cgpa == null
                                          ? Colors.red.shade300
                                          : AppColor.baseColorShade500),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: AppColor.baseColorShade500), 
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'^([0-3](\.\d{0,2})?|4(\.0{0,2})?)$')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  semesters[index].cgpa =
                                      double.tryParse(value);
                                  errors[index] = false; // Reset error state on input
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            resultShow()
          ],
        ),
      ),
    );
  }

  Widget resultShow() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (validateFields()) {
                  double cgpa = calculateCGPA();
                  resultController.text = cgpa.toStringAsFixed(2);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.baseColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(2, 2))
                    ]),
                child: Text(
                  'Calculate CGPA',
                  style: whiteText(TextSize.font16(context)),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: resultController,
              readOnly: true,
              textAlign: TextAlign.center,
              style: baseColorText(TextSize.font16(context)),
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                hintText: " Total CGPA",
                hintStyle: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: TextSize.font16(context),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                      color: AppColor.baseColor), // Normal border color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Semester {
  double? credits;
  double? cgpa;

  Semester({this.credits, this.cgpa});
}
