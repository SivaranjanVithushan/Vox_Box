import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/routes.dart';
import 'core/theme_data/colour_scheme.dart';
import 'core/theme_data/text_theme.dart';

// Firebase Realtime Database URL
const String firebaseDatabaseURL =
    'https://voxbox-8da27-default-rtdb.firebaseio.com/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: firebaseDatabaseURL,
  );
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoxBox',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        // Font Themes
        fontFamily: GoogleFonts.roboto().fontFamily,
        textTheme: textTheme,
        // Elevated button default theme
      ),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      routes: routes,
      initialRoute: '/',
    );
  }
}
