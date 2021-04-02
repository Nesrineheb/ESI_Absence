//import 'dart:html';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_absence/Views/DetailSeance.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:esi_absence/globals.dart' as globals;

import 'package:intl/intl.dart';
import 'package:esi_absence/Views/MesModules.dart';
enum ConfirmOrNot { yes, no }

class DetailModule extends StatefulWidget {
 
 final String id;
   DetailModule(this.id);
   
 // DetailModule(this.date, this.nom,this.description, this.etat);
  @override
  _DetailModuleState createState() => _DetailModuleState(this.id);
    
}

class _DetailModuleState extends State<DetailModule> {
 // final String date, nom, description;
  
  //final bool etat;
   
  
 final String id;

 _DetailModuleState(this.id);
 
  @override
  Widget build(BuildContext context) {
    CollectionReference modules = FirebaseFirestore.instance.collection('Modules');
    return  DefaultTabController(
        length: 2,
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
                  Navigator.of(context).pushNamed('/MesModules');
                },
                ),),
            centerTitle: true,
            title: Text(
            'List des seances',
              //'Mes Signalements',
              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ), 
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorPadding: EdgeInsets.only(left: 20, right: 20),
              indicatorWeight: 2,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text:"En cours" ,
                ),
                Tab(
                  text: "Finis", //'FERME',
                ),
              ],
            ),
            ),
        body: TabBarView(
            children: [
              actifSection() ,
              fermeSection()  ,
            ],
          ),
       

      ),

          
               
         
        

        //Nouvelle declaration
       
    );
  }

Widget actifSection() {  
 
   final String iduser=globals.idUser;
   print(iduser);
    
return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Modules')
               .doc(id)
               .collection('Seances').where('ENS',isEqualTo:globals.idUser).where('etat',isEqualTo:true)
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
                         DetailSeance(document.id,id);
                         }));
                         // ignore: unnecessary_statements
                          print("ani henaaaaaa ouvert");
                        

                        },
                      
                        title: new Text("Date debut :" +DateTime.fromMicrosecondsSinceEpoch(document['Date debut'].microsecondsSinceEpoch).toString()),
                        
                        subtitle: new Text("Date fin :" + DateTime.fromMicrosecondsSinceEpoch(document['Date fin'].microsecondsSinceEpoch).toString()),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      );
       
     
}




Widget fermeSection() {  
 
   final String iduser=globals.idUser;
   print(iduser);
    
return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Modules')
               .doc(id)
               .collection('Seances').where('ENS',isEqualTo:globals.idUser).where('etat',isEqualTo:false)
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
                         DetailSeance(document.id,id);
                         }));
                         // ignore: unnecessary_statements
                          print("ani henaaaaaa fermeee");
                        },
                        title: new Text("Date debut :" +DateTime.fromMicrosecondsSinceEpoch(document['Date debut'].microsecondsSinceEpoch).toString()),
                        subtitle: new Text("Date fin :" + DateTime.fromMicrosecondsSinceEpoch(document['Date fin'].microsecondsSinceEpoch).toString()),
                 
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      );
       
     
}




}


  

       
     

/*Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Oui, je confirme'),
                            leading: Radio(
                              value: ConfirmOrNot.yes,
                              groupValue: _character,
                              onChanged: (ConfirmOrNot value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Non, le problème persiste'),
                            leading: Radio(
                              value: ConfirmOrNot.no,
                              groupValue: _character,
                              onChanged: (ConfirmOrNot value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )*/









/*
   showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Update Dilaog"),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Date debut: ", textAlign: TextAlign.start,),
                                      TextField(
                                        
                                        decoration: InputDecoration(
                                          hintText: DateTime.fromMicrosecondsSinceEpoch(document['Date debut'].microsecondsSinceEpoch).toString(),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("Date fin: "),
                                      ),
                                      TextField(
                                        
                                        decoration: InputDecoration(
                                          hintText: DateTime.fromMicrosecondsSinceEpoch(document['Date fin'].microsecondsSinceEpoch).toString(),

                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("Salle: "),
                                      ),
                                       TextField(
                                        
                                        decoration: InputDecoration(
                                          hintText:  document['Salle'],
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: RaisedButton(
                                        color: Colors.red,
                                        onPressed: () { Navigator.of(context).pop();},
                                        child: Text("Undo", style: TextStyle(color: Colors.white),),),
                                    ),
                                    // Update Button
                                  


                                  ],
                                );
                              }
                          );*/