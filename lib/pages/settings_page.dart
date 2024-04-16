import 'package:chat_app_firebase/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setttings"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark Mode
            const Text("Dark Mode"),
            //switch toggle
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) => {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toogleTheme()
                    })
          ],
        ),
      ),
    );
  }
}