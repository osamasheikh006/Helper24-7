import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studio/Screens/Registration/registration_driver.dart';
import 'package:studio/Screens/Registration/registration_hospital.dart';
import 'package:studio/Screens/Registration/registration_user.dart';
import 'package:studio/Screens/Welcome/welcome_screen.dart';
void main(){
  runApp(Role_page());
}

class Role_page extends StatelessWidget{
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
    return Container(
        decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.red.shade50,
                  Colors.pink.shade100,
                  Colors.blue.shade300,

                ]

            )

    ),
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome_screen()));
            //Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),

      // automaticallyImplyLeading: true,
        //leading: IconButton(onPressed:()=> exit(0), icon: Icon(Icons.arrow_forward_ios)),

    backgroundColor: Colors.transparent,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           // ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.0))), child: Text("User".toUpperCase(),style: TextStyle(fontSize: 60),),),

            ElevatedButton.icon(

              icon: const Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyUser()),);},
              label: Text(
                "User",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(560, 330, 50, 400),
                fixedSize: const Size(208, 43),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.local_car_wash_rounded,
                color: Colors.white,
              ),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Mydriver()),);},
              label: Text(
                "Driver",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(560, 330, 50, 400),
                fixedSize: const Size(208, 43),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.local_hospital,
                color: Colors.white,
              ),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHospital()),);},
              label: Text(
                "Hospital",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(560, 330, 50, 400),
                fixedSize: const Size(208, 43),
              ),
            ),


          ],
        ),
      ),
    ),
    );
  }
}
