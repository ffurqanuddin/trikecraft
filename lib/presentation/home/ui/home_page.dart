import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


  
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final username = FirebaseAuth.instance.currentUser?.displayName;
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome $username"),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then(
                    (value) async {
                      await MyHiveBoxes.settingBox
                          .put(MyHiveKeys.userIsLoggedIn, false);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.signInRoute,
                        (route) => true,
                      );
                    },
                  );
                },
                child: Text("Logout Now"))
          ],
        ),
      ),
    );
  }
}
