import 'dart:io' show Platform;

import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _phone = "", _userName = "";

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        });
  }

  Future registerUser() async {
    _auth.registerWithEmailPassword(_email, _password);
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Signup View", "signUpView");
    return Scaffold(
      backgroundColor: AppColors.signUpScreenBackgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Create your account",
                  style: TextStyle(
                    color: AppColors.signUpTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 2.5,
                ),
                Text(
                  "Sign up to get started!",
                  style: TextStyle(
                    color: AppColors.signUpTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          // TODO: Implement the form here
          Center(
            child: SizedBox(
              width: screenWidth(context) - 80,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.signUpFormBackgroundColor,
                        labelStyle: const TextStyle(
                            color: AppColors.signUpFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "email",
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave email empty!';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address!';
                          }
                          /*
                          if (!isUnique(email)) {
                            return "This email is already registered!';
                          }
                           */
                        }
                      },
                      onSaved: (value) {
                        _email = value ?? "";
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.signUpFormBackgroundColor,
                        labelStyle: const TextStyle(
                            color: AppColors.signUpFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "username",
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave username empty!';
                          }
                          if (value.length < 6) {
                            return 'Username is too short!';
                          }
                          /*
                          if (!isUnique(value) {
                            return 'This username has been taken before!';
                          }
                           */
                        }
                      },
                      onSaved: (value) {
                        _userName = value ?? "";
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      enableSuggestions: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.signUpFormBackgroundColor,
                        labelStyle: const TextStyle(
                            color: AppColors.signUpFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "password",
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave password empty!';
                          }
                          if (value.length < 6) {
                            return 'Password is too short!';
                          }
                        }
                      },
                      onSaved: (value) {
                        _password = value ?? "";
                      },
                    ),
                    /*const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      enableSuggestions: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.signUpFormBackgroundColor,
                        labelStyle: const TextStyle(
                            color: AppColors.signUpFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "re-enter password",
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave re-enter password empty!';
                          }
                          if (value != _password) {
                            return 'Password fields do not match up!';
                          }
                        }
                      },
                      onSaved: (value) {},
                    ),
                     */
                    const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.signUpFormBackgroundColor,
                        labelStyle: const TextStyle(
                            color: AppColors.signUpFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "phone number",
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave phone empty!';
                          }
                          if (value.length < 13) {
                            return 'The number you entered is not in the right format!';
                          }
                        }
                      },
                      onSaved: (value) {
                        _phone = value ?? "";
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Center(
              child: OutlinedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await registerUser();
                _showDialog("Sign Up Success",
                    "You have successfully signed up.\nYou will now be directed to the login page");
                Navigator.pushNamedAndRemoveUntil(
                    context, Login.routeName, (route) => false);
              } else {
                _showDialog('Form Error',
                    "You could not register with the current information. Try again!");
              }
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.signUpButtonBackgroundColor,
              fixedSize: const Size(125, 40),
            ),
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                color: AppColors.signUpButtonTextColor,
                fontSize: 20,
              ),
            ),
          )),
          const Spacer(),
        ],
      )),
    );
  }
}
