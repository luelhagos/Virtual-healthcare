import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/bottomNavBar.dart';
import 'package:project/widgets/doctorsSelectingList.dart';
import 'package:project/widgets/selecting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final userCont = TextEditingController();
  final passCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loggingin = false;

  @override
  void initState() {
    super.initState();
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Authenticating ... Please wait")
    ],
  );

  var loginErrorMsg = Text("");

  @override
  Widget build(BuildContext context) {
    debugPrint(_formKey.toString());
    return Container(
      padding: EdgeInsets.only(left: 70, right: 70, top: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            textFieldBuilder(userCont, 'username', emailValidator, false),
            SizedBox(
              height: 6.0,
            ),
            textFieldBuilder(passCont, 'password', passwordValidator, true),
            SizedBox(
              height: 6.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginSubmitButton('submit', context),
              ],
            ),
            loginErrorMsg,
            loggingin ? loading : Text(""),
          ],
        ),
      ),
    );
  }

  Widget textFieldBuilder(
      var controller, String label, Function validator, bool obsecure) {
    return TextFormField(
      onFieldSubmitted: (value) {},
      validator: (value) => validator(value),
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: obsecure,
      decoration: InputDecoration(
        filled: false,
        labelText: label.toLowerCase(),
        labelStyle: TextStyle(fontSize: 15.0, height: 1.5, color: Colors.grey),
        fillColor: Color(0xffD2E8E6),
      ),
      maxLines: 1,
    );
  }

  Widget loginSubmitButton(String label, BuildContext context) {
    return FlatButton(
      onPressed: () {
        onSubmitPressed(userCont.text, passCont.text, context);
      },
      color: Colors.green,
      child: Text(
        label.toLowerCase(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  onSubmitPressed(
      String user_cont, String pass_cont, BuildContext context) async {
    var apicall = Provider.of<ApiProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      this.setState(() {
        loggingin = true;
      });
      debugPrint([user_cont, pass_cont].toString());
      var response = await apicall.userLogIn(user_cont, pass_cont);
      debugPrint(response.toString());
      //TODO: check if user logging in has ea role.
      //      if not, indicate the role issue and deny login
      if (response['success'] == true) {
        var response1 = await apicall.fetchDataUsers();
        var response = await apicall.fetchDataStorage();
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("emailset", user_cont);
        await Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavBarWidget()));
        });
      } else {
        //TODO: login error should be implemented more elegantly
        this.setState(() {
          loggingin = false;
          loginErrorMsg = Text(
            "Login Error!",
            style: TextStyle(color: Colors.red),
          );
        });
      }
    }
  }

  emailValidator(String value) {
    if (value.isEmpty) return 'Enter a valid email!';
    return null;
  }

  passwordValidator(String value) {
    if (value.isEmpty) return "Password is Empty!";
    return null;
  }
}
