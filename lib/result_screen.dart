import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double gpa;
  final double totalCredits;
  final double totalPoints;
  final List<String> courses;
  final List<double> credits;
  final List<String> grades;
  final List<double> gradePoints;

  ResultScreen({
    required this.gpa,
    required this.totalCredits,
    required this.totalPoints,
    required this.courses,
    required this.credits,
    required this.grades,
    required this.gradePoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GPA Result',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // GPA Summary Card with reduced width
            Center(
              child: SizedBox(
                width: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          'Your GPA',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text(
                          gpa.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue.shade200),
                        border: TableBorder.all(color: Colors.blue.shade100),
                        columns: [
                          DataColumn(
                              label: Text('Course',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Credits',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Grade',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Grade Point',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(courses.length, (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text(courses[index])),
                              DataCell(Text(credits[index].toStringAsFixed(1))),
                              DataCell(Text(grades[index])),
                              DataCell(
                                  Text(gradePoints[index].toStringAsFixed(2))),
                            ],
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Summary Box with reduced width
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          color: Colors.blue.shade50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Summary',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(color: Colors.blue.shade300),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Credits:',
                                        style: TextStyle(fontSize: 14)),
                                    Text(totalCredits.toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Grade Points:',
                                        style: TextStyle(fontSize: 14)),
                                    Text(totalPoints.toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      label:
                          Text('Back', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        backgroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
