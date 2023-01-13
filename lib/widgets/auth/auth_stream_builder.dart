import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class AuthStreamBuilder extends StatelessWidget {
  final Widget child;

  AuthStreamBuilder({required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<Auth>(context, listen: false)
              .getUserData(FirebaseAuth.instance.currentUser!.uid);

          return child;
        }

        return AuthScreen();
      },
    );
  }
}
