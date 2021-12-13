import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/selecting.dart';
import 'package:provider/provider.dart';

class registration extends StatefulWidget {
  // const registration({ Key? key }) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  bool _passwordVisible = false;
  bool _passwordVisibleConfirmation = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _fname, _lname, _email, _password, _type;
  int _valuediseas = 1, _availablity = 1;
  TextEditingController textEditingController = TextEditingController();

  List diseas = [
    {1: "Malaria", 2: "Blharzia", 3: "HIV", 4: "HeadAche"}
  ];
  List type = [
    {1: true, 2: false}
  ];
  @override
  void initState() {
    _passwordVisibleConfirmation = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text("Registration")),
        ),
        body: SingleChildScrollView(
            reverse: true,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                height: 150,
                width: 200,
                child: Image(
                  image: AssetImage("assets/First-Aid.jpg"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.green)),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter First Name';
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'First Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onSaved: (input) => _fname = input!),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.green)),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Last Name';
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Last Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onSaved: (input) {
                              _lname = input!;
                            }),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.green)),
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder()),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                              value: _valuediseas,
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Malaria"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Blharzia"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("HIV"),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text("HeadAche"),
                                  value: 4,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _valuediseas = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.green)),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        padding: EdgeInsets.only(left: 15),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder()),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                              value: _availablity,
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Available"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("UnAvailable"),
                                  value: 2,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _availablity = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.green)),
                        child: TextFormField(
                            scrollPadding: EdgeInsets.only(bottom: 40),
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Enter Email';
                              } else {
                                return EmailValidator.validate(input)
                                    ? null
                                    : 'Please enter a valid email';
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input!),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.green)),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: TextFormField(
                          controller: textEditingController,
                          validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_passwordVisible,
                          onSaved: (input) => _password = input!,
                        ),
                      ),
                      SizedBox(height: 22),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: signUp,
                        child: Text('SignUp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var name = _fname + _lname;
      var apicall = Provider.of<ApiProvider>(context, listen: false);
      try {
        var response = await apicall.doctorregistration(type[0][_availablity],
            name, diseas[0][_valuediseas], _email, _password);
        print(
            "-----------------------RESPONSE SIGNUP----------------------------");
        print(response);
        print(
            "-----------------------Signup data--------------------------------");
        if (response['success'] == true) {
          var response = await apicall.userSignUp(_email, _password);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChooserList()));
        } else {
          //  showError("invalid username or password");
        }
      } catch (e) {
        showError("check ur internet");
        print(e);
      }
    }
  }
}
