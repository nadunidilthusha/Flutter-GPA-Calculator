import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'gpa_calculator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> courseControllers = [];
  final List<FocusNode> focusNodes = [];
  final List<int> selectedCredits = [];
  final List<String> selectedGrades = [];
  final List<double> gradePoints = [];

  @override
  void initState() {
    super.initState();
    addCourse(); // Start with one course
  }

  void addCourse() {
    setState(() {
      courseControllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      selectedCredits.add(1);
      selectedGrades.add('A');
      gradePoints.add(4.0);
    });
  }

  void removeCourse(int index) {
    if (courseControllers.length > 1) {
      setState(() {
        courseControllers[index].dispose();
        focusNodes[index].dispose();
        courseControllers.removeAt(index);
        focusNodes.removeAt(index);
        selectedCredits.removeAt(index);
        selectedGrades.removeAt(index);
        gradePoints.removeAt(index);
      });
    }
  }

  void calculateGPA() {
    if (!_formKey.currentState!.validate()) return;

    double totalPoints = 0, totalCredits = 0;

    for (int i = 0; i < courseControllers.length; i++) {
      double credit = selectedCredits[i].toDouble();
      double gradePoint = gradeMap[selectedGrades[i]] ?? 0;
      gradePoints[i] = gradePoint;

      totalPoints += credit * gradePoint;
      totalCredits += credit;
    }

    double gpa = totalCredits > 0 ? totalPoints / totalCredits : 0.0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          gpa: gpa,
          totalCredits: totalCredits,
          totalPoints: totalPoints,
          courses: courseControllers.map((e) => e.text).toList(),
          credits: selectedCredits.map((e) => e.toDouble()).toList(),
          grades: selectedGrades,
          gradePoints: gradePoints,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GPA Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Table Header
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          'Course Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'Credits',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'Grade',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Remove',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Course Table Rows
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(courseControllers.length, (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Course Name Input
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: courseControllers[index],
                                focusNode: focusNodes[index],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Enter course',
                                  border: InputBorder.none,
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Enter Course' : null,
                              ),
                            ),
                            SizedBox(width: 8),

                            // Credits Dropdown
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<int>(
                                value: selectedCredits[index],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                items: [1, 2, 3, 4, 5].map((int credit) {
                                  return DropdownMenuItem<int>(
                                    value: credit,
                                    child: Text(credit.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedCredits[index] = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8),

                            // Grade Dropdown
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: selectedGrades[index],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                items: gradeMap.keys.map((String grade) {
                                  return DropdownMenuItem<String>(
                                    value: grade,
                                    child: Text(grade),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedGrades[index] = newValue!;
                                  });
                                },
                              ),
                            ),

                            SizedBox(width: 8),

                            // Remove Button
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeCourse(index),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Add Course Button
              OutlinedButton.icon(
                onPressed: addCourse,
                icon: Icon(Icons.add, color: const Color.fromRGBO(33, 150, 243, 1)),
                label: Text(
                  'Add Course',
                  style: TextStyle(color: Colors.blue),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: const Color.fromRGBO(33, 150, 243, 1)),
                ),
              ),

              SizedBox(height: 20),

              // Calculate GPA Button
              ElevatedButton(
                onPressed: calculateGPA,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue.shade900,
                ),
                child: Text(
                  'Calculate GPA',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Grade Mapping
Map<String, double> gradeMap = {
  'A+': 4.0,
  'A': 4.0,
  'A-': 3.7,
  'B+': 3.3,
  'B': 3.0,
  'B-': 2.7,
  'C+': 2.3,
  'C': 2.0,
  'C-': 1.7,
  'D+': 1.3,
  'D': 1.0,
  'E': 0.0,
};
