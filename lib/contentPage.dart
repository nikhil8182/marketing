import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:marketing/location.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:validators/validators.dart' as validator;

FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class ContentPage extends StatefulWidget {

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  TextEditingController customerId = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhoneNum = TextEditingController();
  TextEditingController customerEmailId = TextEditingController();
  TextEditingController customerReview = TextEditingController();
  bool colorSts = false;
  bool  validate = false;

  final _formKey = GlobalKey<FormState>();

  void createData() {
    databaseReference.child("ajay").set({
      'Customer Id': customerId.text ,
      'Name': customerName.text ,
      'Phone Number': customerPhoneNum.text,
      'Email Id': customerEmailId.text,
      'Review': customerReview.text ,
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customerId.dispose();
    customerName.dispose();
    customerPhoneNum.dispose();
    customerEmailId.dispose();
    customerReview.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  customer: customerId,
                  height: height,hintTxt: ' Id',
                  validator: (String value) {
                     if (value.isEmpty) {
                           return 'Enter your first name';
                       }
                          return null;
                         },

                ),
                CardCont(
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
                    customer: customerPhoneNum,
                    height: height,
                    hintTxt: ' Phone Number',
                  validator: (String value) {
                    if (value.isEmpty || value.length == 10) {
                      return 'Please enter minimum 10 characters';
                    }
                    return null;
                  },
                ),
                CardCont(
                    isEmail: true,
                    customer: customerEmailId,
                    height: height,
                    hintTxt: ' Email Id',
                     validator: (String value) {
                    if (!validator.isEmail(value)) {
                      return 'Please enter a valid email';
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
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                      ],
                    ),
                  ),
                ),
                CardCont(customer: customerReview,
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
                    }


                    print(customerId.text);
                    print(customerName.text);
                    print(customerPhoneNum.text);
                    print(customerEmailId.text);
                    print(customerReview.text);

                    createData();

                    customerId.clear();
                    customerName.clear();
                    customerPhoneNum.clear();
                    customerEmailId.clear();
                    customerReview.clear();

                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>ContentPage()));
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
                  height: height*0.020,
                ),
                Center(
                  child: Text(" Need Help ? ",
                    style: TextStyle(fontFamily: 'Avenir',
                        color: Colors.white.withOpacity(0.69),
                        fontSize: height*0.012),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class CardCont extends StatelessWidget {
  CardCont({Key key,
    @required this.customer,
    @required this.height,
    @required this.hintTxt,
    @required  this.validator,
    this.isEmail = false,



  }) : super(key: key);

  final TextEditingController customer;
  final double height;
  final String hintTxt;
  final bool isEmail ;
  final Function validator;



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
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
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
