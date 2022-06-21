import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/widgets/reuseable_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            children: <Widget>[
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
                      icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              ReuseableButton(
                color: Colors.blueAccent,
                text: 'Register',
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    await Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    );
                    final userCredential =
                        await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    setState(() {
                      showSpinner = false;
                    });

                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushNamed(LoginScreen.id);
                    });

                    print(userCredential);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      print('email already in use ');
                    } else if (e.code == 'weak-password') {
                      print('password is weak');
                    } else if (e.code == 'invalid-email') {
                      print('invalid email');
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
