import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController{

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

class SplitByController extends GetxController {

  List amount = [];
  bool isEqual = true;

  getSplitBy(){
    return amount;
  }

  setSplitBy(List data){
    amount.clear();
    for(int i =0 ; i<data.length; i++){
      amount.add({
        'name' : data[i]['name'],
        'email' : data[i]['email'],
        'amount' : data[i]['amount']
      });
    }
    update();
  }

  getIsEqual(){
    return isEqual;
  }

  setIsEqual(bool data){
    isEqual = data;
    update();
  }
}

class AmountSum extends GetxController {
  var sum = 0;

  getAmount() {
    return sum;
  }

  setAmount(List data) {
    sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum = sum + int.parse(data[i].text ?? 0);
    }
    update();
  }
}
