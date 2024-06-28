import 'package:flutter/material.dart';
import 'package:vox_box/modules/chatUi/presenters/chat_screen.dart';
import 'package:vox_box/modules/home/presenters/home_screen.dart';
import 'package:vox_box/modules/login/presenters/login_screen.dart';

import '../../modules/splash/presenters/splash_screen.dart';

final routes = {
  '/': (BuildContext context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/chat': (context) => ChatScreen(),
};
