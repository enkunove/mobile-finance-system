import 'package:flutter/material.dart';

class AwaitConfirmationScreen extends StatelessWidget {
  const AwaitConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,),
      body: Center(child: Text("Ожидается подтверждение регистрации от менеджера"),),
    );
  }
}
