import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationdriver extends StatefulWidget {
  const CurrentLocationdriver({Key? key}) : super(key: key);

  @override
  _CurrentLocationdriverState createState() => _CurrentLocationdriverState();
}

class _CurrentLocationdriverState extends State<CurrentLocationdriver> {

  String address = '' ;
  final Completer<GoogleMapController> _controller = Completer();


  Future<Position> _getdriverCurrentLocation() async {


    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace){
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }


  final List<Marker> _markers =  <Marker>[];

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14,
  );


  List<Marker> list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.8369, 67.0502),
        //icon: Icons.add_business_rounded,
        infoWindow: InfoWindow(
            title: 'pns rahat hospital karachi '
        )
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(list);
    //loadData();
  }

  loadData(){
    _getdriverCurrentLocation().then((value) async {
      _markers.add(
          Marker(
              markerId: const MarkerId('SomeId'),
              position: LatLng(value.latitude ,value.longitude),
              infoWindow:  InfoWindow(
                  title: address
              )
          )
      );

      final GoogleMapController controller = await _controller.future;
      CameraPosition _kGooglePlex =  CameraPosition(
        target: LatLng(value.latitude ,value.longitude),
        zoom: 14,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[300],
        title: Text(' Google Map'),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * .2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      _getdriverCurrentLocation().then((value) async {
                        _markers.add(
                            Marker(
                                markerId: const MarkerId('SomeId'),
                                position: LatLng(value.latitude ,value.longitude),
                                infoWindow:  InfoWindow(
                                    title: address
                                )
                            )
                        );
                        final GoogleMapController controller = await _controller.future;

                        CameraPosition _kGooglePlex =  CameraPosition(
                          target: LatLng(value.latitude ,value.longitude),
                          zoom: 14,
                        );
                        controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

                        List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude ,value.longitude);


                        final add = placemarks.first;
                        address = add.locality.toString() +" "+add.administrativeArea.toString()+" "+add.subAdministrativeArea.toString()+" "+add.country.toString();

                        setState(() {

                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                      child: Container(
                        height: 40,

                        decoration: BoxDecoration( gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 143, 158, 1),
                            Color.fromRGBO(155, 100, 250, 1),
                          ],
                        ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text('Current Location' , style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(address),
                  )
                ],
              ),
            )
          ],
        ),

      ),
    );
  }


}
