import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/login/login_page.dart';

import '../../home/home_page.dart';
import '../../services/firebase_auth_service.dart';
import '../../util/google_sign_in.dart';
import '../login_authentication.dart';
import '../login_register.dart';

abstract class RegisterViewModel extends State<RegisterPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? checkpasswordController;

  bool obscureText = true;
  bool isLoading = false;

  final FirebaseAuthService _authService = FirebaseAuthService();

  void signUp() async {
    String? email = emailController?.text;
    String? password = passwordController?.text;

    if (!checkPassword()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: const Text('Şifreler uyuşmuyor.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
      return;
    }

    UserCredential? userCredential =
        await _authService.signUp(email!, password!);
    if (userCredential != null) {
      navigateToAuthentication();
    } else {
      if (kDebugMode) {
        print('Kayit yapilamadi!');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    checkpasswordController = TextEditingController();
  }

  bool checkPassword() {
    String password = passwordController?.text ?? '';
    String checkPassword = checkpasswordController?.text ?? '';

    if (password.isEmpty || checkPassword.isEmpty) {
      return false;
    }

    return password == checkPassword;
  }

  //İF USE SIGN IN WİTH GOOGLE USE
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

  //AFTER REGİSTER
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

  void navigateToLogin() {
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
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

  TextFormField checkPasswordField() {
    return TextFormField(
      controller: checkpasswordController,
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

  SizedBox signUpButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
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
        onPressed: isLoading ? null : signUp,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text('SIGN IN'),
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
          title: const Text('Sign in with google'),
          leading: Image(
            height: MediaQuery.of(context).size.height * 0.04,
            image: const AssetImage('assets/images/google.png'),
          )),
    );
  }

  Row goTologinButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("have an account"),
        TextButton(
          onPressed: isLoading ? null : navigateToLogin,
          child: const Text(
            'Login',
            style: TextStyle(color: Color.fromARGB(255, 116, 17, 18)),
          ),
        ),
      ],
    );
  }
}
