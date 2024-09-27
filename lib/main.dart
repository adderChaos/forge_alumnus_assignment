import 'package:flutter/material.dart';
import 'package:forge_alumnus_assignment/ui/custom_widgets/theme_notifier.dart';
import 'package:forge_alumnus_assignment/ui/landing_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'Forge Alumnus',
          theme:
              themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: const LandingScreen(),
        );
      },
    );
  }
}
