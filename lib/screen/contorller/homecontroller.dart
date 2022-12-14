import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Homecontroller extends GetxController {

  void adddata({String? task, String? key, bool? status}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbref = firebaseDatabase.ref();
    if (key == null) {
      dbref.child("Task").push().set({"task": task, "status": status});
    } else {
      dbref.child("Task").child(key).set({task: "task", "status": status});
    }
  }

  void Status({String? key, bool? status, String? task}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbref = firebaseDatabase.ref();
    dbref.child("Task").child(key!).set({"task":task, "status": status});
  }

  Stream<DatabaseEvent> readData() {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbref = firebaseDatabase.ref();
    return dbref.child("Task").onValue;
  }

  Future<void> delete(String key) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbref = firebaseDatabase.ref();
    return dbref.child("Task").child(key).remove();
  }
}

class Taskmodel {
  String? task, key;
  bool? status;

  Taskmodel({this.task, this.key, this.status});
}
