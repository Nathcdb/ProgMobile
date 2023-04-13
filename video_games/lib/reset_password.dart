import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'field.dart';
import 'main.dart';
import 'utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final mailCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        gotoNew(const Login(), context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Mot de passe oublie',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  space(10),
                  const Text(
                    'Veuillez saisir votre email\nafin de reinitialiser votre mot de passe.',
                    textAlign: TextAlign.center,
                  ),
                  space(40),
                  MyField(
                    controller: mailCont,
                    hint: 'E-mail',
                  ),
                  space(50),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: mailCont.text);
                          Fluttertoast.showToast(
                              msg:
                                  "L'e-mail de réinitialisation du mot de passe a été envoyé");
                          Navigator.pop(context);
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "Quelque chose s'est mal passé !");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 26, 118, 193),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Renvoyer mon mot de passe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
