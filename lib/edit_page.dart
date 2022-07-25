import 'package:flutter/material.dart';
import 'package:notebook/database_services.dart';

class EditPage extends StatelessWidget {
  String? id;
  String? title;
  String? detail;
  EditPage({Key? key, this.id, this.title, this.detail}) : super(key: key);

  TextEditingController titleC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleC,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Please Enter Title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: '$title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 7,
                  minLines: 1,
                  controller: detailC,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Please Enter Detail";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: '$detail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 40)),
                    ),
                    onPressed: () {
                      var snackbar = SnackBar(
                          content: Text("Updated"),
                          duration: Duration(milliseconds: 300));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      if (formkey.currentState!.validate()) {
                        DataBaseServices.updateData(
                            id!, titleC.text, detailC.text);
                      }
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
