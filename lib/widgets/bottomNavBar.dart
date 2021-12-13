import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/widgets/doctorsSelectingList.dart';
import 'package:project/widgets/doctorspatient.dart';
import 'package:project/widgets/usersinfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool isloggedin = false;
  int _selectedIndex = 0;

  final List<Widget> _selectedWidget = [
    DoctorsSelectingList(),
    DoctorsPatient(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: new Scaffold(
        body: _selectedWidget[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orangeAccent,
          selectedFontSize: 15,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text(
                'Patient`s Info',
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
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
