import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_buddy/Services/DataService.dart';
import 'package:contacts_service/contacts_service.dart';

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

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  late Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = _contacts.elementAt(index);
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
          leading:  CircleAvatar(
                  child: Text(contact.initials()),
                  backgroundColor: Theme.of(context).accentColor,
                ),
          title: Text(contact.displayName ?? ''),
          //This can be further expanded to showing contacts detail
          // onPressed().
        );
      },
    ));
  }
}
