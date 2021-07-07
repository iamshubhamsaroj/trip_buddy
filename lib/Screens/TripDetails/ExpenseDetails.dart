import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';

class ExpenseDetails extends StatelessWidget {

  final String expenseName;
  final List buddies;

  ExpenseDetails({ Key? key, required this.expenseName, required this.buddies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expenseName),
        centerTitle: true,
      ),
      body: GetBuilder<ExpenseViewModel>(
        init: ExpenseViewModel(),
        builder: (data) {

          List<Map<String,dynamic>> detailsList = data.getBuddyDetails();

          return ListView.builder(
            itemCount: detailsList.length,
            itemBuilder: (context,index) {
      
            
              return Card(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Column(
                  children: [
      
                    rowData('name: ', detailsList[index]['name']),
                    rowData('email: ', detailsList[index]['email']),
                    rowData('Total amount paid: ', detailsList[index]['paid'].toString()),
                    rowData('Total share: ', detailsList[index]['split'].toString()),
                    rowData('Total amount owe: ', detailsList[index]['owe'].toString()),

                    detailsList[index]['oweTo'].length > 0 ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Money owe to: '),
                          Column(
                            children: List.generate(detailsList[index]['oweTo'].length, (oweindex){

                              String name = buddies.where((e) => e['email'] == detailsList[index]['oweTo'][oweindex]['email']).first['name'];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: rowData(name, detailsList[index]['oweTo'][oweindex]['amount'].toString()),
                              );
                            }),
                          ),
                        ],
                      ),
                    ) : Container(),

                    rowData('Total amount get: ', detailsList[index]['get'].toString()),

                    detailsList[index]['getFrom'].length > 0 ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Money get from: '),
                          Column(
                            children: List.generate(detailsList[index]['getFrom'].length, (getindex){

                              String name = buddies.where((e) => e['email'] == detailsList[index]['getFrom'][getindex]['email']).first['name'];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: rowData(name,detailsList[index]['getFrom'][getindex]['amount'].toString()),
                              );
                            }),
                          ),
                        ],
                      ),
                    ) : Container()              
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