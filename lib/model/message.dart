import 'package:firebase_database/firebase_database.dart';

class Message {
  String? from;
  String? to;
  String? text;
  String? dateString;
  String? imageUrl;

  Message(DataSnapshot snapshot) {
    //Object? value = snapshot;
    from = snapshot.child("from").value.toString();
    to = snapshot.child("to").value.toString();
    text = snapshot.child("text").value.toString();
    dateString = snapshot.child("dateString").value.toString();
    imageUrl = snapshot.child("imageUrl").value.toString();
  }
}
