import 'package:flutter/material.dart';
import 'package:project/provider/apiprovider.dart';
import 'package:project/views/login.dart';
import 'package:project/widgets/firstAid.dart';
import 'package:project/widgets/firstAidPage.dart';
import 'package:project/widgets/selecting.dart';
import 'package:provider/provider.dart';
import 'package:marquee/marquee.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ApiProvider()),
  ], builder: (context, _) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedLang = 1;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 195, 129, 1),
        title: Center(child: Text("Health Managment")),
      ),
      body: Stack(children: [
        SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(
                top: screenHeight / 22,
                left: screenWidth / 15,
                bottom: screenHeight / 28),
            child: Text(
              "Services",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          GridView.count(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              mainAxisSpacing: screenHeight / 20,
              childAspectRatio: 1 / 1,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChooserList()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      color: Color.fromRGBO(17, 195, 129, 1),
                      elevation: 10,
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Users",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    height: screenHeight / 2.5,
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      color: Color.fromRGBO(17, 195, 129, 1),
                      elevation: 10,
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Service providers",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => News()));
                  },
                  child: Container(
                    height: screenHeight / 2.5,
                    margin: EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 10),
                    // margin: EdgeInsets.only(top: 100),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      color: Color.fromRGBO(17, 195, 129, 1),
                      elevation: 5,
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "News",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FirstAid()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      color: Color.fromRGBO(17, 195, 129, 1),
                      elevation: 5,
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "FIRST AID",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ]),
          Container(
            margin: EdgeInsets.only(top: screenHeight / 15),
            child: Center(
              child: DropdownButton<int>(
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
            ),
          )
        ])),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            height: 30,
            child: Marquee(
                //crossAxisAlignment: CrossAxisAlignment.end,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
                text:
                    " In order to prevent the transmission of Covid-19:- ● Wear a mask appropriately. ● Stay 6ft away from others. ● Get vaccinated. ● Avoid crowds and poorly ventilated areas. ● Wash your hands often. ● Cover coughs and sneezes. ● Clean and disinfect. ● Monitor your health daily."),
          ),
        ),
      ]),
    );
  }
}
