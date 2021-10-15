import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marketing/App.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:validators/validators.dart' as validator;
import 'package:intl/intl.dart';
import 'package:location/location.dart';



final firestoreInstance = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();


double lat = 0.0;
double lon = 0.0;


class ContentPage extends StatefulWidget {

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhoneNum = TextEditingController();
  TextEditingController customerEmailId = TextEditingController();
  TextEditingController customerReview = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  bool colorSts = false;
  bool  validate = false;
  int id = 1 ;
  List needs = [];
  List valuesId = [];
  int count = 0;
  String formattedDate ;
  double ratingScore = 0;
  String marketer= " ";
  SharedPreferences loginData;
  //List<String> mobNumVerify = [];
 List mobNumVerify = [];


  final _formKey = GlobalKey<FormState>();

  void createData() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('h:mm-a d-MM-yyyy').format(now);
      databaseReference.child("Id - $id").set({
        'Customer Id': id ,
        'Name': customerName.text ,
        'Phone Number': customerPhoneNum.text,
        'Email Id': customerEmailId.text,
        'Review': customerReview.text ,
        'Address' : customerAddress.text,
        'lat' : lat,
        'lon ': lon,
        'rating' : ratingScore,
        'time' : formattedDate,
        'details fetched by' : marketer,
      });
  }


  Future<void> initial() async {

    firestoreInstance.collection("marketing").doc(auth.currentUser.uid).get().then((value) {

      marketer = value.data()['name'];
      print(value.data()['name']);

    });

    databaseReference.once().then((DataSnapshot snapshot) async {
      setState(() {
        Map<dynamic, dynamic> dataJson = snapshot.value;
        dataJson.forEach((key, values) {
          needs.add(key);
          valuesId.add(values);
          count = needs.length;
          id = valuesId[count-1]['Customer Id'];
          id = id+1;
        });
      });
      for(int i = 0; i<=count;i++){
        String number = valuesId[i]['Phone Number'];
        mobNumVerify.add(number);
      }
    });
  }

  @override
  void initState() {
    // Timer.periodic(
    //     Duration(seconds: 1),
    //         (Timer t) => initial());
    initial();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customerName.dispose();
    customerPhoneNum.dispose();
    customerEmailId.dispose();
    customerReview.dispose();
    customerAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text('Warning',style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
          content: Text('Do you really want to exit',style: TextStyle(color: Colors.white60),),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 30.0),
          height: height*1.0,
          width: width*1.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(247, 179, 28, 1.0),
                    Color.fromRGBO(247, 94, 28, 1.0),
                  ],
                  stops: [0.2,0.9]
              )
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height*0.030,
                  ),
                  Text("Enter task details",
                    style:
                    TextStyle(fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.09),
                        fontSize: height*0.030),),
                  SizedBox(
                    height: height*0.030,
                  ),

                  CardCont(
                    sts: false,
                    type: TextInputType.text,
                    height: height,
                    hintTxt: "  $id",
                  ),
                  CardCont(
                    type: TextInputType.text,
                      customer: customerName,
                      height: height,
                      hintTxt: ' Name',
                      validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Customer name';
                      }
                      return null;
                    },
                  ),
                  CardCont(
                    type: TextInputType.phone,
                      customer: customerPhoneNum,
                      height: height,
                      hintTxt: ' Phone Number',
                    validator: (String value) {
                      if (value.length <= 9) {
                        return 'Please enter minimum 10 characters';
                      }
                      return null;
                    },
                  ),
                  CardCont(
                     type: TextInputType.emailAddress,
                      customer: customerEmailId,
                      height: height,
                      hintTxt: ' Email Id',
                    //    validator: (String value) {
                    //   if (!validator.isEmail(value)) {
                    //     return 'Please enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  CardCont(
                    type: TextInputType.text,
                    customer: customerAddress,
                    height: height,
                    hintTxt: ' Address ',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter address';
                      }
                      return null;
                    },
                  ),
                  GeoLocation(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" Upload Photo",
                          style:
                          TextStyle(fontFamily: 'Avenir',
                              color: Colors.black.withOpacity(0.12),
                              fontSize: height*0.020),),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 4.0,) ,
                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.0)
                            ),
                            child: Text(" Upload ",
                              style:
                              TextStyle(fontFamily: 'Avenir',
                                  color: Colors.black,
                                  fontSize: height*0.010),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                   SizedBox(
                      height: height*0.010,
                   ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      child: Column(
                        children: [
                          Text("Customer Rating ",
                            style:
                            TextStyle(fontFamily: 'Avenir',
                                color: Colors.black,
                                fontSize: height*0.020),
                          ),
                      RatingBar.builder(
                        initialRating: ratingScore,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          ratingScore = rating;
                        },
                      ),
                        ],
                      ),
                    ),
                  ),
                  CardCont(customer: customerReview,
                      type: TextInputType.multiline,
                      height: height,
                      hintTxt: ' Customer Review',
                      validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Customer name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height*0.020,
                  ),
                  GestureDetector(
                    onTap: (){
                      if (_formKey.currentState.validate()) {
                        print("success fully validated");
                          if(mobNumVerify.contains(customerPhoneNum.text)){
                            _adminDialog();
                          }
                          else{
                            _showDialog();
                          }
                      }
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 70.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Text("Submit",
                            style: TextStyle(fontFamily: 'Avenir',
                                color: Color.fromRGBO(247, 94, 28, 1.0),
                                fontSize: height*0.020)
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height*0.005,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(" Need Help ? ",
                          style: TextStyle(fontFamily: 'Avenir',
                              color: Colors.white.withOpacity(0.69),
                              fontSize: height*0.012),
                        ),
                        SizedBox(
                          width: width*0.20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: () async {
                              loginData = await SharedPreferences.getInstance();
                              loginData.setBool('login', true);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => MyApp()));
                            }, icon: Icon(Icons.login_outlined,size: height*0.050,)
                            ),
                            SizedBox(
                             height: height*0.005,
                            ),
                            Text(" Logout ",
                              style: TextStyle(fontFamily: 'Avenir',
                                  color: Colors.white.withOpacity(0.69),
                                  fontSize: height*0.008),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: width*0.09,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          content: Text(" Are you sure to submit details ? "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text("Submit" ,
                style:
                TextStyle(fontSize: MediaQuery.of(context).size.height*0.020,fontFamily: 'Avenir',color: Color.fromRGBO(247, 148, 28,1.0)),),
              onPressed: () {
                createData();
                Navigator.of(context).pop();
                initial();
                customerName.clear();
                customerPhoneNum.clear();
                customerEmailId.clear();
                customerReview.clear();
                customerAddress.clear();
                final snackBar = SnackBar(content: Text(" successfully submitted "),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: new Text("cancel ", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.020, fontFamily: 'Avenir',
                  color: Color.fromRGBO(247, 97, 28,1.0))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  _adminDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text('Oops !! Data Matches'),
          content: Text(" If you want rewrite, kindly contact admin."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: new Text(" Thank you ", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.020, fontFamily: 'Avenir',
                  color: Color.fromRGBO(247, 97, 28,1.0))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



class CardCont extends StatelessWidget {
  CardCont({Key key,
    this.customer,
    @required this.height,
    @required this.hintTxt,
    this.validator,
    this.type,
    this.sts = true,

  }) : super(key: key);

  final TextEditingController customer;
  final double height;
  final String hintTxt;
  final TextInputType type;
  final Function validator;
  final bool sts;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black.withOpacity(0.06),
      ),
        child: TextFormField(
          inputFormatters: [ new LengthLimitingTextInputFormatter(500), ],
          maxLines: null,
        enabled: sts,
        keyboardType: type,
        validator: validator,
        cursorColor: Colors.grey,
        controller: customer,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintTxt,
          hintStyle:
          TextStyle(fontFamily: 'Avenir',
              color: Colors.white.withOpacity(0.69),
              fontSize: height*0.020),
        ),
      ),
    );
  }
}



class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {



  LocationData _currentPosition;

  Location location = Location();



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black.withOpacity(0.06),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( lat== 0.0 ? "Location " : "$lat : $lon",
            style:
            TextStyle(fontFamily: 'Avenir',
                color: Colors.black.withOpacity(0.12),
                fontSize: height*0.020),),
          GestureDetector(
            onTap: (){
              getLoc();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0,) ,
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0)
              ),
              child: Text(lat== 0.0 ?  " Get Location " : " Got it  ✓ ",
                style:
                TextStyle(fontFamily: 'Avenir',
                    color: Colors.black,
                    fontSize: height*0.010),
              ),
            ),
          )
        ],
      ),
    );
  }


  getLoc() async{
    //print("22222222222im inside the get loc hello999999999999999999");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      //print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        //print("$lat and $lon  im inside the getloc");
      });
    });
    lat = (_currentPosition.latitude);
    lon = (_currentPosition.longitude);
  }

}
