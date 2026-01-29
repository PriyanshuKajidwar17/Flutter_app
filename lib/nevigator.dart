import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPageWithTheme extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  const NextPageWithTheme({super.key, required this.themeModeNotifier});

  @override
  State<NextPageWithTheme> createState() => _NextPageWithThemeState();
}

class _NextPageWithThemeState extends State<NextPageWithTheme> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();
  final courseController = TextEditingController();

  List<Map<String, String>> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'students',
      students.map((e) => jsonEncode(e)).toList(),
    );
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('students');
    if (list != null) {
      setState(() {
        students =
            list.map((e) => Map<String, String>.from(jsonDecode(e))).toList();
      });
    }
  }

  void _addStudent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        students.add({
          'name': nameController.text,
          'age': ageController.text,
          'contact': contactController.text,
          'course': courseController.text,
        });
      });

      await _saveStudents();

      nameController.clear();
      ageController.clear();
      contactController.clear();
      courseController.clear();
    }
  }

  void _deleteStudent(int index) async {
    setState(() {
      students.removeAt(index);
    });
    await _saveStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Form"),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeModeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              widget.themeModeNotifier.value =
              widget.themeModeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add Student Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/students.png', height: 45),
              ],
            ),
            const SizedBox(height: 16),

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
                    value == null || value.length < 3
                        ? "Enter valid name"
                        : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      int? age = int.tryParse(value ?? "");
                      if (age == null || age < 1 || age > 100) {
                        return "Enter valid age (1-100)";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: const InputDecoration(
                      labelText: "Contact Number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.length != 10
                        ? "Enter 10 digit number"
                        : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: courseController,
                    decoration: const InputDecoration(
                      labelText: "Course Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Course required"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: _addStudent,
                    child: const Text("Add Details"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            students.isNotEmpty
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Contact")),
                  DataColumn(label: Text("Course")),
                  DataColumn(label: Text("Action")),
                ],
                rows: List.generate(
                  students.length,
                      (index) => DataRow(cells: [
                    DataCell(Text(students[index]['name']!)),
                    DataCell(Text(students[index]['age']!)),
                    DataCell(Text(students[index]['contact']!)),
                    DataCell(Text(students[index]['course']!)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStudent(index),
                      ),
                    ),
                  ]),
                ),
              ),
            )
                : const Text(
              "No data added yet",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
