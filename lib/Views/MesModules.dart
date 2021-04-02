
import 'dart:ui';
import 'package:esi_absence/Screens/MenuApp.dart';
import 'package:esi_absence/Views/DetailModule.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:esi_absence/globals.dart' as globals;

class MesModules extends StatefulWidget {
  @override
  _MesModulesState createState() => _MesModulesState();
}

class _MesModulesState extends State<MesModules> {
  String date = '';
  String dateReglement = '';

  @override
  Widget build(BuildContext context) {
    return  
   DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: MenuApp(),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color.fromRGBO(34, 43, 69, 1),
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            title: Text(
              "Mes Modules",
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
                  text:"Actifs" ,
                ),
                Tab(
                  text: "Fermes", //'FERME',
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

    );
  }
}

Widget actifSection() {  
 
   final String iduser=globals.idUser;
   print(iduser);
    
return StreamBuilder<QuerySnapshot>(
        stream:  Firestore.instance.collection('Modules')
                 .where("ENSs", arrayContains: iduser)
                 .where('etat', isEqualTo: true)
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
                        
                        onTap: (){ Navigator.push(context,
                         MaterialPageRoute<void>(
                         builder:(BuildContext context) { 
                         return 
                         DetailModule(document.id);
                         }));
                         // ignore: unnecessary_statements
                          print("ani henaaaaaa ouvert");
                        
                        },
                        title: new Text("Nom du module : " + document['Nom']),
                        subtitle: new Text(" " + document['description']),
                        
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
    CollectionReference modules = FirebaseFirestore.instance.collection('Modules');
return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Modules')
                 .where("ENSs", arrayContains: globals.idUser)
                 .where('etat', isEqualTo: false)
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
                         DetailModule(document.id);
                         }));
                         // ignore: unnecessary_statements
                          print("ani henaaaaaa fermee");},
                          title: new Text("Nom du module " + document['Nom']),
                          subtitle: new Text("description du module " + document['description']),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                        }
                      },
                    );
                     
                   
              }
              
              setState(Null Function() param0) {
}




/*  showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Update Dilaog"),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nom: ", textAlign: TextAlign.start,),
                                      TextField(
                                        
                                        decoration: InputDecoration(
                                          hintText:  document['Nom'],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("description: "),
                                      ),
                                      TextField(
                                        
                                        decoration: InputDecoration(
                                          hintText:  document['description'],

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