import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_buddy/Services/DataService.dart';

Future addBuddy(String tripId){

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return Get.bottomSheet(
    Container(
      
      height: 350,
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
              'Add new buddy',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: Text('Name',
                        style: GoogleFonts.openSans(
                          textStyle:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: nameController,
                      validator: (val) {
                        if (val != null)
                          return val.isEmpty ? 'Please enter a name' : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: Text('Email',
                        style: GoogleFonts.openSans(
                          textStyle:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: TextFormField(
                      controller: emailController,
                      validator: (val) {
                        if (val != null)
                          return val.isEmpty ? 'Please enter a email' : null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,15,8,8),
                    child: ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          DataService().addNewBuddy(
                            tripId, nameController.text, emailController.text);
                        }
                      },
                      child: Text('Save')
                    ),
                  )
                  
                ],
              ),
            ),
          ),
        ] 
      ),
    ),
  );
}



















