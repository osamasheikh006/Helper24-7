import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studio/Screens/Phone_Number/OTP.dart';
import 'package:studio/Screens/Phone_Number/Phone_number.dart';
import 'package:studio/Screens/Role_page/Role_singup.dart';
import 'package:studio/Screens/Welcome/welcome_screen.dart';
import 'package:studio/utils/utils.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
void main(){
  runApp(MyPhone());
}

class MyPhone extends StatelessWidget{
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
  final numberController =TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return  Scaffold(

        key: formKey,
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

        //backgroundColor: Color(0xFF303030),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              //image: Image.asset('assets/images/clock.png'),
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.topRight,
                    colors: [
                      Colors.red.shade100,
                      Colors.pink.shade300,
                      Colors.blue.shade500,

                    ]

                )
            ),

            //key: formKey,
            alignment: Alignment.center,

            child: SingleChildScrollView(
              padding: EdgeInsets.all(30),

              child: Form(

                key: formKey, //key for form
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                      top:30,
                      child: Image.asset(
                        "assets/images/image1_tr.png",
                      ),
                    ),

                    const SizedBox(height: 50),
                    // #login, #welcome
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: const[
                          Text("Phone Verfication ",
                            style: TextStyle(color: Colors.blue, fontSize: 30),),
                          SizedBox(height: 10,),
                          Text("Welcome to helper 24/7",
                            style: TextStyle(color: Colors.teal, fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(
                        height:50),

                    TextFormField(

                      controller: numberController,
                      decoration: InputDecoration(

                          prefixIcon: Icon(Icons.phone
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "+92xxxxxxxx",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      keyboardType: TextInputType.emailAddress,
                      //inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{2})((-?)|( ?))([0-9]{7})$")
                                .hasMatch(value)) {
                          return 'Enter a valid number';
                        }else if (value.length < 11) {
                          return "Number should be atleast 11 digits";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Send Code',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                            iconSize: 35,
                              color: Colors.blue.shade200,
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  auth.verifyPhoneNumber(
                                      phoneNumber: numberController.text,
                                      verificationCompleted:(_){},
                                      verificationFailed: (e){Utils().toastMessage(e.toString());},
                                      codeSent: (String verification, int? token){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyVerify(
                                           verificatiobid: verification,
                                        )));
                                      },
                                      codeAutoRetrievalTimeout:(e){
                                        Utils().toastMessage(e.toString());
                                      }
                                  );
                                  //final snackBar = SnackBar(content: Text('Submitting Form'));
                                  //  _scaffoldKey.currentState!.showSnackBar(snackBar);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyVerify()));

                                }
                              },
                              icon: Icon(
                                Icons.message_sharp,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }


}