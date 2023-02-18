import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio/Screens/Chat_app/voice_messaging/Voice_note_type/home/view/home_view.dart';
import'package:auto_size_text/auto_size_text.dart';
import 'hospital_chat.dart';

void main()async
{
  SharedPreferences pref=await SharedPreferences.getInstance();
  var email=pref.getString("Email");
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
  )
  );
}

Future<String> getemail() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("email") ?? "";}
class chat_users extends StatelessWidget {
  //const Userdata({Key? key}) : super(key: key);
  final storeMessage= FirebaseFirestore.instance;
  final auth =FirebaseAuth.instance;
  TextEditingController msg=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:FutureBuilder<String>(
        future: getemail(),
    builder:(context ,snap){
    if(snap.hasData){
    return Text(snap.data!);
    }else{
    return CircularProgressIndicator();
    }

    },),
        backgroundColor: Colors.redAccent.shade100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
              height:350,


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
                  child: TextFormField(
                    //cursorColor: Colors.cyan,
                    controller: msg,

                    decoration: InputDecoration(

                        hintText: "Enter message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),

                        )
                    ),

                    validator: (values){
                      if(values!.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter some text"+msg.toString());

                      }
                    },
                  ),

                ),
              ),
              IconButton(onPressed: (){
                if(msg.text.isEmpty){
                  Fluttertoast.showToast(msg: "Please Enter some text",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }
                else if(msg.text.isNotEmpty){
                  storeMessage.collection("Message").doc().set({
                    "messages":msg.text.trim(),
                    "time":DateTime.now(),
                  });
                  msg.clear();

                }

              }, icon: Icon(Icons.send)),

              IconButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));

              }, icon: Icon(Icons.mic))

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
    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //user message
      StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Message").orderBy("time").snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: SingleChildScrollView(),
          );
        }
        return ListView.builder(
           // reverse: true,
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            itemBuilder: (context,i){

              QueryDocumentSnapshot x= snapshot.data!.docs[i];
              return ListTile(

                textColor: Colors.black87,
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 150,
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade300.withOpacity(0.2),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(21),bottomRight: Radius.circular(21)),
                         border:Border.all(
                           color: Colors.blue
                         ),


                      ),
                      child:AutoSizeText(
                        x['messages'],style: TextStyle(fontSize: 20,),

                      ),

                    )
                  ],
                )


              );
            });

      },
          ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Messagedriver").orderBy("time").snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: SingleChildScrollView(),
                  );
                }
                return ListView.builder(
                  // reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context,i){

                      QueryDocumentSnapshot x= snapshot.data!.docs[i];
                      return ListTile(

                          textColor: Colors.black87,
                          title:Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Container(
                                  margin: const EdgeInsets.only(left: 170.0),
                                width: 150,
                                height: 45,

                               //margin: EdgeInsets.all(15),
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade300.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21),bottomRight: Radius.circular(21)),
                                  border:Border.all(
                                      color: Colors.blue
                                  ),


                                ),
                                  child:AutoSizeText(x['messages'],
                                      style:TextStyle(fontSize: 20,))
                              )
                            ],
                          )


                      );
                    });

              },
            ),
    ]
    );
  }

}
