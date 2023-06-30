import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/login/login_register.dart';

import '../../home/home_page.dart';
import '../../services/firebase_auth_service.dart';
import '../../util/google_sign_in.dart';
import '../login_authentication.dart';
import '../login_page.dart';

abstract class LoginViewModel extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool obscureText = true;
  bool isLoading = false;

  final FirebaseAuthService _authService = FirebaseAuthService();

  void signIn() async {
    String? email = emailController?.text;
    String? password = passwordController?.text;

    UserCredential? userCredential =
        await _authService.signIn(email!, password!);
    if (userCredential != null) {
      navigateToAuthentication();
    } else {
      if (kDebugMode) {
        print('Giriş başarisiz');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void navigateToHome() {
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    });
  }

  void navigateToAuthentication() {
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LAuhentication(),
      ));
    });
  }

  void navigateToRegister() {
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ));
    });
  }

  SizedBox smalSizedBox() {
    return const SizedBox(
      height: 25,
    );
  }

  SizedBox midSizedBox() {
    return const SizedBox(
      height: 90,
    );
  }

  SizedBox largeSizedBox() {
    return const SizedBox(
      height: 120,
    );
  }

  TextFormField emailField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 27, 27, 32),
        labelText: 'Email',
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction:
          TextInputAction.next, // Klavyede "Next" düğmesini gösterir
      onEditingComplete: () => FocusScope.of(context)
          .nextFocus(), // "Next" düğmesine basıldığında sonraki alana geçer
      validator: (value) {
        if (value!.isEmpty) {
          return 'E-posta adresi boş olamaz.';
        }
        return null;
      },
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 27, 27, 32),
        labelText: '***********',
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
        ),
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Şifre boş olamaz.';
        }
        return null;
      },
    );
  }

  SizedBox loginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 55),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 38, 38, 45),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: isLoading ? null : signIn,
        child:
            isLoading ? const CircularProgressIndicator() : const Text('LOGIN'),
      ),
    );
  }

  SizedBox loginWithGoogle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListTile(
          onTap: () async {
            await signInWithGoogle();
            navigateToHome();
          },
          title: const Text('Login with google'),
          leading: Image(
            height: MediaQuery.of(context).size.height * 0.04,
            image: const AssetImage('assets/images/google.png'),
          )),
    );
  }

  Row registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don' t hava an account"),
        TextButton(
          onPressed: isLoading ? null : navigateToRegister,
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Color.fromARGB(255, 116, 17, 18)),
          ),
        ),
      ],
    );
  }
}
