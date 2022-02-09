import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kozon/controller/chatController.dart';
import 'package:kozon/model/conversation.dart';
import 'package:kozon/model/dateHelper.dart';
import 'package:kozon/model/firebaseHelper.dart';
import 'package:kozon/widgets/customImage.dart';

class MessageController extends StatefulWidget {
  const MessageController({Key? key}) : super(key: key);

  @override
  _MessageControllerState createState() => _MessageControllerState();
}

class _MessageControllerState extends State<MessageController> {
  String uid = FirebaseHelper().auth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: FirebaseHelper.entryConversation.child(uid),
        sort: (a, b) => b.key!.compareTo(a.key!),
        reverse: false,
        itemBuilder: (BuildContext ctx, DataSnapshot snap,
            Animation<double> animation, int index) {
          Conversation conversation = Conversation(snap);
          String sub = (conversation.uid == uid) ? "Moi : " : "";
          sub += ("${conversation.msg}");
          return Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: ListTile(
              leading: CustomImage(
                imageUrl: conversation.user!.imageUrl,
                initiales: conversation.user!.initiales,
                radius: 20,
              ),
              title: Text(conversation.user!.fullName()),
              subtitle: Text(sub),
              trailing: Text(DateHelper().convert(conversation.date!)),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext ctx) {
                  return ChatController(partenaire: conversation.user!);
                }));
              },
            ),
          );
        });
  }
}
