import 'package:flutter/material.dart';
import 'enter_courses_screen.dart';
import 'history_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'history_screen_title'.tr(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'change_language_tooltip'.tr(),
            onPressed: () {
              final current = context.locale;
              context.setLocale(current.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
            },
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            tooltip: isDarkMode ? 'dark_mode_tooltip'.tr() : 'light_mode_tooltip'.tr(),
            onPressed: () {
              onThemeChanged(!isDarkMode);
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: Text('add_course_button'.tr()),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EnterCoursesScreen()),
            );
          },
        ),
      ),
    );
  }
}