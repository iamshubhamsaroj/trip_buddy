import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_buddy/Services/AuthService.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            height: 300,
            width: 300,
            alignment: Alignment.topCenter,
            child: Image.asset(
              "lib/images/travel.png",
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text(
              'Tripbuddy',
              style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(
                       color: Colors.black,
                        fontSize: 40, fontWeight: FontWeight.w900)),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(
              'Online travelling expense manager ',
              style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 17)),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
              child: InkWell(
                child: Container(
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.deepPurple), 
                      borderRadius: BorderRadius.circular(10)),
                    child: Image(image:AssetImage("lib/images/sign.png"),
                    height: 45,),
                  ),

                onTap: () async {
                  dynamic result = AuthService().signInGoogle();

                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Some error occured'),
                    ));
                  }
                },
              ))
        ]),
      )),
    );
  }
}

