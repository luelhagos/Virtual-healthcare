import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/doctorspatientHome.dart';
import 'package:project/widgets/usersinfo.dart';
import 'package:provider/provider.dart';

class DoctorsPatient extends StatefulWidget {
  const DoctorsPatient({Key? key}) : super(key: key);

  @override
  _DoctorsPatientState createState() => _DoctorsPatientState();
}

class _DoctorsPatientState extends State<DoctorsPatient> {
  signUp1() async {
    var apicall = Provider.of<ApiProvider>(context, listen: false);
    try {
      var response = await apicall.fetchDatauser();
      if (response['success'] == true) {
        return true;
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => UserInfo()));
      } else {
        return false;
        //  showError("invalid username or password");
      }
    } catch (e) {
      // showError("check ur internet");
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: signUp1(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(title: Text("Patients Info")),
              body: Home(context));
        }
        //route to next view
        // Timer(Duration(seconds: 1), () {
        //   Navigator.pushReplacement(
        //       context, MaterialPageRoute(builder: (context) => UserInfo()));
        //   });
        // return Scaffold(
        //   body: Center(child: Text("Done Loading")),
        //  );
        //}
        else {
          // show loading view
          return Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      });
}
