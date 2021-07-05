// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:trip_buddy/screens/addmember.dart';

// class CreateGroup extends StatefulWidget {
//   @override
//   _CreateGroupState createState() => _CreateGroupState();
// }

// class _CreateGroupState extends State<CreateGroup> {
//   List<bool> isSelected = [true, false, false, false];
//   File _image;
//   final picker = ImagePicker();

//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("No image selected.");
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           title: Text("Create group"),
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               })),
//       body: Container(
//           child: Column(
//         children: [
//           Row(children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(left: 10, right: 5, top: 15, bottom: 50),
//             ),
//             Text(
//               "Choose Group picture",
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 100, right: 0),
//               child: Expanded(
//                 child: ElevatedButton(
//                   child: Text("upload picture"),
//                   onPressed: getImage,
//                 ),
//               ),
//             ),
//           ]),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 ToggleButtons(
//                   borderRadius: BorderRadius.circular(50),
//                   isSelected: isSelected,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.grey,
//                         backgroundImage: _image != null
//                             ? FileImage(_image)
//                             : AssetImage("lib/images/flatmates.png"),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: CircleAvatar(
//                           backgroundColor: Colors.grey,
//                           radius: 40,
//                           backgroundImage: AssetImage("lib/images/office.png")),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: CircleAvatar(
//                           backgroundColor: Colors.grey,
//                           radius: 40,
//                           backgroundImage:
//                               AssetImage("lib/images/Friends.png")),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 5, bottom: 5, right: 5),
//                       child: CircleAvatar(
//                           backgroundColor: Colors.grey,
//                           radius: 40,
//                           backgroundImage: AssetImage("lib/images/Trip.jpg")),
//                     ),
//                   ],
//                   selectedColor: Colors.red,
//                   fillColor: Colors.lightBlue.shade900,
//                   onPressed: (int newIndex) {
//                     setState(() {
//                       for (int index = 0; index < isSelected.length; index++) {
//                         if (index == newIndex) {
//                           isSelected[index] = true;
//                         } else {
//                           isSelected[index] = false;
//                         }
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: <Widget>[],
//           ),
//           Row(children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(left: 10, right: 5, top: 15, bottom: 50),
//             ),
//             Text(
//               "Group name",
//             ),
//           ]),
//           Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 13, left: 13, top: 0),
//                   child: TextField(
//                       decoration: InputDecoration(
//                     labelText: "Enter group name",
//                     border: OutlineInputBorder(
//                         borderSide: new BorderSide(
//                             color: Theme.of(context).primaryColor)),
//                   )),
//                 ),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding:
//                     EdgeInsets.only(left: 10, right: 5, top: 50, bottom: 50),
//                 child: Text("Group members"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 130, right: 0, top: 10),
//                 child: Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => AddMember()));
//                     },
//                     child: Text("Add Member"),
//                   ),
//                 ),
//               )
//             ],
//           ),
          
//         ],
//       )),
//     );
//   }
// }
