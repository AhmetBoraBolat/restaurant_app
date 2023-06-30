import 'package:flutter/material.dart';

import 'view_model/register_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends RegisterViewModel {
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
                    'Create a new account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('Please fill in the form to continue'),
                midSizedBox(),
                emailField(context),
                smalSizedBox(),
                passwordField(),
                smalSizedBox(),
                checkPasswordField(),
                smalSizedBox(),
                signUpButton(context),
                smalSizedBox(),
                loginWithGoogle(context),
                goTologinButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
