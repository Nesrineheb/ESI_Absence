//import 'dart:html';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:esi_absence/globals.dart' as globals;

import 'package:intl/intl.dart';
import 'package:esi_absence/Views/MesModules.dart';
import 'package:esi_absence/Views/DetailModule.dart';

import 'DetailGroupe.dart';

enum ConfirmOrNot { yes, no }

class DetailSeance extends StatefulWidget {
 final String idmodule;
 final String id;
   DetailSeance(this.id,this.idmodule);

  @override
  _DetailSeanceState createState() => _DetailSeanceState(this.id,idmodule);
    
}

class _DetailSeanceState extends State<DetailSeance> {

   
  
 final String idmodule;

  var id;

 _DetailSeanceState(this.id,this.idmodule);
 
  @override
  Widget build(BuildContext context) {
 
 
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
          
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Builder(
                builder: (context) => IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(34, 43, 69, 1),
                ),
                
                onPressed: (){
                 Navigator.push(context,
              MaterialPageRoute<void>(
                builder:(BuildContext context) { 
                  return DetailModule(idmodule);
                }));
                },
                ),),
            centerTitle: true,
            title: Text(
                 'Mes groupes',

              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ),
            ),),

       body:Container(
       child:StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Modules')
                    .doc(idmodule)
                    .collection('Seances').doc(id)
                    .collection('Groupes')
                    .snapshots(),
                    
    
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
            default:
              return new ListView(

                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context,
                         MaterialPageRoute<void>(
                         builder:(BuildContext context) { 
                         return 
                         DetailGroupe(document.id,id,idmodule);
                         }));
                         // ignore: unnecessary_statements
                          print("ani henaaaaaa ouvert");
                        
                        },
                        title: new Text("Nom : " +document['Nom']),
                        //subtitle: new Text("ID :" + document['Nom']),
                      
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
       ),
      ),

          
               
         
        

   
       
    );
  }
}


  

 