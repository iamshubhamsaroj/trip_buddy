import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Tween<double> _scale = Tween<double>(begin: 0, end: 1.3);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      body: Center(
        child: TweenAnimationBuilder(
          onEnd: (){
            
            Timer(Duration(milliseconds: 1000), () => Get.off(() => App()));
        
          },
            
          tween: _scale,
          duration: Duration(milliseconds: 1000),
          builder: (BuildContext context,double scale, Widget? child){
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            child: Text('TripBuddy'),
          ),
        )
      ),
    );
  }
}