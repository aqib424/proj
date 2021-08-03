import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/Screens/HomePage/home_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                key: _formKey1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Your Email",
                    fillColor: Colors.purple.shade100),
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
              child: TextFormField(
                  validator: (val) => val.length < 6
                      ? 'Enter a password with 6+ characters'
                      : null,
                key: _formKey2,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Your Password",
                    fillColor: Colors.purple.shade100),
                onChanged:  (val) {
                  setState(() => password = val);
                }
              ),
            ),
            RoundedButton(
              textColor: Colors.black,
              color: Colors.purple.shade100,
              text: "LOGIN",
              press: () async {
                if (_formKey1.currentState.validate() && _formKey2.currentState.validate()){
                 await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                }
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => homeScreen()));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

