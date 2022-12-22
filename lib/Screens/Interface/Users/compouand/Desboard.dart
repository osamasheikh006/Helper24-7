import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:studio/Screens/Interface/Users/compouand/Navbar.dart';

void main() {
  runApp(const Desboardusers());
}

class Desboardusers extends StatelessWidget {
  const Desboardusers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();
  //Navbar navbar=new Navbar();
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}