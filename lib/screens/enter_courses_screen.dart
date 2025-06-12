import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'results_screen.dart';

class EnterCoursesScreen extends StatefulWidget {
  const EnterCoursesScreen({super.key});

  @override
  State<EnterCoursesScreen> createState() => _EnterCoursesScreenState();
}

class _EnterCoursesScreenState extends State<EnterCoursesScreen> {
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> workControllers = [];
  List<TextEditingController> examControllers = [];
  List<TextEditingController> coefficientControllers = [];
  List<TextEditingController> creditControllers = [];

  @override
  void initState() {
    super.initState();
    _addCourse();
  }

  @override
  void dispose() {
    for (var controller in [
      ...nameControllers,
      ...workControllers,
      ...examControllers,
      ...coefficientControllers,
      ...creditControllers
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addCourse() {
    setState(() {
      nameControllers.add(TextEditingController());
      workControllers.add(TextEditingController());
      examControllers.add(TextEditingController());
      coefficientControllers.add(TextEditingController());
      creditControllers.add(TextEditingController());
    });
  }

  void _removeCourse(int index) {
    setState(() {
      nameControllers[index].dispose();
      workControllers[index].dispose();
      examControllers[index].dispose();
      coefficientControllers[index].dispose();
      creditControllers[index].dispose();

      nameControllers.removeAt(index);
      workControllers.removeAt(index);
      examControllers.removeAt(index);
      coefficientControllers.removeAt(index);
      creditControllers.removeAt(index);
    });
  }

  Widget _buildCourseCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameControllers[index],
                    decoration: InputDecoration(
                      labelText: "course_name_label".tr(),
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeCourse(index),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: examControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "exam_grade_label".tr(),
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: workControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "work_grade_label".tr(),
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: coefficientControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "coefficient_label".tr(),
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: creditControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "credit_label".tr(),
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitCourses() {
    if (nameControllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('add_at_least_one_course_error'.tr())),
      );
      return;
    }

    List<Map<String, dynamic>> courses = [];
    for (int i = 0; i < nameControllers.length; i++) {
      try {
        String name = nameControllers[i].text.trim();
        double work = double.parse(workControllers[i].text);
        double exam = double.parse(examControllers[i].text);
        double coeff = double.parse(coefficientControllers[i].text);
        double credit = double.parse(creditControllers[i].text);

        if (name.isEmpty || work < 0 || work > 20 || exam < 0 || exam > 20 || coeff <= 0 || credit < 0) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('invalid_course_data_error'.tr(args: [(i + 1).toString()]))),
          );
          return;
        }

        courses.add({
          'name': name,
          'work': work,
          'exam': exam,
          'coefficient': coeff,
          'credit': credit,
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('data_input_error'.tr(args: [(i + 1).toString()]))),
        );
        return;
      }
    }

    Navigator.pushNamed(context, '/results', arguments: courses);

    print(courses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("enter_courses_title".tr()),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 150),
        itemCount: nameControllers.length,
        itemBuilder: (context, index) => _buildCourseCard(index),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _addCourse,
            tooltip: 'add_new_course_tooltip'.tr(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'done',
            onPressed: _submitCourses,
            tooltip: 'calculate_average_tooltip'.tr(),
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}