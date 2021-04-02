import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MenuApp.dart';
import 'package:esi_absence/Views/MesModules.dart';
class HomepageScreen extends StatelessWidget {
  static String id = 'homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuApp(),
     body:  MesModules(),
    );
  }
}
