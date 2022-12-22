import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({Key? key,
    required this.title,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
      child:Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Color.fromRGBO(255, 143, 158, 1),
    Color.fromRGBO(155, 100, 250, 1),
    ],
        ),
        borderRadius: BorderRadius.circular(30),
          boxShadow:  [
      BoxShadow(
      color: Colors.red.shade500.withOpacity(0.5),
        spreadRadius: 4,
        blurRadius: 10,
        offset: Offset(0, 3),
      )
        ]
      ),
      child: Center(child: Text(title,style: TextStyle
        (color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w800),)),
    )
    );
  }
}
