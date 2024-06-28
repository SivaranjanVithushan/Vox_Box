import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/routes.dart';
import 'core/theme_data/colour_scheme.dart';
import 'core/theme_data/text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        //Default font
        fontFamily: 'Poppins',
        //Font Themes
        textTheme: textTheme,
        // Elevated button default theme
      ),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      routes: routes,
      initialRoute: '/',
    );
  }
}
