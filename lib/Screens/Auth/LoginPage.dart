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
              style: GoogleFonts.meriendaOne(
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
              style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 17)),
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
                       child: Text(
                      "sign in",
                      
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    decoration: BoxDecoration(
                   image: DecorationImage(
                     alignment: Alignment(-0.7,-0.5),image: AssetImage("lib/images/google.png",)) ,
                        color: Colors.blue[200],
                        border: Border.all(color: Colors.blue),
                        boxShadow: [
                          BoxShadow(blurRadius: 30, color: Colors.black12)
                        ],
                        borderRadius: BorderRadius.circular(5)),
                 
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

