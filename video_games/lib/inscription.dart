import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_games/home.dart';
import 'package:video_games/main.dart';

import 'field.dart';
import 'utils.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final mailCont = TextEditingController();
  final passCont = TextEditingController();
  final verifyPassCont = TextEditingController();
  final usernameCont = TextEditingController();
  final fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        gotoNew(const Login(), context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: fKey,
                child: Column(
                  children: [
                    const Text(
                      'Inscription',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    space(10),
                    const Text(
                      'Veuillez saisir ces differentes informations,\nafin que vos listes soient sauvegardees.',
                      textAlign: TextAlign.center,
                    ),
                    space(10),
                    MyField(
                      controller: usernameCont,
                      hint: 'Nom d\'utilisateur',
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Requis';
                        }
                        return null;
                      },
                    ),
                    space(10),
                    MyField(
                      controller: mailCont,
                      hint: 'E-mail',
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Requis';
                        }
                        return null;
                      },
                    ),
                    space(10),
                    MyField(
                      controller: passCont,
                      hint: 'Mot de passe',
                      isPassword: true,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Requis';
                        }
                        return null;
                      },
                    ),
                    space(10),
                    MyField(
                      controller: verifyPassCont,
                      hint: 'Verification du mot de passe',
                      isPassword: true,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Requis';
                        }
                        return null;
                      },
                    ),
                    space(50),
                    SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (fKey.currentState!.validate()) {
                            if (passCont.text != verifyPassCont.text) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Les mots de passe ne correspondent pas!');
                              return;
                            }

                            EasyLoading.show(status: 'Chargement..');
                            try {
                              final cred = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: mailCont.text,
                                      password: passCont.text);
                              if (cred.user != null) {
                                await cred.user!
                                    .updateDisplayName(usernameCont.text);
                                gotoNew(const HomePage(), context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Quelque chose s'est mal passé !");
                              }
                            } on FirebaseAuthException catch (e) {
                              Fluttertoast.showToast(msg: e.message!);
                            }
                            EasyLoading.dismiss();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 26, 118, 193),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'S\'inscrire',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
