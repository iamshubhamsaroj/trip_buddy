import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/Widgets/SnackBarWidget.dart';

class DataService extends GetxController{

  User user  = FirebaseAuth.instance.currentUser!;
  
  
  final tripListStream =  List<QueryDocumentSnapshot>.empty(growable: true).obs;
  final expenseListStream = Map().obs;


  @override
  void onInit(){
    super.onInit();
    tripListStream.bindStream(getTrips());
  }


  Stream<List<QueryDocumentSnapshot>> getTrips() async*{

    
    yield* FirebaseFirestore.instance.collection('Trips')
    .where('members', arrayContains: user.email).orderBy('lastTS', descending: true).snapshots().map((event) => event.docs);
  }

  void createNewTrip(String tripName) async{

    try{
      await FirebaseFirestore.instance.collection('Trips').doc().set({
        'name' : tripName,
        'buddies' : [{'email': user.email, 'name' : user.displayName}],
        'members' : [user.email],
        'expenses' : [],
        'lastTS' : Timestamp.now(),
        'admin' : user.email
      });

      Get.back();
      snackBar('New trip added successfully');

    }catch(e){
      Get.back();
      snackBar('Something went wrong. Try again.');
    }
  }

  deleteTrip(String tripId)async{
    try{
      await FirebaseFirestore.instance.collection('Trips').doc(tripId).delete();
      Get.back();
      Get.back();
      snackBar('Trip deleted successfully');
    }catch(e){
      Get.back();
      Get.back();
      snackBar('Something went wrong. Try again.');
    }
  }

  void addNewBuddy( String tripId, String name, String email)async{
    try{

      await FirebaseFirestore.instance.collection('Trips').doc(tripId).update({
        'buddies' : FieldValue.arrayUnion([{'name' : name, 'email': email}]),
        'members' : FieldValue.arrayUnion([email])
      });

      Get.back();
      snackBar('Your new buddy added successfully');

    }catch(e){
      Get.back();
      snackBar('Something went wrong. Try again.');
    }
  }

  void addExpense(String tripId, String desc, int amount, String date, List paidBy, List splitBy, List billList)async{

    try{
      List<Map<String, dynamic>> paidByList = [];
      List<Map<String, dynamic>> splitByList = [];
      List billUrlList = [];
      String urldoc;

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

      if(billList.isNotEmpty){
        for (int i = 0; i < billList.length; i++) {

          UploadTask uploadTask1 = FirebaseStorage.instance.ref().child("Trips/$tripId/expenses/$desc/Bill ${i+1}").putFile(File(billList[i]));
          TaskSnapshot downloadUrl1 = (await uploadTask1);
          urldoc = (await downloadUrl1.ref.getDownloadURL());
          billUrlList.add(urldoc);
        }
      }


      await FirebaseFirestore.instance.collection('Trips').doc(tripId).update(
        {
          'expenses' : FieldValue.arrayUnion([{ 
            'description' : desc,
            'amount': amount,
            'date' : date,
            'paidBy' : paidByList,
            'splitBy' : splitByList,
            'bill' : billUrlList
          }]),
          'lastTS' : Timestamp.now()
        }
      );

      Get.back();
      Get.back();
      snackBar('Expense added successfully');

    }catch(e){
      Get.back();
      snackBar('Something went wrong. Try again.');
    }
  }

  deleteExpenses(String tripId, Map data)async{
    try{
      await FirebaseFirestore.instance.collection('Trips').doc(tripId).update(
        {
          'expenses' : FieldValue.arrayRemove([data]),
          'lastTS' : Timestamp.now()
        }
      );
      Get.back();
      snackBar('Expense deleted successfully');
    }catch(e){
      Get.back();
      snackBar('Something went wrong. Try again.');

    }
  }

  Stream<Map> getExpenses(String tripId) async*{
    yield* FirebaseFirestore.instance.collection('Trips').doc(tripId).snapshots().map((event) {
      if(event.data() != null){
        return event.data()!;
      } else return {};
    }); 
    
  }
}