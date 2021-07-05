 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_buddy/Services/AuthService.dart';

Widget buildDrawer() {

  User user = FirebaseAuth.instance.currentUser!;

  return ListView(
    children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(user.displayName!),
        accountEmail: Text(user.email!),
        currentAccountPicture:
            CircleAvatar(backgroundImage: NetworkImage(user.photoURL!)),
      ),
      ListTile(
        title: Text('Sign Out'),
        leading: Icon(Icons.exit_to_app),
        onTap: () async {
          await AuthService().signOut();
        },
      ),
    ]
  );
}