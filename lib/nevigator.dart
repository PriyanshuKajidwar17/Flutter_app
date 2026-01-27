import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  final List<Map<String, String>> students = [];

  void _addStudent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        students.add({
          'name': nameController.text,
          'age': ageController.text,
          'contact': contactController.text,
          'course': courseController.text,
        });
      });

      // Clear fields
      nameController.clear();
      ageController.clear();
      contactController.clear();
      courseController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Form"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Add Student Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// -------- FORM --------
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Student Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter name" : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter age" : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Contact Number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter contact number" : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: courseController,
                    decoration: const InputDecoration(
                      labelText: "Course Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter course name" : null,
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: _addStudent,
                    child: const Text("Add details"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// -------- TABLE --------
            if (students.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Age")),
                    DataColumn(label: Text("Contact")),
                    DataColumn(label: Text("Course")),
                  ],
                  rows: students
                      .map(
                        (student) => DataRow(
                      cells: [
                        DataCell(Text(student['name']!)),
                        DataCell(Text(student['age']!)),
                        DataCell(Text(student['contact']!)),
                        DataCell(Text(student['course']!)),
                      ],
                    ),
                  )
                      .toList(),
                ),
              )
            else
              const Text(
                "No data added yet",
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
