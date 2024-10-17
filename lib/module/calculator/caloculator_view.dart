import 'package:flutter/material.dart';

class CgpaCalculator extends StatefulWidget {
  @override
  _CgpaCalculatorState createState() => _CgpaCalculatorState();
}

class _CgpaCalculatorState extends State<CgpaCalculator> {
  final int maxSemesters = 8;
  List<Semester> semesters = List.generate(8, (_) => Semester());
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
      appBar: AppBar(title: Text('CGPA Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
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
                                labelText: 'Total Credits',
                                border: OutlineInputBorder(),
                              ),
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
                                labelText: 'CGPA',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  semesters[index].cgpa = double.tryParse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            // Dropdown to select number of semesters
            DropdownButton<int>(
              value: selectedSemesters,
              items: List.generate(
                maxSemesters,
                    (index) => DropdownMenuItem(
                  child: Text('Calculate for ${index + 1} semesters'),
                  value: index + 1,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedSemesters = value!;
                });
              },
            ),
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
