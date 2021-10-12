import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:marketing/contentPage.dart';



final databaseReference = FirebaseDatabase.instance.reference();

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            children: [
              SizedBox(
                height: height*0.040,
              ),
              Text("Account",
                style:
                TextStyle(fontFamily: 'Avenir',
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.08),
                    fontSize: height*0.050),),
              Text("Login",
                style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.08),
                    fontSize: height*0.050),),
              SizedBox(
                height: height*0.15,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black.withOpacity(0.06),
                ),
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: ' User Id',
                    hintStyle: TextStyle(fontFamily: 'Avenir',
                        color: Colors.white.withOpacity(0.69),
                        fontSize: height*0.020),
                  ),
                ),
              ),
              SizedBox(
                height: height*0.020,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black.withOpacity(0.06),
                ),
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: ' Password',
                    hintStyle: TextStyle(fontFamily: 'Avenir',
                        color: Colors.white.withOpacity(0.69),
                        fontSize: height*0.020),
                  ),
                ),
              ),
              SizedBox(
                height: height*0.15,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ContentPage()));
                },
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
              SizedBox(
                height: height*0.030,
              ),
              Text("Need Help ? Contact Admin",
                style: TextStyle(fontFamily: 'Avenir',
                    color: Colors.white.withOpacity(0.69),
                    fontSize: height*0.010),

              )
            ],

          ),
        ),
      ),
    );
  }
}
