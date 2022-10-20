import 'package:flutter/material.dart';
import 'dashBoard.dart';
import 'perfil.dart';
import 'certificados.dart';
import 'notificacoes.dart';
/*
void main() {
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
      home: EnviarCertificados(),
    );
  }
}
*/
class EnviarCertificados extends StatefulWidget {
  const EnviarCertificados({Key? key}) : super(key: key);

  @override
  State<EnviarCertificados> createState() => _EnviarCertificadosState();
}

class _EnviarCertificadosState extends State<EnviarCertificados> {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Image.asset("images/off_icon_preto.png",
                    width: 60, height: 25),
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
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: const Text(
                  'Enviar Certificado',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Pacifico'),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: const Text("Certificado:",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pacifico',
                              )),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(3, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(85), // Image radius
                              child: Image.asset("images/certificado.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                          child: const Text(
                            "Dados do certificado:",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(
                                          9, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: ListTile(
                                      title: const Text(
                                        "Nome:",
                                        style: TextStyle(
                                          color: Color(0xFF720507),
                                          fontSize: 16.0,
                                          fontFamily: "Source Sans Pro",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: const Text(
                                            "Curso JAVA 40 horas",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: "Source Sans Pro",
                                            ),
                                          ))),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(
                                          9, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: ListTile(
                                      title: const Text(
                                        "Instituição:",
                                        style: TextStyle(
                                          color: Color(0xFF720507),
                                          fontSize: 16.0,
                                          fontFamily: "Source Sans Pro",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: const Text(
                                            "Universidade PUC-SC",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: "Source Sans Pro",
                                              //fontWeight: FontWeight.bold,
                                            ),
                                          ))),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(
                                          9, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: ListTile(
                                      title: const Text(
                                        "Carga Horária:",
                                        style: TextStyle(
                                          color: Color(0xFF720507),
                                          fontSize: 16.0,
                                          fontFamily: "Source Sans Pro",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: const Text(
                                            "50 horas",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: "Source Sans Pro",
                                              //fontWeight: FontWeight.bold,
                                            ),
                                          ))),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DashBoard())
                            );
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
