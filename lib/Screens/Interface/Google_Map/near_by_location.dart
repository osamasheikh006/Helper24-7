import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';


const String googleAPiKey = 'AIzaSyB53N01hQ7Y5UKE8WGqJIKSC6CeQC9qQwU';

class locationTracking extends StatefulWidget {
  const locationTracking({Key? key}) : super(key: key);

  @override
  _locationTrackingState createState() => _locationTrackingState();
}

class _locationTrackingState extends State<locationTracking> {
  //final Completer<GoogleMapController> _controllar = Completer();
  List<LatLng> polylineCoordinates = [];
  late GoogleMapController mapController;
  double _originLatitude = 24.8617, _originLongitude = 67.0736;
  double _destLatitude = 24.984695, _destLongitude = 67.238928;
  Map<MarkerId, Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
 // List<LatLng> polylineCoordinates = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red[300],
          title: Text(' nerast location tracker'),
        ),

          floatingActionButton: new FloatingActionButton(

            elevation: 0.0,
            onPressed: () =>MapsLauncher.launchQuery(
                'nearst Hospital Here'),
            backgroundColor: Colors.red.shade300,
            child: const Icon(Icons.add_box_outlined),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 10),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          )),

    );

  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;

  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}