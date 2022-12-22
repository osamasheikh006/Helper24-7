import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Navbardriver extends StatelessWidget {
  //const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.pink[200],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/images/image1_tr.png')),
            ),
          )
        ],
      ),
    );
  }
}
