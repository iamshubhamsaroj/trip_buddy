import 'package:flutter/cupertino.dart';

class ContactDetails extends ChangeNotifier {
  final List<String> nameList = [];

  void addName(String name) {
    nameList.add(name);
    notifyListeners();
  }

  List<String> getName() {
    return nameList;
  }
}
