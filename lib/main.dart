import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio/Screens/Interface/Users/User.dart';
import 'package:studio/Screens/Login/Login_Role/login.dart';
import 'package:studio/Screens/Phone_Number/Phone_number.dart';
import 'package:studio/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:studio/Screens/Interface/Users/compouand/patient_page.dart';
import 'package:studio/SplashScreen/splash_screen.dart';
//This is real screen main
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope( child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 // runApp(ProviderScope(child: MyApp()));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


        debugShowCheckedModeBanner: false,
        title: 'Ambulance',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen()
    );
  }
}
