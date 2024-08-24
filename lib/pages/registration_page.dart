import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_logins/providers/user_data.dart';
import 'package:social_logins/services/authentication.dart';

class RegistrationPage extends ConsumerWidget {
  //variables
  late String email;
  late String password;
  late String firstName;
  late String lastName;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'First Name'),
              onChanged: (value) {
                firstName = value;
                ref.read(userDataProvider).setFirstName(firstName);
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              onChanged: (value) {
                lastName = value;
                ref.read(userDataProvider).setLastName(lastName);
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
                ref.read(userDataProvider).setUserEmail(email);
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newUser = Authentication.registerUser(email, password, firstName, lastName);
                  if (newUser != null) {
                    Navigator.pushNamed(
                      context,
                      '/home',
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}