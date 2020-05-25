import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:maplocation/screen3.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return locationC();
  }
}

class locationC extends StatefulWidget {
  @override
  _locationCState createState() => _locationCState();
}

double userLong;
double userLat;
getCurrentUserLocation()async{
  //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //print(position);

  dynamic currentLocation = LocationData;
  var error;
  var location = new Location();
// Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocation = await location.getLocation();

    userLat = currentLocation.latitude;
    userLong = currentLocation.longitude;

    print(userLong);

  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      error = 'Permission denied';
    }
    currentLocation = null;
  }
}
class _locationCState extends State<locationC> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserLocation();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Builder(builder: (context)=>  Container(
          padding: EdgeInsets.only(top: 50),
          color: Colors.white,
          child:Column(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  onPressed: ()async{
                    getCurrentUserLocation();
                  },
                  child: Text('Press'),),
              ),
              GestureDetector(

                child: Text('Go Map',style: TextStyle(fontSize: 33,color: Colors.green),),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Screen3(latitude:userLat ,longitude:userLong ,);
                  }));
                } ,
              )
            ],
          )
      ),)
    );
  }

}
