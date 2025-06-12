import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const ResultsScreen({super.key, required this.courses});

  double get average {
    double totalWeighted = 0;
    double totalCoefficients = 0;
    for (var course in courses) {
      double work = course['work'] ?? 0.0;
      double exam = course['exam'] ?? 0.0;
      double coefficient = course['coefficient'] ?? 1.0;

      totalWeighted += ((work * 0.4) + (exam * 0.6)) * coefficient;
      totalCoefficients += coefficient;
    }
    return totalCoefficients == 0 ? 0 : totalWeighted / totalCoefficients;
  }

  String get mention {
    double avg = average;
    if (avg >= 16) return 'mention_excellent'.tr();
    if (avg >= 14) return 'mention_very_good'.tr();
    if (avg >= 12) return 'mention_good'.tr();
    if (avg >= 10) return 'mention_pass'.tr();
    return 'mention_fail'.tr();
  }

  @override
  Widget build(BuildContext context) {
    StorageService.saveCalculation(courses, average);

    return Scaffold(
      appBar: AppBar(
        title: Text('results_screen_title'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('${'average_label'.tr()}: ${average.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${'grade_label'.tr()}: $mention', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final c = courses[index];
                  final weighted = ((c['work'] * 0.4) + (c['exam'] * 0.6)) * c['coefficient'];
                  return ListTile(
                    title: Text(c['name']),
                    subtitle: Text(
                        '${'work_grade_display'.tr()}: ${c['work']}, ${'exam_grade_display'.tr()}: ${c['exam']}, ${'coefficient_display'.tr()}: ${c['coefficient']}, ${'credit_display'.tr()}: ${c['credit']}'),
                    trailing: Text(weighted.toStringAsFixed(2)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}