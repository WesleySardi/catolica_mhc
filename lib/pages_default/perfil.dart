import 'package:flutter/material.dart';
import 'certificados.dart';
import 'notificacoes.dart';
import 'dashBoard.dart';
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
      home: Perfil(),
    );
  }
}
*/
class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
                child: Image.asset(
                    "images/off_icon_preto.png",
                    width: 60,
                    height: 25
                )
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
                  'Perfil',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Color(0xFF720507),
                    radius: 50.0,
                    backgroundImage: AssetImage('images/user_icon.png'),
                  ),
                  Text(
                    "João Ferreira",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Text(
                    'Engenharia de Software',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(
                      height: 20.0,
                      child: Divider(
                          color: Color(0xFF720507) /*Color(0xFFb81317),*/
                          )),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Color(0xFF720507),
                      ),
                      title: Text(
                        "47 99999-9999",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Color(0xFF720507),
                      ),
                      title: Text(
                        "teste@gmail.com",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Color(0xFF720507),
                      ),
                      title: Text(
                        "************",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
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
            ))
    );
  }
}
