import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:studio/Screens/Phone_Number/Phone_number.dart';
import 'package:studio/Screens/Registration/registration_user.dart';
import 'package:studio/Screens/Interface/Users/User.dart';
import '../../utils/utils.dart';
class MyVerify extends StatefulWidget {
  final String verificatiobid;

  const MyVerify({Key? key,
  required this.verificatiobid
  }) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final numberController =TextEditingController();
  final auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          //image: Image.asset('assets/images/clock.png'),
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.topRight,
                colors: [
                  Colors.red.shade50,
                  Colors.pink.shade100,
                  Colors.blue.shade300,

                ]

            )
        ),

        margin: EdgeInsets.only(left: 0, right: 0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top:30,
                child: Image.asset(
                  "assets/images/image1_tr.png",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started! Please enter your 4 digits otp",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                controller: numberController,
                length: 6,

                 //defaultPinTheme: defaultPinTheme,
                 //focusedPinTheme: focusedPinTheme,
                 //submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,

                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async{
                      final crendital= PhoneAuthProvider.credential
                        (verificationId: widget.verificatiobid, smsCode: numberController.text.toString());
                    try{
                      await auth.signInWithCredential(crendital);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Users()));

                    }catch(e){
                      Utils().toastMessage(e.toString());

                    }

                    },

                    child: Text("Verify Phone Number")),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPhone()));

                  },
                      child: Text('Edit Phone number',style:
                      TextStyle(color: Colors.blue.shade200,fontSize: 20)))

                ],

              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'ReSend Code',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                        iconSize: 30,
                        color: Colors.blue.shade200,
                        onPressed: () {
                            //final snackBar = SnackBar(content: Text('Submitting Form'));
                            //  _scaffoldKey.currentState!.showSnackBar(snackBar);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPhone()));


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
      ),
    );
  }
}