// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:trip_buddy/screens/creategroup.dart';

// class AddTrip extends StatefulWidget {
//   @override
//   _AddTripState createState() => _AddTripState();
// }

// class _AddTripState extends State<AddTrip> {
//   List<Contact> contacts = [];
//   List<Contact> contactsFiltered = [];
//   TextEditingController searchController = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     getAllContacts();
//     searchController.addListener(() {
//       filterContacts();
//     });
//   }

//   getAllContacts() async {
//     Iterable<Contact> _contacts =
//         (await ContactsService.getContacts()).toList();
//     setState(() {
//       contacts = _contacts;
//     });
//   }

//   filterContacts() {
//     List<Contact> _contacts = [];
//     _contacts.addAll(contacts);
//     if (searchController.text.isNotEmpty) {
//       _contacts.retainWhere((contact) {
//         String searchTerm = searchController.text.toLowerCase();
//         String contactName = contact.displayName.toLowerCase();
//         return contactName.contains(searchTerm);
//       });

//       setState(() {
//         contactsFiltered = _contacts;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
    
  
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Theme.of(context).appBarTheme.color,
//           centerTitle: true,
//           title: Text("Add Trip"),
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               })),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                     labelText: "Search contacts or phone number",
//                     border: OutlineInputBorder(
//                         borderSide: new BorderSide(
//                             color: Theme.of(context).primaryColor)),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Theme.of(context).primaryColor,
                      
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => CreateGroup()));
//         },
//         label: Text('Create Group'),
//         icon: Icon(Icons.add),
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.white,
//       ),
//     );
//   }
// }
