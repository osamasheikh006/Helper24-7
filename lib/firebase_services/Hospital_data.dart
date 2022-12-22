import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Hospital_data extends StatelessWidget {
  //const Userdata({Key? key}) : super(key: key);
  final auth =FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('Hospital');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital data'),
        backgroundColor: Colors.redAccent.shade200,
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (BuildContext sn, DataSnapshot snapshot,
                    Animation<double>
                    animation, int index){
                  return ListTile(
                    title: Text(snapshot.child('Email').value.toString()),
                  );
                },)
          )
        ],
      ),
    );
  }
}
