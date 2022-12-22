import 'package:flutter/material.dart';
import 'package:studio/Screens/Welcome/components/body.dart';
void main(){
  runApp(Welcome_screen());
}

class Welcome_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>(); //key for form

  String name="";
 @override
  Widget build(BuildContext context) {
    return Body();
  }
}
