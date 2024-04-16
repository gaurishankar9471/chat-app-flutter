import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/components/my_button.dart';
import 'package:chat_app_firebase/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //tap to go to register
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  //login method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();
    //login
    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    }
    //catch error
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            //welcome message
            Text(
              "Welcome back to our App",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            //email
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            //pass/
            MyTextField(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            //login button
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

            //register now
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a memeber?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
