import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studio/Screens/Role_page/Role_singup.dart';
import 'package:studio/Screens/Welcome/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studio/Screens/Login/Login_Role/login.dart';

import '../../Login/Roles_Login/Role_login.dart';
import '../../Phone_Number/Phone_number.dart';
import '../../components/round_button.dart';
//import 'package:studio/Screens/Animation/FadeAnimation.dart';
class Body extends StatelessWidget {
  //get children => null;
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Size size =MediaQuery.of(context).size;
    return Background(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[ const Text("Welcome to Helper 24/7",style: TextStyle(fontWeight: FontWeight.bold,fontSize:25),),
        SizedBox(height:30),
        //SvgPicture.asset("assets/images/image1_tr.png",height: size.height*0.4,),
        SizedBox(height: 20,),
        RoundButton(title: 'Login ',
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute
                (builder: (context)=>Role_login()));
            }),

 
        SizedBox(height: 20,),
        RoundButton(title: 'Registration ',
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute
                (builder: (context)=>Role_page()));
            }),

      ]
        )
    );
  }
}