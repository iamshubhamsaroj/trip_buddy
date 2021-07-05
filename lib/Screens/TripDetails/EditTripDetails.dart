import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_buddy/ViewModels/TripViewModel.dart';
import 'package:trip_buddy/Screens/TripDetails/AddBuddy.dart';


class EditTripDetails extends StatelessWidget {

  final String tripId;
  EditTripDetails({ Key? key , required this.tripId}) : super(key: key);

  
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text('Edit Trip Details'),
      ), 

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: (){
          Get.to(() => AddBuddy(tripId: tripId,));
        },
      ),

      body: GetX<TripViewModel>(
        init: TripViewModel(),
        builder:(data){

          var tripData;
          data.getTrips().forEach((element) {
            if(element.id == tripId){
              tripData = element;
            }
          });

          final TextEditingController controller = TextEditingController(text: tripData['name']);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 

                Padding( 
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Trip name',style: GoogleFonts.openSans(
                    textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                  ) ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,15,15),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: controller,
                      validator: (val ){
                        if(val != null)
                        return val.isEmpty ? 'Please enter Trip name' : null;
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Trip buddies',style: GoogleFonts.openSans(
                    textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                  ) ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: tripData['buddies'].length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          title: Text(tripData['buddies'][index]['name']),
                          subtitle: Text(tripData['buddies'][index]['email']),
                        ),
                      );
                      
                    }
                  )
                )
              ],
            ),
          );
        } 
      ),
    );
  }
}