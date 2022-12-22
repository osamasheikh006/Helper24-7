import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studio/Screens/Interface/Admin_page.dart';
import 'package:studio/Screens/Login/Login_Role/login.dart';
import 'package:studio/Screens/Phone_Number/Phone_number.dart';
import 'package:studio/Screens/Role_page/Role_singup.dart';
import 'package:studio/Screens/Welcome/welcome_screen.dart';

import '../../utils/utils.dart';
import '../Interface/Hospital.dart';
import '../components/round_button.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
void main(){
  runApp(MyHospital());
}

class MyHospital extends StatelessWidget{
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
  final formKey = GlobalKey<FormState>();
  final emailcontroal=TextEditingController();
  final Passwordcontroal=TextEditingController();
  final namecontroal=TextEditingController();
//  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseAuth firebasehospital=FirebaseAuth.instance;

  void saveUserInfoNow()async{

    firebasehospital.createUserWithEmailAndPassword(
        email: emailcontroal.text.toString(),
        password:Passwordcontroal.text.toString()).catchError((msg){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error"+msg.toString());
    });
    if(firebasehospital!=null){
      Map DriverMap={
        "id":firebasehospital.currentUser?.uid,
        "name":namecontroal.text.trim(),
        "Email":emailcontroal.text.trim()

      };
      DatabaseReference driverRef= FirebaseDatabase.instance.ref().child("Hospital");
      driverRef.child(firebasehospital.currentUser!.uid).set(DriverMap);
    }
    else{
      Fluttertoast.showToast(msg: "Fulfill the Condition");

    }
  }


  //String? _name,_email;
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(


      width: double.infinity,
        decoration: BoxDecoration(
        //image: Image.asset('assets/images/clock.png'),
        gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
        Colors.red.shade50,
        Colors.pink.shade100,
        Colors.blue.shade300,

        ]

    )
    ),
    child: Scaffold(
       // debugShowCheckedModeBanner: false,

        extendBodyBehindAppBar: true,
    appBar: AppBar(
    backgroundColor: Colors.transparent,
    leading: IconButton(
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Role_page()));
    // Navigator.pop(context);
    },
    icon: Icon(
    Icons.arrow_back_ios_rounded,
    color: Colors.black,
    ),
    ),
    elevation: 0,
    ),
    backgroundColor: Colors.transparent,
    body: Center( child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey, //key for form
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const SizedBox(height: 80),
                    // #login, #welcome
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                          Text("Registration",
                            style: TextStyle(color: Colors.black87, fontSize: 40),),
                          SizedBox(height: 10,),
                          Text("Welcome to helper 24/7",
                            style: TextStyle(color: Colors.black87, fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(
                  height: height * 0.12),
                TextFormField(
                  controller: namecontroal,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[  a-zA-Z]"))],

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_hospital),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Enter your Hospital Full Name",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),

                  validator: (String? value){
                    if(value!.isEmpty || RegExp(r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$').hasMatch(value)){
                      return "* Required";
                    } else if (value.length < 6) {
                      return "Hospital should be atleast 6 characters";
                    }
                    },

                ),

                SizedBox(
                    height: height * 0.05),
                TextFormField(
                  controller: emailcontroal,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Email  Address",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),

                  validator: (value) {
          if (value!.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
          return 'Enter a valid email!';
          }
          return null;
          },
          ),
                SizedBox(
                    height: height * 0.05),
                TextFormField(
                  controller: Passwordcontroal,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Enter your password",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    } else if (value.length < 6) {
                      return "Password should be atleast 6 characters";
                    } else if (value.length > 15) {
                      return "Password should not be greater than 15 characters";
                    } else{
                      return null;
                        }
                       },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundButton(title: 'Singup',
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            saveUserInfoNow();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Hospital()));
                          }
                        }

                    ),

                  ],
            ),
          ),
        )
        )
    ),
    );
  }


}