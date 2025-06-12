import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/home_screen.dart';
import 'screens/enter_courses_screen.dart';
import 'screens/results_screen.dart';
import 'screens/splash_screen.dart'; // تأكد من استيراد شاشة البداية

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('ar'),
      child: const UniCalcApp(),
    ),
  );
}

class UniCalcApp extends StatefulWidget {
  const UniCalcApp({super.key});

  @override
  State<UniCalcApp> createState() => _UniCalcAppState();
}

class _UniCalcAppState extends State<UniCalcApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app_title'.tr(), // تم ترجمة عنوان التطبيق
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/', // لتحديد شاشة البداية
      routes: {
        '/': (context) => SplashScreen(isDarkMode: isDarkMode, onThemeChanged: toggleTheme), // تعيين شاشة البداية كـ initialRoute
        '/home': (context) => HomeScreen(isDarkMode: isDarkMode, onThemeChanged: toggleTheme), // الشاشة الرئيسية بعد البداية
        '/enter': (context) => const EnterCoursesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/results') {
          final args = settings.arguments as List<Map<String, dynamic>>;
          return MaterialPageRoute(
            builder: (context) => ResultsScreen(courses: args),
          );
        }
        return null;
      },
    );
  }
}