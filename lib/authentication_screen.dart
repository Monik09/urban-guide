import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLoginPage = true, _isAutoEnabled = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _password2Key = GlobalKey<FormFieldState>();
  FocusNode nodePassword = FocusNode();
  FocusNode nodeEmail = FocusNode();
  FocusNode nodePassword2 = FocusNode();
  bool _initialized = false;
  bool _error = false;

  void showSnack(String err, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(err),
      backgroundColor: color,
    ));
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: _emailController,
              key: _emailKey,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: _isAutoEnabled
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (email) {
                if (!(email.contains('@') &&
                    (email.contains('.com') ||
                        email.contains('.in') ||
                        email.contains('.edu') ||
                        email.contains(".org")))) {
                  return "Please provide a valid email address!";
                }
                if (email.length < 5) {
                  return "Length of email can't be less than 5";
                }
                return null;
              },
              onEditingComplete: () {
                print(_emailController.value);
                FocusScope.of(context).requestFocus(nodePassword);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              key: _passwordKey,
              controller: _passwordController,
              obscureText: true,
              autovalidateMode: _isAutoEnabled
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (password) {
                return (password.length == 0 || password.length <= 7)
                    ? "Password can't be of less than 7"
                    : null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(nodePassword2);
              },
            ),
          ),
          if (!isLoginPage)
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                key: _password2Key,
                controller: _password2Controller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: _isAutoEnabled
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                validator: (password) {
                  if (_password2Key.currentState.value.toString() !=
                      _passwordKey.currentState.value.toString()) {
                    return "Passwords don't match!!";
                  }
                  return null;
                },
                onEditingComplete: () {
                  // FocusScope.of(context).requestFocus(nodeEmail);
                },
              ),
            ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            onPressed: () {
              print("Pressed");
              setState(() {
                _isAutoEnabled = true;
              });

              if (_passwordKey.currentState.validate() &&
                  _emailKey.currentState.validate() &&
                  (isLoginPage || _password2Key.currentState.validate())) {
                // print(_emailKey.currentState.value);
                // print(_passwordKey.currentState.value);
                // print(_password2Key.currentState.value);
                if (!isLoginPage) {
                  _register(_emailKey.currentState.value,
                      _passwordKey.currentState.value);
                } else {
                  _login(_emailKey.currentState.value,
                      _passwordKey.currentState.value);
                }
              }
            },
            child: Text(
              !isLoginPage ? "Register" : "Login",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: FlatButton(
                      onPressed: null,
                      child: Text(isLoginPage
                          ? "Don't Have an account?"
                          : "Already have an account?"))),
              Flexible(
                  child: FlatButton(
                color: Colors.transparent,
                onPressed: () {
                  setState(() {
                    isLoginPage = !isLoginPage;
                  });
                },
                child: Text(
                  isLoginPage ? "Sign Up" : "Sign In",
                  style: TextStyle(color: Colors.blue[600]),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  _register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("Success");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showSnack(
            'The password provided is too weak.', Colors.redAccent, context);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showSnack('The account already exists for that email.',
            Colors.redAccent, context);
      }
    } on PlatformException catch (e) {
      print("error");
    } catch (e) {
      print(e);
    }
  }

  _login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      showSnack("User logged in :)", Colors.green, context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        showSnack('No user found for that email.', Colors.redAccent, context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showSnack('Wrong password provided for that user.', Colors.redAccent,
            context);
      }
    }
  }
}
