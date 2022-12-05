import 'package:flutter/material.dart';
import '../functions/appLogic.dart';
import '../application/main.dart';
import '../funcionalidades/crud_certificados/entities/student.dart';
import 'certificados.dart';
import 'login.dart';
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

  bool _activateFieldPhone = false,
      _activateFieldEmail = false,
      _activateFieldPassword = false;

  Student estudante = Student(
      degree: 'curso',
      email: 'email@gmail.com',
      name: 'nome',
      phone: 'telefone',
      password: 'senha');

  Future<Student> getDataStudent() async {
    estudante.degree = 'curso';
    estudante.email = 'email@gmail.com';
    estudante.name = 'nome';
    estudante.phone = '(47) 99999-9999';
    estudante.password = 'senha';
    await 100;
    return estudante;
  }

  // initialize the controllers
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  void initState() {
    super.initState();
    getDataStudent();
    _controllerPhone.text = estudante.phone ?? "";
    _controllerEmail.text = estudante.email ?? "";
    _controllerPassword.text = estudante.password ?? "";
  }

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
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                child: PopupMenuButton(
                    iconSize: 10,
                    icon: Image.asset("images/user_icon.png",
                        width: 80, height: 35),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(value: 0, child: Text('Logout')),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    }
                    ),
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
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF720507),
                    radius: 50.0,
                    backgroundImage: AssetImage('images/user_icon.png'),
                  ),
                  Text(
                    estudante.name ?? "",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Text(
                    estudante.degree ?? "",
                    /*esse ??"" significa que se n tiver valor, ele deixa nulo*/
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
                      title: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _controllerPhone,
                              obscureText: false,
                              enabled: _activateFieldPhone,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                label: Text('Telefone'),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_activateFieldPhone == false) {
                                    _activateFieldPhone = true;
                                  } else {
                                    _activateFieldPhone = false;
                                  }
                                });
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Color(0xFF720507),
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _controllerEmail,
                              obscureText: false,
                              enabled: _activateFieldEmail,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                label: Text('Email'),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_activateFieldEmail == false) {
                                    _activateFieldEmail = true;
                                  } else {
                                    _activateFieldEmail = false;
                                  }
                                });
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Color(0xFF720507),
                          ),
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: _controllerPassword,
                                  obscureText: true,
                                  enabled: _activateFieldPassword,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text('Senha'),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_activateFieldPassword == false) {
                                        _activateFieldPassword = true;
                                      } else {
                                        _activateFieldPassword = false;
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.edit)),
                            ],
                          ),
                        ),
                      ],
                    ),
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
            ShowModal(context);
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
                              MaterialPageRoute(
                                  builder: (context) => DashBoard()));
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
                              MaterialPageRoute(
                                  builder: (context) => Certificados()));
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
                              MaterialPageRoute(
                                  builder: (context) => Notificacoes()));
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
                              MaterialPageRoute(
                                  builder: (context) => Perfil()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  void dispose() {
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
