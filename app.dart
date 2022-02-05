import 'package:flutter/material.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData(),
        themeMode: ThemeMode.dark,
        home: ListScreen()
    );
  }
}