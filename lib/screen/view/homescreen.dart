import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notedatabase/screen/contorller/homecontroller.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Homecontroller homecontroller = Get.put(Homecontroller());
  TextEditingController task = TextEditingController();
  bool ischk = false;
  List chk=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Note Keeper"),
          backgroundColor: Colors.green.shade400,
        ),
        body: StreamBuilder(
            stream: homecontroller.readData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                print("============= ${snapshot.data.snapshot}");

                List l1 = [];
                DataSnapshot data = snapshot.data.snapshot;

                for (var x in data.children) {
                  Taskmodel t1 = Taskmodel(
                      task: x.child("task").value.toString(), key: x.key);
                  l1.add(t1);
                }
                return ListView.builder(
                    itemCount: l1.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(value: chk[1], onChanged: (value){

                        }),
                        title: Text("${l1[index].task}"),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  task = TextEditingController(
                                      text: l1[index].task);
                                  DilogeBox(l1[index].key.toString());
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  homecontroller.delete(l1[index].key);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade400,

          onPressed: () {
            task = TextEditingController();
            DilogeBox(null);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void DilogeBox(String? key) {
    Get.defaultDialog(
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: task,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                homecontroller.adddata(task: task.text, key: key);
              },
              child: Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
