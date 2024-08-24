import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_logins/pages/registration_page.dart';

class LoginPage extends StatelessWidget {
  //variables
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Enter Email
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(height: 16.0),

            //Enter Password
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 8.0),

            //Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset');
                },
                child: Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 16.0),

            //Login Button
            ElevatedButton(
              onPressed: () async {
                try {
                  // setState(() {
                  //   showSpinner = true;
                  // });
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, '/home');
                  }
                  // setState(() {
                  //   showSpinner = false;
                  // });
                } catch (e) {
                  throw e;
                }
              },
              child: Text('Login'),
            ),
            const SizedBox(height: 50.0),

            //Registration
            const Text("Don't have an account?"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
