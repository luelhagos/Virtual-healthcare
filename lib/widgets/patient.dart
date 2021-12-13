import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:provider/provider.dart';

class Patient extends StatefulWidget {
  String name;
  Patient(this.name);

  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Patient Information"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 60,
            ),
            child: Center(
                child: Text(
              "patient data",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: TextField(
              controller: _textEditingController,
              maxLines: null,
            ),
          ),
          SizedBox(height: 22),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
            onPressed: signUp,
            child: Text('Send',
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
    );
  }

  signUp() async {
    {
      var apicall = Provider.of<ApiProvider>(context, listen: false);
      try {
        var response = await apicall.userPersonalInfo(
            widget.name, _textEditingController.text.toString());
        print(
            "-----------------------RESPONSE SIGNUP----------------------------");
        print(response);
        print(
            "-----------------------Signup data--------------------------------");
        if (response['success'] == true) {
          showSuccess();
          //  Navigator.pushReplacement(
          //    context, MaterialPageRoute(builder: (context) => ChooserList()));
        } else {
          showError("invalid username or password");
        }
      } catch (e) {
        showError("check ur internet");
        print(e);
      }
    }
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
