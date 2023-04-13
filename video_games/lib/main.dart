import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:video_games/data_provider.dart';
import 'package:video_games/field.dart';
import 'package:video_games/home.dart';
import 'package:video_games/inscription.dart';
import 'package:video_games/reset_password.dart';
import 'package:video_games/utils.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<Database>(
      create: (context) => Database(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Games',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.grey,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.grey,
          onBackground: Colors.white,
          surface: Colors.grey,
          onSurface: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 5, 29),
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final mailCont = TextEditingController();
  final passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bienvenue !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                space(10),
                const Text(
                  'Veuillez vous connector ou\ncareer un nouveau compte\npour utiliser l\'application.',
                  textAlign: TextAlign.center,
                ),
                space(10),
                MyField(
                  controller: mailCont,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'E-mail',
                ),
                space(10),
                MyField(
                  controller: passCont,
                  hint: 'Mot de passe',
                  isPassword: true,
                ),
                space(50),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Chargement..');
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: mailCont.text, password: passCont.text);
                        gotoNew(const HomePage(), context);
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "Quelque chose s'est mal passé !");
                      }
                      EasyLoading.dismiss();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 26, 118, 193),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Se connecter',
                    ),
                  ),
                ),
                space(10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 26, 118, 193),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      gotoNew(const Inscription(), context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Creer un nouveau compte',
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        // gotoNew(const ResetPassword(), context);
                      },
                      child: const Text(
                        'Mot de passe oublie',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
