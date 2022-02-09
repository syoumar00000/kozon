import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kozon/controller/contactsController.dart';
import 'package:kozon/controller/messagesController.dart';
import 'package:kozon/controller/profilController.dart';
import 'package:kozon/model/firebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainAppController extends StatelessWidget {
  final User? user = FirebaseHelper().auth.currentUser;
  @override
  Widget build(BuildContext context) {
    final se = Theme.of(context).platform;
    if (se == TargetPlatform.iOS) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.blue,
            activeColor: Colors.black,
            inactiveColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.message)),
              BottomNavigationBarItem(icon: Icon(Icons.supervisor_account)),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
            ],
          ),
          tabBuilder: (BuildContext ctx, int index) {
            Widget controllerSelected = controllers()[index];
            return Scaffold(
              appBar: AppBar(
                title: Text("Kozon Chat"),
              ),
              body: controllerSelected,
            );
          });
    } else {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Kozon Chat"),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.message),
                  ),
                  Tab(
                    icon: Icon(Icons.supervisor_account),
                  ),
                  Tab(
                    icon: Icon(Icons.account_circle),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: controllers(),
            ),
          ));
    }
  }

  List<Widget> controllers() {
    return [MessageController(), ContactController(), ProfilController()];
  }
}
