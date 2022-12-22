import 'package:flutter/material.dart';
import 'package:studio/Screens/Interface/Google_Map/current_location.dart';
class Gridview extends StatefulWidget {
  const Gridview({Key? key}) : super(key: key);

  @override
  State<Gridview> createState() => _GridviewState();
}

class _GridviewState extends State<Gridview> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child:Padding(padding: EdgeInsets.all(30.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
            (crossAxisCount: 2,crossAxisSpacing: 10,mainAxisExtent: 10),

          children: [

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentLocationScreen()));
              },
              // child: SingleChildScrollView(
              child: Container(
                //       height: 100,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
                  //child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.emergency,size: 50,color:Colors.white,),
                        Text('Emergancy',style: TextStyle(color: Colors.white,fontSize: 25),)
                      ],
                    ),
                    ),
                  )
              ),
          ],
        ),
      ),

    );
  }
}
