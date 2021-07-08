 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_buddy/Services/AuthService.dart';

Widget buildDrawer() {

  User user = FirebaseAuth.instance.currentUser!;

  return ListView(
    children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(user.displayName!,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        


        ),
        ),
        accountEmail: Text(user.email!),
        currentAccountPicture:
            CircleAvatar(backgroundImage: NetworkImage(user.photoURL!),
            ),
      ),
      ListTile(
        
        title: Text('Sign out',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),),
        leading: Icon(Icons.exit_to_app),
        onTap: () async {
          await AuthService().signOut();
        },
      ),
    ]
  );
}