// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:marketing/contentPage.dart';
//
//
// class GeoLocation extends StatefulWidget {
//   @override
//   _GeoLocationState createState() => _GeoLocationState();
// }
//
// class _GeoLocationState extends State<GeoLocation> {
//
//
//   double lat = 0.0;
//   double lon = 0.0;
//   LocationData _currentPosition;
//
//   Location location = Location();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     final width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
//       padding: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.black.withOpacity(0.06),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text( lat== 0.0 ? "Location " : "$lat : $lon",
//             style:
//             TextStyle(fontFamily: 'Avenir',
//                 color: Colors.black.withOpacity(0.12),
//                 fontSize: height*0.020),),
//           GestureDetector(
//             onTap: (){
//               getLoc();
//             },
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 4.0,) ,
//               padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(50.0)
//               ),
//               child: Text(lat== 0.0 ?  " Get Location " : " Got it  ✓ ",
//                 style:
//                 TextStyle(fontFamily: 'Avenir',
//                     color: Colors.black,
//                     fontSize: height*0.010),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
//   getLoc() async{
//     //print("22222222222im inside the get loc hello999999999999999999");
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _currentPosition = await location.getLocation();
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       //print("${currentLocation.longitude} : ${currentLocation.longitude}");
//       setState(() {
//         _currentPosition = currentLocation;
//         //print("$lat and $lon  im inside the getloc");
//       });
//     });
//     lat = (_currentPosition.latitude);
//     lon = (_currentPosition.longitude);
//   }
//
// }
