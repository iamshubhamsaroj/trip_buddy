// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:provider/provider.dart';
// import 'package:trip_buddy/screens/Auth/test.dart';

// class AddMember extends StatefulWidget {
//   @override
//   _AddMemberState createState() => _AddMemberState();
// }

// class _AddMemberState extends State<AddMember> {
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
//     bool isSearching = searchController.text.isNotEmpty;
//     List names = Provider.of<ContactDetails>(context).getName();
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           title: Text("Add People"),
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
//             Expanded(
//               child: SafeArea(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: isSearching == true
//                         ? contactsFiltered.length
//                         : contacts.length,
//                     itemBuilder: (context, index) {
//                       Contact contact = isSearching == true
//                           ? contactsFiltered[index]
//                           : contacts[index];

//                       return ListTile(
                  
//                           title: Text(contact.displayName),
                       
//                           subtitle: Text(contact.phones.elementAt(0).value),
//                           leading: (contact.avatar != null &&
//                                   contact.avatar.length > 0)
//                               ? CircleAvatar(
//                                   backgroundImage: MemoryImage(contact.avatar),
//                                 )
//                               : CircleAvatar(
//                                   child: Text(contact.initials()),
//                                 ));
                                
//                     }),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
