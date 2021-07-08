import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/Screens/Expense/ExpenseDetails.dart';
import 'package:trip_buddy/Services/DataService.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';

class Expenses extends StatelessWidget {

  final String tripId;
  Expenses({ Key? key, required this.tripId }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ExpenseViewModel>(
      init: ExpenseViewModel(),
      builder: (data){
        
        List expenses  = data.getExpenses(tripId)['expenses'];
        List buddies = data.getExpenses(tripId)['buddies'];

        return expenses.isNotEmpty ? ListView.builder(
          itemCount: expenses.length,
          itemBuilder:(context,index) {

            List paidByList = expenses[index]['paidBy'];
            List splitByList = expenses[index]['splitBy'];     

            return InkWell(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: PopupMenuButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          )
                        ],
                        onSelected: (value) => DataService().deleteExpenses(tripId, expenses[index])
                      )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Description: '),
                          Text(expenses[index]['description']),
                        ],
                      ), 
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Amount: '),
                          Text(expenses[index]['amount'].toString()),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Date: '),
                          Text(expenses[index]['date']),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('paidBy: '),
                          Text(expenses[index]['paidBy'][0]['name']),
                        ],
                      ),
                    ),

                    Divider()
                  ],
                ),
              ),

              onTap: (){
                data.setBuddyDetails(buddies, paidByList, splitByList);
                Get.to(() => ExpenseDetails(expenseName: expenses[index]['description'],buddies: buddies,));
              },
            );
          }
        ) : Center(child: Text('No expense added'));
      }
    );
  }
}