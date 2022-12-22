
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studio/Screens/Interface/Users/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:studio/Screens/Interface/Admin_page.dart';
import 'package:studio/Screens/Phone_Number/Phone_number.dart';
import 'package:studio/Screens/Registration/gobal/global.dart';
import 'package:studio/Screens/Registration/registration_user.dart';
import 'package:studio/Screens/Role_page/Role_singup.dart';
import 'package:studio/Screens/Welcome/welcome_screen.dart';
import 'package:studio/Screens/components/round_button.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studio/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Interface/Drivers/Driver.dart';
import '../../Registration/registration_driver.dart';

void main(){
  runApp(Login_driver());
}


class Login_driver extends StatelessWidget{
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
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final emailcontroal=TextEditingController();
  final Passwordcontroal=TextEditingController();
  //final namecontroal=TextEditingController();
  FirebaseAuth firebaseusers=FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  //get currentfirebaseUser => null; //key for form
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroal.dispose();
    Passwordcontroal.dispose();
    // namecontroal.dispose();
  }
  //AuthManager widit=new AuthManager();
  void login()async{
    var currentUser =  await fAuth.currentUser!;

    SharedPreferences pref =await SharedPreferences.getInstance();
    final User? firehouse=(
   await fAuth.signInWithEmailAndPassword(
        email: emailcontroal.text.toString(),
        password:Passwordcontroal.text.toString()).catchError((msg){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error"+msg.toString());
      pref.setString('email', emailcontroal.text.toString());

    })).user;
    if(firehouse!=null){

      DatabaseReference driverRef= FirebaseDatabase.instance.ref().child("Drivers");
      driverRef.child(firehouse.uid).once().then((driverKey){
        final snap=driverKey.snapshot;
        if(snap.value!=null){
          //Users. =firebaseusers;
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Drivers()));
        }
        else{
          Fluttertoast.showToast(msg: 'No Record exist with this email Registration');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Drivers()));

        }
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return   Container(
        width: double.infinity,
        decoration: BoxDecoration(
          //image: Image.asset('assets/images/clock.png'),
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
            backgroundColor: Colors.transparent,

            body: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: formKey, //key for form
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(height: 20),
                        // #login, #welcome
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const[
                              Text("Login",
                                style: TextStyle(color: Colors.blue, fontSize: 40),),
                              SizedBox(height: 10,),
                              Text("Welcome to helper 24/7",
                                style: TextStyle(color: Colors.teal, fontSize: 20),),
                            ],
                          ),
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
                        TextButton(

                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Role_page()));
                            }, child:Text('Forget Password',style: TextStyle(fontSize: 15,color: Colors.red),)),
                        SizedBox(
                          height: 20,
                        ),
                        RoundButton(title: 'Login',
                            onTap: (){
                              if(formKey.currentState!.validate()){

                                login();

                              }
                            }),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Do you Have a Account ?',style: TextStyle(fontSize:20 ),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Mydriver()));
                            }, child:Text('Singup',style: TextStyle(fontSize: 20,color: Colors.red),))
                          ],
                        )
                      ],
                    ),
                  ),
                )
            )
        )
    );

  }

}