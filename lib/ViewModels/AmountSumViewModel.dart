import 'package:get/get.dart';

class AmountSum extends GetxController {
  var sum = 0.0;

  getAmount() {
    return double.parse(sum.toStringAsFixed(2));
  }

  setAmount(List data) {
    sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum = sum + double.parse(data[i].text ?? 0);
    }
    update();
  }
}
