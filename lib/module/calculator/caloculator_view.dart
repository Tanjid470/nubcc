import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';

class CgpaCalculator extends StatefulWidget {
  @override
  _CgpaCalculatorState createState() => _CgpaCalculatorState();
}

class _CgpaCalculatorState extends State<CgpaCalculator> {
  final int maxSemesters = 12;
  List<Semester> semesters = List.generate(12, (_) => Semester());
  final TextEditingController resultController = TextEditingController();
  int selectedSemesters = 4;

  // CGPA calculation logic
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CGPA Calculator",
          style: TextStyle(
              letterSpacing: 5,
              fontSize: TextSize.font24(context),
              fontWeight: FontWeight.w700,
              color: AppColor.baseColor
          ),
        ),
        centerTitle: true,
        foregroundColor: AppColor.baseColor,
        shadowColor: AppColor.baseColorShade500,
        surfaceTintColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<int>(
              value: selectedSemesters,
              items: List.generate(
                maxSemesters,
                    (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text('Calculate for ${index + 1} semesters'),
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
                      Text('Semester ${index + 1}'),
                      Row(
                        children: [
                          // Total Credits Input
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color:semesters[index].credits !=null ? AppColor.baseColor : Colors.grey.shade400), // Normal border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: AppColor.baseColor), // Green if has value
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.red), // Color when focused
                                ), 

                              ),
                              maxLength: 2,

                              textAlign: TextAlign.justify,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  semesters[index].credits = double.tryParse(value);
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          // CGPA Input
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                hintText: "CGPA",
                                hintStyle: TextStyle(
                                  fontFamily: 'HindSiliguri',
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color:semesters[index].cgpa !=null ? AppColor.baseColor : Colors.grey.shade400), // Normal border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: AppColor.baseColor), // Green if has value
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.red), // Color when focused
                                ), 

                              ),
                              
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^([0-3](\.\d{0,2})?|4(\.0{0,2})?)$')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  semesters[index].cgpa = double.tryParse(value);
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
            // Dropdown to select number of semesters

            SizedBox(height: 16),
            // Calculate Button
            ElevatedButton(
              onPressed: () {
                double cgpa = calculateCGPA();
                resultController.text = cgpa.toStringAsFixed(2);
              },
              child: Text('Calculate CGPA'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),
            // Display CGPA Result
            TextField(
              controller: resultController,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Total CGPA',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Semester {
  double? credits;
  double? cgpa;

  Semester({this.credits, this.cgpa});
}
