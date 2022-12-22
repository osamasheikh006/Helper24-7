import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:maps_launcher/maps_launcher.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Users/compouand/polyline_screen.dart';
import 'near_by_location.dart';
//import 'google_search_places_api.dart';

const String googleApiKey = 'AIzaSyB53N01hQ7Y5UKE8WGqJIKSC6CeQC9qQwU';

class driver_map extends StatefulWidget {
  const driver_map({Key? key}) : super(key: key);

  @override
  _driver_mapState createState() => _driver_mapState();
}

class _driver_mapState extends State<driver_map> {
  TextEditingController lant = TextEditingController();
  CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();
  String address = '';
  final Completer<GoogleMapController> _controller = Completer();
  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 11,
  );

//Place Marker in google map
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.827716, 67.239354),
        infoWindow: InfoWindow(
          // onTap: ,
            title: ' chipha Ambulance ')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(24.8208, 67.1219),
        infoWindow: InfoWindow(title: ' edhi Ambulance ')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(29.471550, 77.696732),
        infoWindow: InfoWindow(title: 'chipha Ambulance ')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(30.539730, 47.787201),
        infoWindow: InfoWindow(title: 'Jatoi Ambulance ')),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(26.825990, 80.944800),
        infoWindow: InfoWindow(title: ' Edhi Ambulance ')),
    Marker(
        markerId: MarkerId('6'),
        position: LatLng(24.8816, 67.1492),
        infoWindow: InfoWindow(title: ' Chhipa Ambulance ')),
    Marker(
        markerId: MarkerId('7'),
        position: LatLng(24.9082, 67.1276),
        infoWindow: InfoWindow(title: ' Chhipa Ambulance ')),
    Marker(
        markerId: MarkerId('8'),
        position: LatLng(24.9114, 67.0940),
        infoWindow: InfoWindow(title: ' Aman Ambulance ')),
    Marker(
        markerId: MarkerId('10'),
        position: LatLng(24.8756, 67.0596),
        infoWindow: InfoWindow(title: ' Aman Ambulance ')),
    Marker(
        markerId: MarkerId('11'),
        position: LatLng(24.8876, 67.0695),
        infoWindow: InfoWindow(title: ' Chhipha Ambulance ')),
    Marker(
        markerId: MarkerId('12'),
        position: LatLng(24.887124, 67.155791),
        infoWindow: InfoWindow(title: ' Chhipha Ambulance ')),
    Marker(
        markerId: MarkerId('12'),
        position: LatLng(24.813032, 67.115315),
        infoWindow: InfoWindow(title: ' Al Muneeb Ambulance ')),
    Marker(
        markerId: MarkerId('13'),
        position: LatLng(24.813032, 67.115315),
        infoWindow: InfoWindow(title: ' Sindh rescure Ambulance ')),
    Marker(
        markerId: MarkerId('14'),
        position: LatLng(24.863827, 67.069544),
        infoWindow: InfoWindow(title: ' Aman Ambulance ')),
    Marker(
        markerId: MarkerId('15'),
        position: LatLng(24.848164, 67.0888),
        infoWindow: InfoWindow(title: ' Edhi Ambulance ')),
    Marker(
        markerId: MarkerId('16'),
        position: LatLng(24.95, 66.966667),
        infoWindow: InfoWindow(title: ' Edhi Ambulance ')),
    Marker(
        markerId: MarkerId('17'),
        position: LatLng(24.95, 66.966667),
        infoWindow: InfoWindow(title: ' Edhi Ambulance ')),
    Marker(
        markerId: MarkerId('18'),
        position: LatLng(25.036316, 67.062721),
        infoWindow: InfoWindow(title: ' Chhipha Ambulance ')),
    Marker(
        markerId: MarkerId('19'),
        position: LatLng(24.914359, 67.057374),
        infoWindow: InfoWindow(title: ' JDC Ambulance ')),
    Marker(
        markerId: MarkerId('20'),
        position: LatLng(24.869073, 67.056323),
        infoWindow: InfoWindow(title: ' Edhi Ambulance ')),
    Marker(
        markerId: MarkerId('21'),
        position: LatLng(24.8617, 67.0736),
        infoWindow: InfoWindow(title: ' Edhi Ambulance ')),
  ];

  final List<LatLng> _latLang = [
    const LatLng(24.827716, 67.239354),
    const LatLng(24.8208, 67.1219),
    const LatLng(29.471550, 77.696732),
    const LatLng(30.539730, 47.787201),
    const LatLng(26.825990, 80.944800),
    const LatLng(24.8816, 67.1492),
    const LatLng(24.9082, 67.1276),
    const LatLng(24.9114, 67.0940),
    const LatLng(24.8756, 67.0596),
    const LatLng(24.8876, 67.0695),
    const LatLng(24.813032, 67.115315),
    const LatLng(24.813032, 67.115315),
    const LatLng(24.863827, 67.069544),
    const LatLng(24.848164, 67.0888),
    const LatLng(24.95, 66.966667),
    const LatLng(24.95, 66.966667),
    const LatLng(25.036316, 67.062721),
    const LatLng(24.914359, 67.057374),
    const LatLng(24.869073, 67.056323),
    const LatLng(24.8617, 67.0736),
  ];

  loadData() {
    for (int i = 0; i < _latLang.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLang[i],
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
    }
    _getUserCurrentLocation().then((value) async {
      for (int i = 0; i < _latLang.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latLang[i],
        ));
        setState(() {});
      }

      final GoogleMapController controller = await _controller.future;
      CameraPosition _kGooglePlex = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      setState(() {});
    });
  }

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  static const LatLng sourcelocation = LatLng(24.8617, 67.0736);
  static const LatLng destinationlocation = LatLng(24.905306, 67.036034);
  void getpolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
        PointLatLng(
            destinationlocation.latitude, destinationlocation.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    onPressed: () =>MapsLauncher.launchQuery(
                        'nerast Ambulance Here'),
                    backgroundColor: Colors.red.shade300,
                    child: const Icon(Icons.add_box_outlined),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _getUserCurrentLocation().then((value) async {
                        _markers.add(Marker(
                            markerId: const MarkerId('Help'),
                            position: LatLng(value.latitude, value.longitude),
                            infoWindow: InfoWindow(title: address)));

                        final GoogleMapController controller =
                        await _controller.future;

                        CameraPosition _kGooglePlex = CameraPosition(
                          target: LatLng(value.latitude, value.longitude),
                          zoom: 14,
                        );
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(_kGooglePlex));

                        List<Placemark> placemarks =
                        await placemarkFromCoordinates(
                            value.latitude, value.longitude);

                        final add = placemarks.first;
                        address = add.locality.toString() +
                            " " +
                            add.administrativeArea.toString() +
                            " " +
                            add.subAdministrativeArea.toString() +
                            " " +
                            add.country.toString();

                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 143, 158, 1),
                                Color.fromRGBO(155, 100, 250, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                              'Current Location',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(address),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
