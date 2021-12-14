import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/users.dart';
import 'package:provider/provider.dart';

class ChooserList extends StatefulWidget {
  @override
  ChooserListState createState() => ChooserListState();
}

class ChooserListState extends State<ChooserList> {
  int _valueregion = 1;
  int _valuelanguage = 1;
  int _valuediseas = 1;
  int _valueClinick = 1;

  List diseas = [
    {1: "Malaria", 2: "Blharzia", 3: "HIV", 4: "HeadAche"}
  ];

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
                          child: Center(
                              child: Text("fill out the form and search"))),
                    ],
                  )),
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
                   //   child: Expanded(
                        child: Text(
                          "Disease",
                          style: TextStyle(fontSize: 17),
                        ),
                     // ),
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
                      child: Text("Search"),
                      onPressed: () async {
                        var apicall =
                            Provider.of<ApiProvider>(context, listen: false);
                        try {
                          var response =
                              await apicall.fetchData(diseas[0][_valuediseas]);
                          print(response);
                          if (response['success'] == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Users()));
                          } else {
                            //  showError("invalid username or password");
                          }
                        } catch (e) {
                          showError("check ur internet");
                          print(e);
                        }
                      })),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
              SizedBox(height: 5),
            ],
          ),
        ));
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
