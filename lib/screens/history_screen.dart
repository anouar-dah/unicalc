import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final loaded = await StorageService.getHistory();
    setState(() {
      history = loaded;
    });
  }

  Future<void> clearHistory() async {
    await StorageService.clearHistory();
    setState(() {
      history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('history_screen_title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'clear_history_tooltip'.tr(),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('confirm_clear_title'.tr()),
                  content: Text('confirm_clear_content'.tr()),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: Text('no'.tr())),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: Text('yes'.tr())),
                  ],
                ),
              );
              if (confirmed == true) {
                await clearHistory();
              }
            },
          ),
        ],
      ),
      body: history.isEmpty
          ? Center(child: Text('no_history_message'.tr()))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];
                final date = DateTime.parse(entry['date']);
                final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
                final avg = entry['average'].toStringAsFixed(2);
                final courses = (entry['courses'] as List).map((c) => c['name']).join(', ');

                return ListTile(
                  title: Text('${'average_label'.tr()}: $avg'),
                  subtitle: Text('${'date_label'.tr()}: $formattedDate\n${'courses_label'.tr()}: $courses'),
                );
              },
            ),
    );
  }
}