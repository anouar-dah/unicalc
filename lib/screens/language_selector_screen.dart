import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'splash_screen.dart';

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({super.key});

  void _selectLanguage(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    // بعد تغيير اللغة، العودة إلى شاشة البداية لتحديث التطبيق بالكامل
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SplashScreen(
          isDarkMode: false, // يمكن تعديل هذا ليعكس حالة الثيم الفعلية
          onThemeChanged: (_) {}, // يمكن تمرير الدالة الفعلية هنا إذا كانت الشاشة تحتاجها
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر اللغة / Select Language')), // يمكن ترجمة هذا العنوان أيضاً
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectLanguage(context, const Locale('ar')),
              child: const Text('العربية'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectLanguage(context, const Locale('en')),
              child: const Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}