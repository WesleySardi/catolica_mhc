import 'package:flutter/material.dart';
import 'dashBoard.dart';
import 'perfil.dart';

import 'certificados.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAC-4 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Notificacoes(),
    );
  }
}
*/
class Notificacoes extends StatefulWidget {
  const Notificacoes({Key? key}) : super(key: key);

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            Container(
              child:
              Image.asset("images/user_icon.png", width: 80, height: 35),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: const Text(
                  'Notificações',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(3, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 400,
                    child: Container(
                        width: double.maxFinite,
                        height: 65.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                              style: BorderStyle.solid),
                          color: const Color(0xFFDFDFDF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset("images/warning.png",
                                  width: 15, height: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Certificado "Curso JAVA 40 horas" recusado.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Ver mais...',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
          },
          child: Icon(Icons.add), //icon inside button
          backgroundColor: Color(0xFFb81317),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floating action button position to center
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomAppBar(
                //bottom navigation bar on scaffold
                color: Colors.transparent,
                shape: const CircularNotchedRectangle(),
                //shape of notch
                notchMargin: 5,
                clipBehavior: Clip.antiAlias,
                //notche margin between floating button and bottom appbar
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFb81317), Color(0xFF720507)],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: [0.1, 0.8],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(
                    //children inside bottom appbar
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.home_filled,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DashBoard())
                            );*/
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Certificados())
                            );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.analytics,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Notificacoes())
                            );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Perfil())
                            );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
