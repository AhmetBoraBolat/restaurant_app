import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/home/home_page.dart';
import 'package:restaurant_app/util/google_sign_in.dart';

import '../services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  bool _obscureText = true;
  bool _isLoading = false;

  final FirebaseAuthService _authService = FirebaseAuthService();

  void _signIn() async {
    String? email = _emailController?.text;
    String? password = _passwordController?.text;

    UserCredential? userCredential =
        await _authService.signIn(email!, password!);
    if (userCredential != null) {
      navigateToHomePage();
    } else {
      if (kDebugMode) {
        print('Giriş başarisiz');
      }
    }
  }

  void _signUp() async {
    String? email = _emailController?.text;
    String? password = _passwordController?.text;

    UserCredential? userCredential =
        await _authService.signUp(email!, password!);
    if (userCredential != null) {
      // Kayıt başarılı, bir sonraki sayfaya yönlendirme yapabilirsiniz.
    } else {
      // Kayıt başarısız, kullanıcıya hata mesajı gösterebilirsiniz.
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

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
                _midSizedBox(),

                // EMAİL FİELD
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 27, 27, 32),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction
                      .next, // Klavyede "Next" düğmesini gösterir
                  onEditingComplete: () => FocusScope.of(context)
                      .nextFocus(), // "Next" düğmesine basıldığında sonraki alana geçer
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-posta adresi boş olamaz.';
                    }
                    return null;
                  },
                ),
                _smalSizedBox(),

                // PASSWORD FİELD
                TextFormField(
                  controller: _passwordController,
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
                ),
                _largeSizedBox(),

                //LOGIN BUTTON
                SizedBox(
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
                    onPressed: _isLoading ? null : _signIn,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('LOGIN'),
                  ),
                ),
                _smalSizedBox(),

                //LOGİN WİTH GOOGLE
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListTile(
                      onTap: () async {
                        await signInWithGoogle();
                        navigateToHomePage();
                      },
                      title: const Text('Login with google'),
                      leading: Image(
                        height: MediaQuery.of(context).size.height * 0.04,
                        image: const AssetImage('assets/images/google.png'),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don' t hava an account"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style:
                            TextStyle(color: Color.fromARGB(255, 116, 17, 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToHomePage() {
    setState(() {
      _isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    });
  }

  SizedBox _smalSizedBox() {
    return const SizedBox(
      height: 25,
    );
  }
}

SizedBox _midSizedBox() {
  return const SizedBox(
    height: 90,
  );
}

SizedBox _largeSizedBox() {
  return const SizedBox(
    height: 120,
  );
}
