import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('Банковская система'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'lib/assets/images/image.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'Зарегистрироваться',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'Войти',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    await deleteDatabase(
                        join(await getDatabasesPath(), 'banks_database.db'));
                    await deleteDatabase(
                        join(await getDatabasesPath(), 'accounts_database.db'));
                    await deleteDatabase(
                        join(await getDatabasesPath(), 'client_database.db'));
                  },
                  child: const Text("очистить данные"))
            ],
          ),
        ),
      ),
    );
  }
}
