import 'package:get/get.dart';

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
