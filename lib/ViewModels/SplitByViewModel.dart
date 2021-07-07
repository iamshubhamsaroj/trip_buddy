import 'package:get/get.dart';

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
        'amount' : (data[i]['amount'])
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