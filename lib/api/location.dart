import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationSample extends StatefulWidget{
  @override
  _LocationSampleState createState() => _LocationSampleState();
}

class _LocationSampleState extends State<LocationSample> {
  late Position position;

  @override
  void initState() {
    super.initState();
    _determinepermission();
    _getLocation(context);
  }


  Future<void> _getLocation(context) async {
    Position _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(_currentPosition);
    setState(() {
      position = _currentPosition;
    });
  }

  Future<void> _determinepermission() async {
    bool serviceEnable;
    LocationPermission permission;
    
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable) {
      return Future.error('Location services are disable');
    }
    
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      // second 
      permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location permissions are disable');
      }
    }
    
    if(permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, you can not use rain timer change');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationPermission>(
      future: Geolocator.checkPermission(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if(snapshot == LocationPermission.denied || snapshot == LocationPermission.deniedForever) {
          return Text(
            'Access to location denied',
            textAlign: TextAlign.center,
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Location Information',
                style: TextStyle( fontSize: 20.0 ),
              ),
              Text("Your Current Location is :"),
              Text("${position}")
            ],
          )
        );
      }
    );
  }
}
