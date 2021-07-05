import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_buddy/Services/DataService.dart';

class Expenses extends StatelessWidget {

  final String tripId;
  Expenses({ Key? key, required this.tripId }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(

      stream: DataService().getExpenses(tripId),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if(snapshot.data != null)
        return ListView.builder(
          itemCount: snapshot.data!['expenses'].length,
          itemBuilder: (context,index){

            var data =  snapshot.data!['expenses'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Description: '),
                      Text(data[index]['description']),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Amount: '),
                      Text(data[index]['amount']),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Date: '),
                      Text(data[index]['date']),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('paidBy: '),
                      Text(data[index]['paidBy'][0]['name']),
                    ],
                  ),
                ),

                Divider()

              ],
            );
          }
        );
        else return Container();
      }
    );
  }
}