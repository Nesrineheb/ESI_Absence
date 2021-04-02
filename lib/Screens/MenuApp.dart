import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_absence/globals.dart';
import 'package:flutter/material.dart';

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                padding: EdgeInsets.all(100),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Container(),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.blueAccent,
                  size: 40,
                ),
                title: Text(
                  ' Mes modules',
                  style: TextStyle(
                    color: Color.fromRGBO(64, 75, 105, 5),
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                  size: 40,
                ),
                title: Text(
                  ' A propos',
                  style: TextStyle(
                    color: Color.fromRGBO(64, 75, 105, 5),
                    fontSize: 18,
                  ),
                ),
                onTap: null,
              ),
              ListTile(
                leading: Icon(
                  Icons.chat,
                  color: Colors.blueAccent,
                  size: 40,
                ),
                title: Text(
                  ' Contactez nous',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(64, 75, 105, 5),
                  ),
                ),
                onTap: () {
                
                },
              ),
              Divider(
                height: 25,
                color: Colors.black45,
              ),
              ListTile(
                leading: Icon(
                  (Icons.arrow_back),
                  color: Colors.blueAccent,
                  size: 40,
                ),
                title: Text(
                  ' Se deconnecter',
                  style: TextStyle(
                    color: Color.fromRGBO(64, 75, 105, 5),
                    fontSize: 18,
                  ),
                ),
                onTap: null,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      //plus tard photo
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       
                        Text(
                           'Nom'
                        ),
                        Text('Prenom'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
