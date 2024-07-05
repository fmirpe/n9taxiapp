import 'package:flutter/material.dart';

import '../widgets/login_signup_screen_widgets/login_signup_form.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  static const String route = '/login-signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/logon91.png",
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 10),
                Icon(
                  Icons.location_on_sharp,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
                Text('N9 Taxi App',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 20),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
