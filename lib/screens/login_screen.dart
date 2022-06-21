import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/reuseable_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool hidePassword = true;
  bool showSpinner = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                textAlign: TextAlign.center,
                controller: _email,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration:
                    kTextFileDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              Stack(
                children: [
                  TextField(
                    obscureText: hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    controller: _password,
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: kTextFileDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 300.0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              ReuseableButton(
                color: Colors.lightBlueAccent,
                text: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    await Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    );
                    final userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    setState(() {
                      showSpinner = false;
                    });
                    if (userCredential != null) {
                      Future.delayed(Duration.zero, () {
                        Navigator.pushNamed(context, ChatScreen.id);
                      });
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('user is not registered');
                    } else if (e.code == 'wrong-password') {
                      print('password is wrong');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
