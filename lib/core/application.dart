import 'package:finance_system_controller/features/finance_controller/presentation/screens/client_screens/transfer_log_screen.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/registration_screen.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/start_screen.dart';
import 'package:flutter/material.dart';

import '../features/finance_controller/presentation/screens/client_screens/client_main_screen.dart';
import '../features/finance_controller/presentation/screens/client_screens/profile_screen.dart';
import '../features/finance_controller/presentation/screens/login_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => const StartScreen(),
        "/registration" : (context) => const RegistrationScreen(),
        "/login" : (context) => const LoginScreen(),
        "/client_main" : (context) => const ClientMainScreen(),
        '/client_main/profile' : (context) => const ProfileScreen(),
        '/client_main/transfers' : (context) => const TransferLogScreen(),

      },
    );
  }
}