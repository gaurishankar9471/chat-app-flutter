import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/components/my_button.dart';
import 'package:chat_app_firebase/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPasswordController = TextEditingController();
  void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void register(BuildContext context) {
    final auth = AuthService();
    if (_passwordController.text == _cnfPasswordController.text) {
      try {
        auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("Password don't match")));
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
              "Complete Registration",
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
            //confirm pass/
            const SizedBox(
              height: 10,
            ),

            MyTextField(
              hintText: "Confirm Password",
              controller: _cnfPasswordController,
              obscureText: true,
            ),
            //login button
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            //register now
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have account?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
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
