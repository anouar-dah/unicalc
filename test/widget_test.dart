import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:unicalc/main.dart'; // اسم المشروع unicalc

void main() {
  group('UniCalcApp tests', () {
    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      EasyLocalization.logger.enableBuildModes = [];
    });

    testWidgets('App starts and displays home screen content', (WidgetTester tester) async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/langs',
          fallbackLocale: const Locale('ar'),
          child: const UniCalcApp(),
        ),
      );

      await tester.pumpAndSettle(); // انتظار الانتقال من SplashScreen إلى HomeScreen

      // يمكنك إزالة debugDumpApp() الآن إذا أردت، أو الاحتفاظ به للتشخيص المستقبلي
      // debugDumpApp();

      // التحقق من عنوان AppBar في الشاشة الرئيسية
      final appTitleFinderAr = find.text('حاسبة المعدل الجامعي');
      final appTitleFinderEn = find.text('University Average Calculator');

      // نتحقق مما إذا كان النص العربي أو الإنجليزي موجودًا
      expect(appTitleFinderAr.evaluate().isNotEmpty || appTitleFinderEn.evaluate().isNotEmpty, isTrue,
        reason: 'Should find the app title in either Arabic or English on the home screen AppBar.');

      // التحقق من زر "إضافة مادة"
      expect(
        find.byType(ElevatedButton),
        findsOneWidget,
        reason: 'Should find exactly one ElevatedButton on the HomeScreen.',
      );

      // التحقق من النص الموجود داخل هذا الزر
      final addButtonTextFinderAr = find.text('إضافة مادة');
      final addButtonTextFinderEn = find.text('Add Course');

      // نتحقق مما إذا كان النص العربي أو الإنجليزي لزر "إضافة مادة" موجودًا
      expect(addButtonTextFinderAr.evaluate().isNotEmpty || addButtonTextFinderEn.evaluate().isNotEmpty, isTrue,
        reason: 'Should find the "Add Course" button text in either Arabic or English.');

      // يمكنك أيضًا اختبار النقر على الزر والانتقال إلى الشاشة التالية (إذا أردت)
      /*
      await tester.tap(find.text('إضافة مادة') | find.text('Add Course')); // هذا السطر سيحتاج لتعديل بنفس طريقة find.text
      await tester.pumpAndSettle();

      final enterCoursesTitleFinderAr = find.text('إدخال المواد');
      final enterCoursesTitleFinderEn = find.text('Enter Courses');
      expect(enterCoursesTitleFinderAr.evaluate().isNotEmpty || enterCoursesTitleFinderEn.evaluate().isNotEmpty, isTrue,
        reason: 'Should be on the Enter Courses screen after tapping the button.');
      */
    });
  });
}