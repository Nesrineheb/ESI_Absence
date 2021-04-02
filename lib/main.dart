
import 'package:esi_absence/Views/MesModules.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:esi_absence/Screens/Homepage.dart';
import 'package:esi_absence/Screens/SignIn.dart';



void main() async{
    WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SignInScreen.id,
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        HomepageScreen.id: (context) => HomepageScreen(),
         
         '/MesModules': (_) => MesModules(),
      },
    );
  }
}




