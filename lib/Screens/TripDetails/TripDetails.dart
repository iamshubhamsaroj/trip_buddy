import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/Screens/Expense/AddExpense.dart';
import 'package:trip_buddy/Screens/Expense/Expenses.dart';
import 'package:trip_buddy/Screens/TripDetails/Totals.dart';
import 'package:trip_buddy/Screens/TripDetails/Bills.dart';
import 'package:trip_buddy/Screens/TripDetails/EditTripDetails.dart';
import 'package:trip_buddy/Services/DataService.dart';
import 'package:trip_buddy/ViewModels/TripViewModel.dart';


class TripDetails extends StatelessWidget {

  final String tripId;
  TripDetails({ Key? key , required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TripViewModel>(
      init: TripViewModel(),
      builder:(data){

        var tripData;
        data.getTrips().forEach((element) {
          if(element.id == tripId){
            tripData = element;
          }
        });

        return tripData != null ? Scaffold(
          appBar: AppBar(
            title: Text(tripData['name']),
            actions: [

              PopupMenuButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                itemBuilder: (_) => [

                  PopupMenuItem(
                    child: Text('Edit'),
                    value: 'edit',
                  ),

                  if(tripData['admin'] == FirebaseAuth.instance.currentUser!.email)
                  PopupMenuItem(
                    child: Text('Delete'),
                    value: 'delete',
                  ) 
                ],
                onSelected: (value){
                  value == 'delete' 
                  ? DataService().deleteTrip(tripId) 
                  : Get.to(() => EditTripDetails(tripId: tripId));
                } 
              ),

              
            ],
          ),

          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: TabBar(

                unselectedLabelColor: Colors.black,
                labelColor: Colors.blue,
                indicatorWeight: 1,
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tab(
                      text: 'Expenses'
                    ),
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tab(
                      text: 'Total'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tab(
                      text: 'Bills'
                    ),
                  ),
                ]
              ),
              body: TabBarView(
                children: [
                  Expenses(tripId: tripId),
                  Totals(tripId: tripId),
                  Bills(tripId:tripId)
                ],
              ),

              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => Get.to(() => AddExpense(buddies: tripData['buddies'], tripId: tripId))
              ),
              
            ),
          )
        ) : Scaffold(body: Center(child: CircularProgressIndicator()));
      }  
    );
  }
}