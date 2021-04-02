import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_absence/Views/DetailSeance.dart';
import 'package:flutter/material.dart';



class DetailGroupe extends StatefulWidget {
 
 final String id;
  final String idSeance;
   final String idmodule;
   DetailGroupe(this.id, this.idSeance,  this.idmodule);
   
 
  @override
  _DetailGroupeState createState() => _DetailGroupeState(this.id, this.idSeance, this.idmodule);
    
}

class _DetailGroupeState extends State<DetailGroupe> {

 final String id;
  final String idSeance;
   final String idmodule;

 _DetailGroupeState(this.id, this.idSeance,  this.idmodule);
 
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
                  return DetailSeance(idSeance,idmodule);
                }));
                },
                ),),
            centerTitle: true,
            title: Text(
               'List des etudiants',
              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ),
            ),),

       body:Container(
       child:StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Modules')
                    .doc(idmodule)
                    .collection('Seances').doc(idSeance)
                    .collection('Groupes')
                    .doc(id)
                    .collection('Etudiants')
                    .snapshots(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),
             
             );
            default:
              return new ListView(
                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Card(
                    
                      child:  ListTile(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
        content: Text("Voulez vous marquer cet etudiant Present?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Present"),
            onPressed: () {
              //marquerla presence de l'etudiant
              FirebaseFirestore.instance
              .collection('Modules')
                    .doc(idmodule)
                    .collection('Seances').doc(idSeance)
                    .collection('Groupes')
                    .doc(id)
                    .collection('Etudiants')
                    .doc(document.id)
                    .update({'Presencee': true});
             //marquer  que la seance a ete faite
              FirebaseFirestore.instance
              .collection('Modules')
                    .doc(idmodule)
                    .collection('Seances').doc(idSeance).update({'etat':false});    

              Navigator.of(context).pop();
            },
          ),
 
          
 
           FlatButton(
            child: Text("Annuler"),
            onPressed: () {
      
               Navigator.of(context).pop();
            },
          ),
        ],
      );
      },
      );
                        },
                        title: new Text("Nom  : " +document['Nom'] ),
                        subtitle: new Text("Prenom  :" + document['Prenom']),
                      
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