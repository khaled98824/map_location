import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Screen3 extends StatefulWidget {
  static final pageName = '/Screen3';

  final String myValue;
  Screen3({this.myValue,@required this.latitude,@required this.longitude});

  final double longitude;
  final double latitude;

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 18);

  @override
  Widget build(BuildContext context) {

      List<Marker> allMarkers =[
        Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(22),
            infoWindow:InfoWindow(title: 'Mark 1'),
            markerId: MarkerId('myLocation'),position: LatLng(widget.latitude,widget.longitude)),
        Marker(infoWindow:InfoWindow(title: 'Mark 2'),
            markerId: MarkerId('myLocation'),position: LatLng(widget.latitude-0.020,widget.longitude+0.011)),
        Marker(onTap: ()=>print('object'),
            infoWindow:InfoWindow(title: 'Mark 3'),
            markerId: MarkerId('myLocation'),position: LatLng(widget.latitude-0.030,widget.longitude+0.061)),
      ];

    return MaterialApp(
      home: Builder(
          builder: (context) => Scaffold(
              appBar: (AppBar(
                title: Text("Screen3"),
              )),
              body:Center(
                child: Container(
                  width: 370,
                  height: 500,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller){
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude,widget.longitude), zoom: 12,),
                    mapType: MapType.normal,
                    markers: Set.from(allMarkers),
                  ),
                ),
              ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    )
      )
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
