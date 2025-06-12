import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ThemeScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const ThemeScreen({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme(bool val) {
    setState(() {
      _isDarkMode = val;
    });
    widget.onThemeChanged(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_screen_title'.tr()),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('dark_mode_tooltip'.tr()),
            value: _isDarkMode,
            onChanged: _toggleTheme,
          ),
        ],
      ),
    );
  }
}