import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:provider/provider.dart';

// class UserInfo extends StatefulWidget {
//   const UserInfo({Key? key}) : super(key: key);

//   @override
//   _UserInfoState createState() => _UserInfoState();
// }

// class _UserInfoState extends State<UserInfo> {
//   @override
  Widget Home(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Scaffold(
    //     appBar: AppBar(title: Text("Patients Info")),
    //     body: 
    return Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: size.height / 10,
                ),
                child: Center(
                    child: Text(
                  "Patients Message",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.green)),
              margin: EdgeInsets.only(
                  top: size.height / 20,
                  left: size.width / 10,
                  right: size.width / 10),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        Provider.of<ApiProvider>(context, listen: false)
                            .userName
                            .toString(),
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Text(
                      Provider.of<ApiProvider>(context, listen: false)
                          .userdata
                          .toString(),
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
  }

