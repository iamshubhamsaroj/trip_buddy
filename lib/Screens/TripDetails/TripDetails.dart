import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/Screens/Expense/AddExpense.dart';
import 'package:trip_buddy/Screens/TripDetails/Expenses.dart';
import 'package:trip_buddy/Screens/TripDetails/Balances.dart';
import 'package:trip_buddy/Screens/TripDetails/Totals.dart';
import 'package:trip_buddy/Screens/TripDetails/Bills.dart';
import 'package:trip_buddy/Screens/TripDetails/EditTripDetails.dart';
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

        return Scaffold(
          appBar: AppBar(
            title: Text(tripData['name']),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    Get.to(() => EditTripDetails(tripId: tripId,));
                  },
                ),
              )
            ],
          ),

          body: DefaultTabController(
            length: 4,
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
                      text: 'Balances'
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
                  Balances(),
                  Totals(),
                  Bills()
                ],
              ),

              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => Get.to(() => AddExpense(buddies: tripData['buddies'], tripId: tripId))
              ),
              
            ),
          )
        );
      }  
    );
  }
}