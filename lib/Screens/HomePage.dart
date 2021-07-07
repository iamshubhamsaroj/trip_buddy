import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/Widgets/CreateGroupPage.dart';
import 'package:trip_buddy/Widgets/Drawer.dart';
import 'package:trip_buddy/Screens/TripDetails/TripDetails.dart';
import 'package:trip_buddy/ViewModels/TripViewModel.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) { 
    return Scaffold(

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

              return Card(
                child: ListTile(
                  title: Text(tripData[index]['name']),

                  onTap: (){
                    Get.to(() => TripDetails(tripId: tripData[index].id));
                  },
                ), 
              );
            }
          ) : Center(child: Text('No data'),);
        },
      ),
    );
  }
}