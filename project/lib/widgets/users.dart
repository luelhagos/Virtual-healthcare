import 'package:flutter/material.dart';
import 'package:project/model/doctors.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/patient.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    List<ItemForm> data1 =
        Provider.of<ApiProvider>(context, listen: false).kebeles;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Doctors"),
      ),
      body: GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          childAspectRatio: 11 / 10,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: data1.map((e) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Patient(e.name)));
                },
                child: GridTile(
                    child: Container(
                      child: Image.network(
                          "https://image.freepik.com/free-photo/portrait-smiling-handsome-male-doctor-man_171337-5055.jpg",
                          fit: BoxFit.fill),
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Column(
                        children: [
                          Text(e.name),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Description"),
                        ],
                      ),
                    )));
          }).toList()),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
