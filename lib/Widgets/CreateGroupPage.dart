import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/Services/DataService.dart';

Future createTripPage() {

  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  return Get.bottomSheet(
    
    Container(
      
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[

          Padding(
            padding: const EdgeInsets.fromLTRB(10,25,10,20),
            child: Text(
              'Create new trip',
              style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: controller,
                decoration: InputDecoration(labelText: 'Trip name'),
                validator: (val ){
                  if(val != null)
                  return val.isEmpty ? 'Please enter Trip name' : null;
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8,15,8,8),
            child: ElevatedButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  DataService().createNewTrip(controller.text);
                }
                Get.back();
              },
              child: Text('Save')
            ),
          )
        ] 
      ),
    ),
  );
}