import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kozon/component/customTextfield.dart';
import 'package:kozon/model/firebaseHelper.dart';

class LogController extends StatefulWidget {
  const LogController({Key? key}) : super(key: key);

  @override
  _LogControllerState createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {
  bool _log = true;
  bool showPassword = true;
  //String _addressMail = "";
  //String _password = "";
  // String _prenoms = "";
  //String _noms = "";
  TextEditingController _prenoms = TextEditingController();
  TextEditingController _addressMail = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _noms = TextEditingController();
  // TextEditingController phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("authentification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 2,
              child: Card(
                elevation: 7.5,
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widgetlists(),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _log = !_log;
                  });
                },
                child:
                    Text((_log) ? "Authentification" : "Creation de compte")),
            ElevatedButton(
              onPressed: _handleLog,
              child: Text("C'est Parti!"),
            )
          ],
        ),
      ),
    );
  }

  _handleLog() {
    if (_addressMail.text != "") {
      if (_password.text != "") {
        if (_log) {
          //connexion
          FirebaseHelper()
              .handleSignIn(_addressMail.text, _password.text)
              .then((user) => {print("user.uid----${user!.uid}")})
              .catchError((error) {
            alerte(error.toString());
          });
        } else {
          // creation de compte
          if (_prenoms.text != "") {
            if (_noms.text != "") {
              // creer utilisateur
              FirebaseHelper()
                  .create(_addressMail.text, _password.text, _prenoms.text,
                      _noms.text)
                  .then((user) => {
                        print("user.uid----${user.uid}"),
                      })
                  .catchError((error) {
                alerte(error.toString());
              });
            } else {
              // pas de nom
              alerte("Aucun Nom n'a été renseigné...");
            }
          } else {
            //pas de prnoms
            alerte("Aucun Prénom n'a été renseigné...");
          }
        }
      } else {
        // pas de mdp
        alerte("Aucun Mot de Passe n'a été renseigné...");
      }
    } else {
      // pas de mail
      alerte("Aucune Addresse Mail n'a été renseignée...");
    }
  }

  List<Widget> widgetlists() {
    List<Widget> widgets = [];

    widgets.add(CustomTextField(
      // placeholder: "Addresse Mail",
      controller: _addressMail,
      type: TextInputType.emailAddress,
      // isEmail: true,
      // isRequired: true,
      icon: Icons.edit,
      isPassword: false,
      label: "Addresse Mail",
      showPassword: false,
    )
        //   TextField(
        //   decoration: InputDecoration(hintText: "Address Mail"),
        //   onChanged: (string) {
        //     _addressMail = string;
        //   },
        // )
        );

    widgets.add(
      CustomTextField(
        label: "Mot de passe *",
        icon: Icons.edit,
        // placeholder: "********",
        isPassword: true,
        // isRequired: true,
        showPassword: showPassword,
        controller: _password,
        onVisiblePassword: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        type: TextInputType.text,
      ),
      //   TextField(
      //   decoration: InputDecoration(hintText: "Mot de Passe"),
      //   obscureText: true,
      //   onChanged: (string) {
      //     _password = string;
      //   },
      // )
    );

    if (!_log) {
      widgets.add(CustomTextField(
        // placeholder: "Prénoms",
        icon: Icons.edit,
        controller: _prenoms,
        type: TextInputType.text,
        isPassword: false,
        label: 'Prénoms',
        showPassword: false,
        //isRequired: true,
        //isText: true,
      )
          //   TextField(
          //   decoration: InputDecoration(hintText: "Prénoms"),
          //   onChanged: (string) {
          //     _prenoms = string;
          //   },
          // )
          );
      widgets.add(CustomTextField(
        // placeholder: "Prénoms",
        icon: Icons.edit,
        controller: _noms,
        type: TextInputType.text,
        isPassword: false,
        label: 'Noms',
        showPassword: false,
        //isRequired: true,
        //isText: true,
      )
          //   TextField(
          //   decoration: InputDecoration(hintText: "Nom"),
          //   onChanged: (string) {
          //     _noms = string;
          //   },
          // )
          );
    }
    return widgets;
  }

  Future<void> alerte(String message) async {
    Text title = Text("Erreur");
    Text msg = Text(message);
    TextButton okButton = TextButton(
        onPressed: () => Navigator.of(context).pop(), child: Text("OK"));
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: msg,
                  actions: [okButton],
                )
              : AlertDialog(
                  title: title,
                  content: msg,
                  actions: [okButton],
                );
        });
  }
}
