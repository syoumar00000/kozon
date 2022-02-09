import 'package:flutter/material.dart';
import 'package:kozon/model/dateHelper.dart';
import 'package:kozon/model/firebaseHelper.dart';
import 'package:kozon/model/message.dart';
import 'package:kozon/model/myUser.dart';
import 'package:kozon/widgets/customImage.dart';

class ChatBubble extends StatelessWidget {
  final MyUser partenaire;
  final Message message;
  final Animation<double> animation;
  final String myUid = FirebaseHelper().auth.currentUser!.uid;
  ChatBubble(
      {Key? key,
      required this.partenaire,
      required this.message,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SizeTransition pour que chatbubble prenne la taille du sms
    return SizeTransition(
        sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: bubble(myUid == message.from),
          ),
        ));
  }

  //bubble pour que la bulle se place en fonction de celui qui envoie le sms
  List<Widget> bubble(bool moi) {
    CrossAxisAlignment alignment =
        (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color? color = (moi) ? Colors.pink[200] : Colors.blue[200];

    return <Widget>[
      (moi)
          ? Padding(padding: EdgeInsets.all(5.0))
          : CustomImage(
              imageUrl: partenaire.imageUrl,
              initiales: partenaire.initiales,
              radius: 15,
            ),
      Expanded(
          child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(DateHelper().convert(message.dateString!)),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: color,
            child: Container(
              padding: EdgeInsets.all((message.imageUrl != null) ? 0 : 10),
              child: (message.imageUrl != null)
                  ? CustomImage(
                      imageUrl: message.imageUrl,
                      initiales: null,
                      radius: null,
                    )
                  : Text(message.text!),
            ),
          )
        ],
      )),
    ];
  }
}
