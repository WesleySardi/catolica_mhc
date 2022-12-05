import 'package:catolica_mhc/funcionalidades/cruds/entities/CertificadosCrud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../functions/appLogic.dart';
import 'dashBoard.dart';
import 'login.dart';
import 'notificacoes.dart';
import 'perfil.dart';

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
      home: Certificados()
    );
  }
}
*/
class Certificados extends StatefulWidget {
  const Certificados({Key? key}) : super(key: key);

  @override
  State<Certificados> createState() => _CertificadosState();
}

Column criarContainersCertificados(String instituicao, String img, double carga_horaria, String tipo_certificacao, String status, tam) {
  return Column(
    children: [
      for(int i = 0; i < tam; i++)
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: const Text(
            'Certificados',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(
          width: 400,
          child: InkWell(
            child: Container(
                width: double.maxFinite,
                height: 130.0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10.0),
                margin: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                      style: BorderStyle.solid),
                  color: Colors.cyan,/*selectedOption == true
                ? Colors.cyan
                : const Color(0xFFDFDFDF),*/
                  //const Color(0xFFDFDFDF)
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset:
                      Offset(3, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                        padding:
                        const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(55),
                            // Image radius
                            child: Image.asset(
                              img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        Container(
                          margin:
                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            child: Text(
                              'Instituicao: '+instituicao,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            child: Text(
                              'Status: '+status,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            child: Text(
                              'Carga Horária: '+carga_horaria.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            child: Text(
                              'Tipo de certificacao: '+tipo_certificacao,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin:
                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            child: Text(
                              'Ver mais...',
                              textAlign: TextAlign.end,
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
            onTap: () {
              /*setState(() {
          if (selectedOption == true) {
            selectedOption = false;
          } else {
            selectedOption = true;
          }
        });*/
            },
          ),
        )],
      ),
    ],
  );
}

Future _getCertificadosFirebase() async {

  final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("certificados_mhc").get()); //.limit(1).

  final List<DocumentSnapshot> documents = result.docs;

  String instituicao;
  String img;
  double carga_horaria;
  String tipo_certificacao;
  String status;
  int tam = documents.length;

  documents.forEach((element) {
    instituicao = element.get("usu_instituicao").toString();
    img = element.get("uso_imagem").toString();
    carga_horaria = double.parse(element.get("usu_carga_horaria").toString());
    status = element.get("usu_status").toString();
    tipo_certificacao = element.get("usu_tipo_certificado").toString();

    criarContainersCertificados(instituicao, img, carga_horaria, tipo_certificacao, status);
  });
}

void _validaCadastro() async{

  String banco_email = "EMAIL QUE O USUARIO DIGITA";

  final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("usuarios_mhc").
  where("usu_email", isEqualTo: banco_email).limit(1).get()); //.limit(1).

  final List<DocumentSnapshot> documents = result.docs;

  documents.forEach((element) {
    if(element.get("usu_senha") == "SENHA QUE O USUARIO DIGITA"){
      print("Deu certo a validação!");
    }else {
      print("Usuário ou senha inválidos!");
    }
    //print(element.get("usu_nome").toString());
  });
}

class _CertificadosState extends State<Certificados> {
  bool _visible = true;
  int _counter = 0;
  bool selectedOption = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

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
                child:
                Image.asset("images/user_icon.png", width: 80, height: 35),
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
              child: ),
        ),
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
            ShowModal(context);
            _getCertificadosFirebase();
          },
          child: Icon(selectedOption == true ? Icons.edit : Icons.add),
          //icon inside button
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
}
