import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'welcome Back!',
                style: context.general.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('Please login to your account'),
              _sizedBox(),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'E-posta adresi boş olamaz.';
                  }
                  return null;
                },
              ),
              _sizedBox(),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: '***********',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(_obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Şifre boş olamaz.';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 30,
    );
  }
}
