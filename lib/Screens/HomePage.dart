import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_buddy/Widgets/CreateGroupPage.dart';
import 'package:trip_buddy/Widgets/Drawer.dart';
import 'package:trip_buddy/Screens/TripDetails/TripDetails.dart';
import 'package:trip_buddy/ViewModels/TripViewModel.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) { 
    return 
    Container(
      decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/images/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
       backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('TripBuddy'),
        ),

        floatingActionButton: FloatingActionButton(
      
          onPressed: () {
            createTripPage();
          },
          child: Icon(Icons.add)
        ),
        drawer: Drawer(child: buildDrawer()),

        body: GetX<TripViewModel>(
          init: TripViewModel(),
          builder: (data){
            
            List tripData = data.getTrips();

            return tripData.isNotEmpty ? ListView.builder( 
              itemCount: tripData.length,
              itemBuilder: (context,index){

                return Padding(
                  padding: const EdgeInsets.only(bottom: 7, top: 7),
                  child: Card(

                    color: Colors.lightBlue,
                    shadowColor: Colors.black,
                    shape:  RoundedRectangleBorder(
                    
                      borderRadius:BorderRadius.circular(
                        13
                      ) ,
                    
                    ),
                   
                    child: SizedBox(
                      height: 80,
                      child: ListTile(
                        
                        title: Center(
                          child: Text(tripData[index]['name'],
                          style: 
                          GoogleFonts.sigmarOne(
                            color:Colors.white,
                          fontSize: 20
                          )
                      
                          ),
                        ),

                        onTap: (){
                          Get.to(() => TripDetails(tripId: tripData[index].id));
                        },
                      ),
                    ), 
                  ),
                );
              }
            ) : Center(child: Container(
              
              color: Colors.white,
              child: Text('No Trip data',
              style: TextStyle(
                fontSize: 30
              ),)
              ),);
          },
        ),
        
      ),
    );
  }
}