import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PaidByController extends GetxController{

  String? paidByEmail = FirebaseAuth.instance.currentUser?.email!;
  String? paidByName = FirebaseAuth.instance.currentUser?.displayName!;
  List paidByAmount = [];
  bool isSingle = false;
  List<Map<String,dynamic>> paidByList = [];

  void addPaidBy(List<Map<String, dynamic>> data){

    paidByList.clear();
    for(int i = 0; i< data.length; i++){
      paidByList.add({
        'name' : data[i]['name'],
        'email' : data[i]['email'],
        'amount' : data[i]['amount']
      });
    }
    update();
  }

  getPaidBy(){
    return paidByList;
  }
}