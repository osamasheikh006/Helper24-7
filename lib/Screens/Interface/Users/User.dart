import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studio/Screens/Interface/Users/compouand/Navbar.dart';
import 'package:studio/Screens/Interface/Google_Map/current_location.dart';

import '../../Chat_app/Chat_Rom.dart';
//import '../../Chat_app/Chat_ui.dart';
import '../../Chat_app/User_chat.dart';
import '../../Welcome/welcome_screen.dart';
import 'compouand/Gridview.dart';
//import '../Google_Map/screens/home_page.dart';
void main() {
  runApp(const Users());
}

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'easy_sidemenu Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'easy_sidemenu Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();
  List<String>imageslist=[
    'assets/images/ambulance.png',
  ];
Navbar navbar=new Navbar();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //resizeToAvoidBottomInset: false,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(

            children: [
              Navbar(),
              Mydrawlist(),
            ],
          ),
        ),
      ),
      appBar: AppBar(

        title: Text('User',style: TextStyle(color: Colors.black,),),),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(image: new AssetImage("assets/images/ambulance.png")),
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
        child: GridView(
            padding: const EdgeInsets.only(top: 80.0),
            children:<Widget> [
              InkWell(
                onTap: (){

                },
              child:Container(
                //margin:  const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),color: Colors.pink.shade200,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.redAccent.shade200,
                        spreadRadius: 5,
                        blurRadius: 25
                    )
                  ]
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.account_circle,size: 50,color: Colors.white,),
                    Text("Desboard",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ],
                ),

              ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentLocationScreen()));
                },
              child:Container(
                //margin:  const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),color: Colors.redAccent.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.shade300,
                          spreadRadius: 5,
                          blurRadius: 35
                      )
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.add_circle,size: 50,color: Colors.white,),
                    Text("Emergance",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ],
                ),
              ),
              ),

        InkWell(
            onTap: (){},
            child:Container(
                //margin:  const EdgeInsets.only(top: 20.0),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),color: Colors.blue.shade300,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.tealAccent.shade200,
                          spreadRadius: 10,
                          blurRadius: 15
                      )
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.car_rental_rounded ,size: 50,color: Colors.white,),
                    Text("Ambulance Booking",style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],
                ),
              ),
        ),

        InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>chat_users()));

            },
            child: Container(
                //margin:  const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),color: Colors.orangeAccent.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.pinkAccent.shade200,
                          spreadRadius: 5,
                          blurRadius: 25
                      )
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.chat,size: 50,color: Colors.white,),
                    Text("Chat app",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ],
                ),
              ),
        ),

            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10)),

      ),
      );

  }
  Widget Mydrawlist(){
    return Container(
      padding: EdgeInsets.only(top: 15,),
      child: Column(
        children: [
          menuItem(),
        ],

      ),
    );
  }
  Widget menuItem() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Welcome_screen()));
        },
        child: Padding(padding: EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(

                  child: Icon(Icons.signpost_outlined, size: 20,
                    color: Colors.pinkAccent[300],)),
              Expanded(

                  flex: 1,
                  child: Text('Signout',
                    style: TextStyle(color: Colors.black87, fontSize: 16.0),))
            ],

          ),


        ),

      ),

    );
  }
}