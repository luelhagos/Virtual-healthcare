import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/usersinfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorsSelectingList extends StatefulWidget {
  @override
  _DoctorsSelectingListState createState() => _DoctorsSelectingListState();
}

class _DoctorsSelectingListState extends State<DoctorsSelectingList> {
  int _valueregion = 1;
  int _valuelanguage = 1;
  int _valuediseas = 1;
  int _valueClinick = 1;
  late String _userData;
  TextEditingController _nameController = TextEditingController();
  loadStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _userData = sharedPreferences.getString(
      "emailset",
    )!;
  }

  loadID() {}
  List type = [
    {1: true, 2: false}
  ];
  @override
  void initState() {
    loadStorage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Chooser list",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: MediaQuery.of(context).size.height / 24,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(172, 226, 189, 1),
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.rectangle),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 2),
                          // width: 25,
                          // child: Image.asset("assets/addicon.png")),
                          child: Center(
                              child: Text("fill out the form and register"))),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width - (size.width / 1.5) - (20),
                      //height: size.height/10,
                   //   child: Expanded(
                        child: Text(
                          "Availablity",
                          style: TextStyle(fontSize: 17),
                        ),
                    //  ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            style: TextStyle(fontSize: 17, color: Colors.green),
                            value: _valuelanguage,
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
                                _valuelanguage = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width - (size.width / 1.5) - (20),
                      child: Expanded(
                        child: Text(
                          "Disease",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    // Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            style: TextStyle(fontSize: 17, color: Colors.green),
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
                  ],
                ),
              ),
              Container(
                height: size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width - (size.width / 1.5) - (20),
                      child: Expanded(
                        child: Text(
                          "name",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'enter name';
                              } else {
                                return null;
                              }
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(color: Colors.green),
                                labelText: "name"))),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 15,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: Colors.green,
                      elevation: 5,
                      child: Text("Register"),
                      onPressed: () {
                        signUp();
                      })),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.05,
              // ),
              // Container(
              //     width: MediaQuery.of(context).size.width / 1.3,
              //     height: MediaQuery.of(context).size.height / 15,
              //     child: RaisedButton(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: new BorderRadius.circular(25.0),
              //         ),
              //         color: Colors.green,
              //         elevation: 5,
              //         child: Text("Patient`s Info"),
              //         onPressed: () {
              //           signUp1();
              //         })),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
              SizedBox(height: 5),
            ],
          ),
        ));
  }

  signUp1() async {
    // var apicall = Provider.of<ApiProvider>(context, listen: false);
    // try {
    //   var response = await apicall.fetchDatauser();
    //   print(
    //       "-----------------------RESPONSE SIGNUP----------------------------");
    //   print(response);
    //   print(
    //       "-----------------------Signup data--------------------------------");
    //   if (response['success'] == true) {
    //     Navigator.pushReplacement(
    //     //    context, MaterialPageRoute(builder: (context) => UserInfo()));
    //   } else {
    //     //  showError("invalid username or password");
    //   }
    // } catch (e) {
    //   showError("check ur internet");
    //   print(e);
    // }
  }
  showSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successfuly Sent'),
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
    var apicall = Provider.of<ApiProvider>(context, listen: false);
    try {
      var response =
          await apicall.updateData(_userData, type[0][_valuelanguage]);
      print(
          "-----------------------RESPONSE SIGNUP----------------------------");
      print(response);
      print(
          "-----------------------Signup data--------------------------------");
      if (response['success'] == true) {
        showSuccess();
      } else {
        showError("invalid username or password");
      }
    } catch (e) {
      showError("check ur internet");
      print(e);
    }
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
}
