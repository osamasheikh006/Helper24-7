import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async
{
  SharedPreferences pref=await SharedPreferences.getInstance();
  var email=pref.getString("Email");
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
  )
  );
}

class chat_users extends StatelessWidget {
  //const Userdata({Key? key}) : super(key: key);
  final storeMessage= FirebaseFirestore.instance;
  final auth =FirebaseAuth.instance;
  TextEditingController msg=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Chat View'),
    backgroundColor: Colors.redAccent.shade100,
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
       // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            height:300,


              child:SingleChildScrollView(
              reverse: true,
            child:ShowMessage(),
            )
          ),
          Row(
            children: [
              Expanded(
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color:Colors.black87,width: 0.2)
                      )
                    ),
                    child: TextField(
                      //cursorColor: Colors.cyan,
                      controller: msg,

                      decoration: InputDecoration(

                          hintText: "Enter message"
                      ),
                    ),

                  ),
              ),
              IconButton(onPressed: (){
                if(msg.text.isNotEmpty){
                  storeMessage.collection("Message").doc().set({
                    "messages":msg.text.trim(),
                    "time":DateTime.now(),
                   });
                  msg.clear();

                }
              }, icon: Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }
}
class ShowMessage extends StatelessWidget {
  //const ShowMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("Message").orderBy("time").snapshots(),
      builder: (context,snapshot){
      if(!snapshot.hasData){
        return Center(
          child: SingleChildScrollView(),
        );
      }
      return ListView.builder(
        reverse: true,
        itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          primary: true,
          physics: ScrollPhysics(),
          itemBuilder: (context,i){

        QueryDocumentSnapshot x= snapshot.data!.docs[i];
        return ListTile(
          textColor: Colors.red.shade300,
          title: Text(

            x['messages'],style: TextStyle(fontSize: 20),
          ),

        );
      });
      },
    );
  }
}
