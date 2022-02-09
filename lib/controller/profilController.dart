import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozon/model/firebaseHelper.dart';
import 'package:kozon/model/myUser.dart';
import 'package:kozon/widgets/customImage.dart';

class ProfilController extends StatefulWidget {
  const ProfilController({Key? key}) : super(key: key);

  @override
  _ProfilControllerState createState() => _ProfilControllerState();
}

class _ProfilControllerState extends State<ProfilController> {
  MyUser? me;
  TextEditingController _prenoms = TextEditingController();
  TextEditingController _noms = TextEditingController();
  final User? user = FirebaseHelper().auth.currentUser;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return (me == null)
        ? Center(
            child: Text("Chargement..."),
          )
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomImage(
                    imageUrl: me!.imageUrl,
                    initiales: me!.initiales!.toUpperCase(),
                    radius: MediaQuery.of(context).size.width / 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _takeAPic(ImageSource.camera);
                        },
                        icon: Icon(Icons.camera_enhance),
                      ),
                      IconButton(
                        onPressed: () {
                          _takeAPic(ImageSource.gallery);
                        },
                        icon: Icon(Icons.photo_library),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _prenoms,
                    decoration: InputDecoration(hintText: me!.prenoms),
                  ),
                  TextField(
                    controller: _noms,
                    decoration: InputDecoration(hintText: me!.nom),
                  ),
                  ElevatedButton(
                    onPressed: upDateUser,
                    child: Text("Sauvegarder"),
                  ),
                  TextButton(onPressed: logOut, child: Text("Se Déconnecter")),
                ],
              ),
            ),
          );
  }

  Future<void> logOut() async {
    Text title = Text("Se Déconnecter");
    Text content = Text("Etes vous sur de vouloir vous déconnecter ?");
    TextButton noBtn = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Non"));
    TextButton yesBtn = TextButton(
        onPressed: () {
          FirebaseHelper()
              .handleLogOut()
              .then((bool) => {Navigator.of(context).pop()});
        },
        child: Text("Oui"));
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: <Widget>[yesBtn, noBtn],
                )
              : AlertDialog(
                  title: title,
                  content: content,
                  actions: <Widget>[yesBtn, noBtn],
                );
        });
  }

  upDateUser() {
    Map map = me!.toMap();
    if (_prenoms.text != "" && _prenoms.text != null) {
      map["prenoms"] = _prenoms.text;
    }
    if (_noms.text != "" && _noms.text != null) {
      map["nom"] = _noms.text;
    }
    FirebaseHelper().addUser(me!.uid!, map);
    _getUser();
  }

  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }

  Future<void> _takeAPic(ImageSource source) async {
    final XFile? img = await ImagePicker()
        .pickImage(source: source, maxHeight: 500, maxWidth: 500);
    if (img != null) {
      File file = File(img.path);
      FirebaseHelper.savePic(file, FirebaseHelper.entryUser.child(me!.uid!))
          .then((str) {
        Map map = me!.toMap();
        map["imageUrl"] = str;
        FirebaseHelper().addUser(me!.uid!, map);
        _getUser();
      });
    }
  }
}
