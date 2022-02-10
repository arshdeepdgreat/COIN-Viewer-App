import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool _lights = false;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("njdnkdnnvkjs"),
        ),
        body: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _lights,
              onChanged: (bool value) {
                setState(() {
                  _lights = value;
                  ThemeData.dark();
                });
              },
              secondary: const Icon(Icons.dark_mode),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            )
          ],
        ));
  }
}
