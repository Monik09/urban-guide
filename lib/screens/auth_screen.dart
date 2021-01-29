import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    // return Scaffold(
    //   // resizeToAvoidBottomInset: false,
    //   body: Stack(
    //     children: <Widget>[
    //       Container(
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             colors: [
    //               Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
    //               Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
    //             ],
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight,
    //             stops: [0, 1],
    //           ),
    //         ),
    //       ),
    //       SingleChildScrollView(
    //         child: Container(
    //           height: deviceSize.height,
    //           width: deviceSize.width,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Flexible(
    //                 child: Container(
    //                   margin: EdgeInsets.only(bottom: 20.0),
    //                   padding: EdgeInsets.symmetric(
    //                       vertical: 18.0, horizontal: 94.0),
    //                   transform: Matrix4.rotationZ(-8 * pi / 180)
    //                     ..translate(-10.0),
    //                   // ..translate(-10.0),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     color: Colors.deepOrange.shade900,
    //                     boxShadow: [
    //                       BoxShadow(
    //                         blurRadius: 8,
    //                         color: Colors.black26,
    //                         offset: Offset(0, 2),
    //                       )
    //                     ],
    //                   ),
    //                   child: Text(
    //                     'BhaadePay',
    //                     style: TextStyle(
    //                       color: Theme.of(context).accentTextTheme.title.color,
    //                       fontSize: 40,
    //                       fontFamily: 'Anton',
    //                       fontWeight: FontWeight.normal,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Flexible(
    //                 flex: deviceSize.width > 600 ? 2 : 1,
    //                 child: AuthCard(),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Color(0xFF313131),
      body: Container(
        height: deviceHeight * 0.87,
        child: Column(
          children: [
            Stack(
              //clipBehavior: Clip.antiAlias,
              children: [
                Image.asset(
                  'assets/images/Vector1.png',
                  fit: BoxFit.fill,
                  scale: 0.4,
                ),
                Image.asset(
                  'assets/images/Vector2.png',
                  fit: BoxFit.fill,
                  scale: 0.4,
                  // ),
                ),
                Positioned(
                  top: deviceHeight * 0.116578034,
                  left: deviceWidth * 0.045686541,
                  right: deviceWidth * 0.012,
                  child: Column(
                    children: [
                      // Image.asset(
                      //   "assets/Images/CC-Logo(1).png",
                      //   scale: 1.8,
                      // ),
                      SizedBox(
                        height: deviceHeight * 0.058681,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceHeight * 0.0094017,
                          vertical: deviceWidth * 0.02037037,
                        ),
                        child: Text(
                          "Bhaade Pay",
                          // softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                          ),
                          // style: styles.customStyle(
                          //     color: Styles.buttonColor, size: 35.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              // height:AuthCard.auth deviceHeight * 0.052681,
              height: _AuthCardState.authMode2 == AuthMode.Login
                  ? deviceHeight * 0.052681
                  : deviceHeight * 0.032681,
            ),
            Flexible(
              flex: deviceSize.width > 600 ? 3 : 1,
              child: AuthCard(),
            ),
            // Expanded(
            //   child: Container(
            //     alignment: Alignment.bottomCenter,
            //     height: deviceHeight * 0.06399636,
            //     width: deviceWidth * 0.79,
            //     child: neu.NeumorphicButton(
            //       style: neu.NeumorphicStyle(
            //         lightSource: isPressed
            //             ? neu.LightSource.topLeft
            //             : neu.LightSource.top,
            //         shadowLightColorEmboss: Styles.backgroundColor,
            //         shadowLightColor: Styles.backgroundColor,
            //         boxShape: neu.NeumorphicBoxShape.roundRect(
            //           BorderRadius.circular(
            //               MediaQuery.of(context).size.height * 0.0387820513),
            //         ),
            //         color: !isPressed ? Styles.backgroundColor : Colors.black12,
            //         intensity: 1,
            //         shape: !isPressed
            //             ? neu.NeumorphicShape.flat
            //             : neu.NeumorphicShape.concave,
            //         depth: isPressed
            //             ? -4.9687
            //             : 4.9687, //MediaQuery.of(context).size.height*0.023,
            //         oppositeShadowLightSource: false,
            //       ),
            //       onPressed: () {
            //         var googleSignMe = GoogleSignMeIn();
            //         googleSignMe.login();
            //         setState(() {
            //           isPressed = true;
            //         });
            //       },
            //       child: Container(
            //         height: deviceHeight * 0.06599636,
            //         width: deviceWidth * 0.76,
            //         child: Row(
            //           children: [
            //             Container(
            //               padding: EdgeInsets.only(left: deviceWidth * 0.011),
            //               child: Image.asset(
            //                 "assets/Images/google_bg.png",
            //                 fit: BoxFit.fitHeight,
            //                 scale: 7,
            //               ),
            //             ),
            //             Flexible(
            //               child: Text(
            //                 " Log in with Google",
            //                 style: styles.headingStyle(
            //                     color: Styles.buttonColor,
            //                     fontWeight: FontWeight.w400),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  static AuthMode _authMode = AuthMode.Login;
  static AuthMode get authMode2 {
    return _authMode;
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
            _authData['email'], _authData['password'], _authData['name']);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 330 : 260,
        // height: _heightAnimation.value.height,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 330 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 100 : 0,
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value.length == 0) {
                                  return 'Please Give a valid name!!';
                                }
                                return null;
                              }
                            : null,
                        onSaved: (value) {
                          _authData['name'] = value;
                        },
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 100 : 0,
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
