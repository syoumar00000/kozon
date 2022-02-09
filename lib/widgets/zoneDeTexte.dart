import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozon/model/firebaseHelper.dart';
import 'package:kozon/model/myUser.dart';

class ZoneDeTexte extends StatefulWidget {
  final MyUser partenaire;
  final MyUser me;
  const ZoneDeTexte({Key? key, required this.partenaire, required this.me})
      : super(key: key);

  @override
  _ZoneDeTexteState createState() => _ZoneDeTexteState();
}

class _ZoneDeTexteState extends State<ZoneDeTexte> {
  TextEditingController _controllerSms = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(3.5),
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () => _takeAPic(ImageSource.camera),
              icon: Icon(Icons.camera_enhance)),
          IconButton(
              onPressed: () => _takeAPic(ImageSource.gallery),
              icon: Icon(Icons.photo_library)),
          Flexible(
            child: TextField(
              controller: _controllerSms,
              decoration: InputDecoration.collapsed(
                  hintText: "Saisir votre message..."),
              maxLines: null,
            ),
          ),
          IconButton(
              onPressed: () => _sendButtonPressed(), icon: Icon(Icons.send)),
        ],
      ),
    );
  }

  _sendButtonPressed() {
    if (_controllerSms.text != null && _controllerSms.text != "") {
      String text = _controllerSms.text;
      // 1=> envoyer le texte sur firebase
      FirebaseHelper().sendMessage(widget.me, widget.partenaire, text, null);
      //2=> effacer le contenu du champ de saisie
      _controllerSms.clear();
      //3=> fermer ce champ de texte
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      // aucune saisie effectuée
    }
  }

  Future<void> _takeAPic(ImageSource source) async {
    final XFile? picked = await ImagePicker()
        .pickImage(source: source, maxHeight: 1000, maxWidth: 1000);
    if (picked != null) {
      File file = File(picked.path);
      String date = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseHelper.entrySmS.child(widget.me.uid!).child(date);
      FirebaseHelper.savePic(file, ref).then((imageUrl) {
        FirebaseHelper()
            .sendMessage(widget.me, widget.partenaire, null, imageUrl);
      });
    }
  }
}
