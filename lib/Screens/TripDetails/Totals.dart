import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';

class Totals extends StatelessWidget {

  final String tripId;
  Totals({ Key? key, required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ExpenseViewModel>(
        init: ExpenseViewModel(),
        builder: (data) {

          List buddies = data.getExpenses(tripId)['buddies'];

          return ListView.builder(
            itemCount: buddies.length,
            itemBuilder: (context,index){

              num shareAmount  = 0;
              num spendAmount = 0;
              num oweAmount = 0;   
              num getAmount = 0;

              List expenses  = data.getExpenses(tripId)['expenses'];

              expenses.forEach((element) {

                data.setBuddyDetails(buddies, element['paidBy'], element['splitBy']);
                List<Map<String,dynamic>> detailsList = data.getBuddyDetails();

                detailsList.forEach((detailsListElement) {
                  if(detailsListElement['email'] == buddies[index]['email']){

                    spendAmount = spendAmount + detailsListElement['paid'];

                    shareAmount = shareAmount + detailsListElement['split'];

                    oweAmount = oweAmount + detailsListElement['owe'];

                    getAmount = getAmount + detailsListElement['get'];
                  }
                });

              });


              return Card(
                child: Column(
                  children: [
                    rowData('name: ', buddies[index]['name']),
                    rowData('email: ', buddies[index]['email']),
                    rowData('Total amount spend: ', spendAmount.toString()),
                    rowData('Total share: ', shareAmount.toString()),
                    rowData('Total amount owe: ', oweAmount.toString()),
                    rowData('Total amount get: ', getAmount.toString()),
                    
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }

  Widget rowData(String text1, String text2){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text1),
        ),

        Flexible(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text2 == [].toString() ? 'N/a' : text2),
        ))
      ],
    );
  }
}