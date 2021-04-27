import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  BitmapDescriptor myIcon;
  GoogleMapController myController;
  double currentLat;
  double currentLong;

//  dynamic currentAddress;
  String searchAddress = 'Search with Locations';
  String userLocation;
  Marker marker = Marker(
    markerId: MarkerId("1"),
  );
  Set<Marker> mark = Set();

  var location = Location();

  _getAddress() async {
    Position position = await Geolocator().getCurrentPosition();
    setState(() {
      currentLat = position.latitude;
      currentLong = position.longitude;
    });
    Geolocator()
        .placemarkFromCoordinates(currentLat, currentLong)
        .then((address) {
      setState(() {
        userLocation = address[0].subAdministrativeArea +
            "-" +
            address[0].administrativeArea;
      });
    });
    print("LAAAAAAAAAAAAAAAAAAAAAAAAAAT" + currentLat.toString());
    print("LNNNNNNNNNNNNNNNNNNNNNNNNNNG" + currentLong.toString());
  }

  void initState() {
    _getAddress();
    super.initState();
    location.getLocation().then((LocationData myLocation) {
      setState(() {
        Geolocator()
            .placemarkFromCoordinates(myLocation.latitude, myLocation.longitude)
            .then((address) {
          setState(() {
            userLocation = address[0].name + " " + address[0].country;
            print("================== $userLocation");
          });
        });
        currentLat = myLocation.latitude;
        currentLong = myLocation.longitude;

        InfoWindow infoWindow = InfoWindow(title: "Location");
        Marker marker = Marker(
          draggable: true,
          markerId: MarkerId('markers.length.toString()'),
          infoWindow: infoWindow,
          position: LatLng(myLocation.latitude, myLocation.longitude),
          icon: myIcon,
        );
        setState(() {
          mark.add(marker);
        });
      });
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(
          20,
          20,
        ),
        devicePixelRatio: 0,
      ),
      'assets/images/marker.png',
    ).then((onValue) {
      myIcon = onValue;
    });
  }

  Widget _confirmButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 50,

        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).primaryColor,
        ),
        width: MediaQuery.of(context).size.width/1.5,
        child: Center(
          child: Text(
            "Ok",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      myController = controller;
    });
  }

  Position updatedPosition;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: currentLat == null && currentLong == null
              ? Center(
                  child: SpinKitThreeBounce(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onCameraIdle: () {
                          print(updatedPosition);
                        },
                        onTap: (newLang) {
                          currentLat = updatedPosition.latitude;
                          currentLong = updatedPosition.longitude;
                          print('LAT    ' + currentLat.toString());
                          print('LONG    ' + currentLong.toString());
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(currentLat, currentLong),
                            zoom: 15.0),
                        onMapCreated: _onMapCreated,
                        onCameraMove: ((_position) =>
                            _updatePosition(_position)),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.location_on,
                              color: Theme.of(context).primaryColor, size: 40)),
                      currentLat == null ||
                              currentLong == null ||
                              userLocation == null
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                  onTap: () async {
                                    print(userLocation.toString());
                                    print(currentLat.toString());
                                    print(currentLong.toString());
                                    Navigator.pop(context, [
                                      userLocation,
                                      currentLat,
                                      currentLong
                                    ]);
                                  },
                                  child: _confirmButton(context)),
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _updatePosition(CameraPosition _position) {
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    setState(() {
      updatedPosition = newMarkerPosition;
      currentLat = newMarkerPosition.latitude;
      currentLong = newMarkerPosition.longitude;
      marker = marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
      Geolocator()
          .placemarkFromCoordinates(
              updatedPosition.latitude, updatedPosition.longitude)
          .then((address) {
        setState(() {
          userLocation = address[0].name + "  " + address[0].country;
          print("================== $userLocation");
        });
      });
    });
  }
}
