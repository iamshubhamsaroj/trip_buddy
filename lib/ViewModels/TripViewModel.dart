import 'package:get/get.dart';
import 'package:trip_buddy/Services/DataService.dart';

class TripViewModel extends GetxController{

  final tripListStreamData = Get.put(DataService()); 

  List tripList = [];

  List getTrips(){
    tripList.clear();
    tripListStreamData.tripListStream.forEach((document) {
      tripList.add(document);
    });

    return tripList;
  }
}