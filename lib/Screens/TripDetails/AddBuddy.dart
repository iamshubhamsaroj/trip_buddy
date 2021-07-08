import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_buddy/Services/DataService.dart';

class AddBuddy extends StatelessWidget {
  final String tripId;
  AddBuddy({Key? key, required this.tripId}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a buddy'),
      ),
      body: Form(
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
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: Text('Or',
                    style: GoogleFonts.openSans(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Text('Your contacts',
                  style: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  )),
            ),
            Center(
              child: ElevatedButton(
                  child: Icon(Icons.check),
                  onPressed: () {
                    DataService().addNewBuddy(
                        tripId, nameController.text, emailController.text);
                  }),
            )
          ],
        ),
      ),
    );
  }
}