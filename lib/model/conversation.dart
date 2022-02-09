import 'package:firebase_database/firebase_database.dart';
import 'package:kozon/model/myUser.dart';

class Conversation {
  MyUser? user;
  String? date;
  String? msg;
  String? uid;

  Conversation(DataSnapshot snapshot) {
    //Object? value = snapshot;
    user = MyUser(snapshot);
    uid = snapshot.child("monId").value.toString();
    msg = snapshot.child("lastMessage").value.toString();
    date = snapshot.child("dateString").value.toString();
  }
}
