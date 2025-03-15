import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/system_users/client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Client _client;

  @override
  void initState() {
    super.initState();
    _client = GetIt.instance<Client>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView(
          children: [
            _buildProfileTile('Username', _client.username),
            _buildProfileTile('ID', _client.idNumber.toString()),
            _buildProfileTile('Role', _client.role.toString()),
            _buildProfileTile('Full Name', _client.fullName),
            _buildProfileTile('Passport Series and Number', _client.passportSeriesAndNumber),
            _buildProfileTile('Phone', _client.phone),
            _buildProfileTile('Email', _client.email),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
