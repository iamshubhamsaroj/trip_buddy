import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';
import 'package:trip_buddy/Widgets/Preview.dart';

class Bills extends StatelessWidget {

  final String tripId;
  Bills({ Key? key, required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseViewModel>(
      init: ExpenseViewModel(),
      builder: (data){

        List expenses = data.getExpenses(tripId)['expenses'];

        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context,index){


            List bills = expenses[index]['bill'];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(expenses[index]['description']),
                    ),
                    bills.isNotEmpty ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(bills.length, (index){
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              title: Text('Bill ${index + 1}'),
                              onTap: (){
                                Get.to(() => Preview('Bill ${index + 1}',null,bills[index]));
                              },
                            ),
                          );
                        })
                         
                      ),
                    )
                    : Text('No bills')
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}