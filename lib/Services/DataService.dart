import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DataService extends GetxController{

  User user  = FirebaseAuth.instance.currentUser!;
  
  final tripListStream =  List<QueryDocumentSnapshot>.empty(growable: true).obs;


  @override
  void onInit(){
    super.onInit();
    tripListStream.bindStream(getTrips());
  }

  Stream<List<QueryDocumentSnapshot>> getTrips() async*{

    var query = {
      'email' : user.email,
      'name' : user.displayName
    };

    yield* FirebaseFirestore.instance.collection('Trips')
    .where('buddies', arrayContains: query).orderBy('lastTS', descending: true).snapshots().map((event) => event.docs);
  }

  void createNewTrip(String tripName) async{

    try{
      await FirebaseFirestore.instance.collection('Trips').doc().set({
        'name' : tripName,
        'buddies' : [{'email': user.email, 'name' : user.displayName}],
        'expenses' : [],
        'lastTS' : Timestamp.now()
      });

    }catch(e){
      Get.showSnackbar(
        GetBar(
          message: 'Something went wrong. Try again.',
          duration: Duration(seconds: 3)
        )
      );
    }
  }

  void addNewBuddy( String tripId, String name, String email)async{
    await FirebaseFirestore.instance.collection('Trips').doc(tripId).update({
      'buddies' : FieldValue.arrayUnion([{'name' : name, 'email': email}])
    });
  }

  void addExpense(String tripId, String desc, String amount, String date, List paidBy, List splitBy)async{

    List<Map<String, dynamic>> paidByList = [];
    List<Map<String, dynamic>> splitByList = [];

    for(int i =0 ; i< paidBy.length; i++){
      paidByList.add({
        'name': paidBy[i]['name'],
        'email': paidBy[i]['email'],
        'amount': paidBy[i]['amount'],
      });
    }

    for(int i =0 ; i< splitBy.length; i++){
      splitByList.add({
        'name': splitBy[i]['name'],
        'email': splitBy[i]['email'],
        'amount': splitBy[i]['amount'],
      });
    }

    await FirebaseFirestore.instance.collection('Trips').doc(tripId).update({
      'expenses' : FieldValue.arrayUnion([{ 
        'description' : desc,
        'amount': amount,
        'date' : date,
        'paidBy' : paidByList,
        'splitBy' : splitByList
      }]),
      'lastTS' : Timestamp.now()
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getExpenses (String tripId) async*{
    yield* FirebaseFirestore.instance.collection('Trips').doc(tripId).snapshots();
    
  }

}