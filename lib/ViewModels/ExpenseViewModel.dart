import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/TripViewModel.dart';

class ExpenseViewModel extends GetxController{

  var expenses;
  List<Map<String,dynamic>> buddyDetails = [];
  List<String> billList = [];


  getExpenses(String tripId){
    return expenses = Get.put(TripViewModel()).getTrips().where((e) => e.id == tripId).first;
    
  }

  List<Map<String,dynamic>> getBuddyDetails(){
    return buddyDetails;
  }

  setBuddyDetails(List buddies, List paidByList, List splitByList){

    buddyDetails.clear();

    buddies.forEach(
      (buddy) {

        //creating buddyDetails list for each buddy


        buddyDetails.add(
          {                    //creating empty Map for this buddy
            'name' : buddy['name'],
            'email': buddy['email'],
            'paid': 0.0,
            'split': 0.0,
            'owe' : 0.0,
            'get' : 0.0,
            'oweTo' : [],
            'getFrom' : []
          }
        );

        paidByList.forEach(
          (paidE){
            
            if(paidE['email'] == buddy['email']){

              int index = buddyDetails.indexWhere((element) => element['email'] == paidE['email']);

              buddyDetails[index]['paid'] = paidE['amount'];    //adding paid amount of this buddy
            }
          }
        );

        splitByList.forEach(
          (splitE) {

            if(splitE['email'] == buddy['email']){
              
              int index = buddyDetails.indexWhere((element) => element['email'] == splitE['email']);

              buddyDetails[index]['split'] = splitE['amount'];     //adding split amount of this buddy

              if((buddyDetails[index]['paid'] - splitE['amount']).isNegative){

                //if paid - split is neg means this buddy have paid less than his share so he owes money to others

                buddyDetails[index]['owe'] = double.parse((buddyDetails[index]['paid'] - splitE['amount']).abs().toStringAsFixed(2));  //adding owe amount of this buddy

              }

              if(!(buddyDetails[index]['paid'] - splitE['amount']).isNegative){

                //if paid - split is pos means this buddy have paid more than his share so he will get money from others

                buddyDetails[index]['get'] = double.parse((buddyDetails[index]['paid'] - splitE['amount']).abs().toStringAsFixed(2));    //adding get amount of this buddy
                
              }
            }
          }
        );
      }
    );

    for(int i = 0; i < buddyDetails.length; i++){   //buddyDetails is a list of details of each buddy
      
      //for every buddy

      if(buddyDetails[i]['get'] > 0){

        //if get amount is > than 0 means this buddy will get money from others

        buddyDetails.forEach(
          (element) {
  
            if(element['split'] >  element['paid']){
              
              //this buddy will get money from those buddies who have paid less than their share

              buddyDetails[i]['getFrom'].add(
                {        //adding email and amount of that buddy
                  'email' : element['email'],
                  'amount' : element['owe'] > buddyDetails[i]['get'] ? buddyDetails[i]['get'] : element['owe']
                }
              );
            }
          }
        );
      }

      if(buddyDetails[i]['owe'] > 0){

        //if owe amount is > than 0 means this buddy will have to pay to others

        buddyDetails.forEach(
          (element) {

            if( element['split'] <  element['paid']){

              //this buddy owes money to those buddies who have paid more than their share

              buddyDetails[i]['oweTo'].add(
                {        //adding email and amount of that buddy
                  'email' : element['email'],
                  'amount' : element['get'] > buddyDetails[i]['owe'] ? buddyDetails[i]['owe'] : element['get']
                }
              );
            }
          }
        );
      }
    }
  }


  setBillList(var data){
    billList.add(data);
    update();
  }

  getBillList(){
    return billList;
  }
}
