import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notebook/add_page.dart';
import 'package:notebook/edit_page.dart';
import 'database_services.dart';

class ShowData extends StatelessWidget {
  const ShowData({Key? key}) : super(key: key);
  navigator(BuildContext context, Widget next) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigator(context, AddPage());
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection('notes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final res = snapshot.data!.docs[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Icon(Icons.delete),
                    onDismissed: (v) {
                      var snackbar = SnackBar(content: Text("Deleted"),duration: Duration(milliseconds: 300));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      DataBaseServices.delete(res.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 5.0,
                        margin: EdgeInsets.all(5),
                        child: ExpansionTile(
                          title: Text(
                            "${res['title']}",
                            style: TextStyle(fontSize: 25),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${res['detail']}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                          leading: IconButton(
                            onPressed: () {
                              navigator(
                                  context,
                                  EditPage(
                                      id: res.id,
                                      title: res['title'],
                                      detail: res['detail']));
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
