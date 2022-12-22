import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    //this.image1_tr.png="assets/images/image1_tr.png"
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Container(

        width: double.infinity,
        decoration: BoxDecoration(
          //image: Image.asset('assets/images/clock.png'),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.red.shade200,
                  Colors.pink.shade100,
                  Colors.blue.shade300,

                ]

            )
        ),
        height: MediaQuery.of(context).size.height,
        child: Stack(

          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
             Positioned(
               bottom: 0,
               right: 0,
               child: Image.asset(bottomImage, width: 120),
             ),
            Positioned(
                 top:50,
              child: Image.asset(
                "assets/images/image1_tr.png",
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
