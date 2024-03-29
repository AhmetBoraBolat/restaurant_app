import 'package:flutter/material.dart';

import 'view_model/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151518),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'welcome Back!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('Please login to your account'),
                midSizedBox(),
                // EMAİL FİELD
                emailField(context),
                smalSizedBox(),
                // PASSWORD FİELD
                passwordField(),
                largeSizedBox(),
                //LOGIN BUTTON
                loginButton(context),
                smalSizedBox(),
                //LOGİN WİTH GOOGLE
                loginWithGoogle(context),
                //Register BuTTON
                registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
