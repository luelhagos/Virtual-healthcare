import 'package:flutter/material.dart';
import 'package:project/views/loginForm.dart';
import 'package:project/widgets/registration.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

final loginPagekey = GlobalKey<LoginState>();

class LoginState extends State<Login> {
  int selectedLang = 1;
  var isLoading = false;
  Map<String, String> langCode = {"አማርኛ": "amh", "English": "en"};
  Map<String, String> langName = {"amh": "አማርኛ", "en": "English"};

  @override
  void initState() {
    super.initState();
  }

  _onLocaleChanged() async {}

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green, title: Center(child: Text("LOGIN"))),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    height: 150,
                    width: 200,
                    child: Image(
                      image: AssetImage("assets/login.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40), child: LoginForm()),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Text('Create an Account?'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registration()));
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.2,
                  ),
                  DropdownButton<int>(
                      onChanged: (newvalue) async {
                        setState(() {
                          selectedLang = newvalue!;
                        });
                      },
                      value: selectedLang,
                      items: [
                        DropdownMenuItem(
                          child: Text("English"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("French"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Arabic"),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("Swahili"),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text("kinyarwanda"),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text("Tigrinya"),
                          value: 6,
                        ),
                      ]),
                ],
              ),
            ),
    );
  }
}
