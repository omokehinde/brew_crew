import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService(); 

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().brews,
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: AppBar(
            title: Text("Brew Crew"),
            backgroundColor: Colors.brown[400],
            elevation: 0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("Logout"),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        body: BrewList(),
      ),
    );
  }
}