import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kozon/controller/chatController.dart';
import 'package:kozon/model/firebaseHelper.dart';
import 'package:kozon/model/myUser.dart';
import 'package:kozon/widgets/customImage.dart';

class ContactController extends StatefulWidget {
  const ContactController({Key? key}) : super(key: key);

  @override
  _ContactControllerState createState() => _ContactControllerState();
}

class _ContactControllerState extends State<ContactController> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: FirebaseHelper.userEntry,
      sort: (a, b) => (a
          .child('prenoms')
          .value
          .toString()
          .toLowerCase()
          .compareTo(b.child('prenoms').value.toString().toLowerCase())),
      itemBuilder: (BuildContext ctx, DataSnapshot snap,
          Animation<double> animation, int index) {
        MyUser newUser = MyUser(snap);
        if (FirebaseHelper().auth.currentUser!.uid == newUser.uid) {
          return Container();
        } else {
          return ListTile(
            leading: CustomImage(
                imageUrl: newUser.imageUrl,
                initiales: newUser.initiales,
                radius: 20),
            title: Text(newUser.fullName()),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ChatController(partenaire: newUser);
                  }),
                );
              },
              icon: Icon(Icons.message),
            ),
          );
        }
      },
    );
  }
}
