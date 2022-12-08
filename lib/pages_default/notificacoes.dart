import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../functions/appLogic.dart';
import '../application/main.dart';
import 'dashBoard.dart';
import 'login.dart';
import 'perfil.dart';

import 'certificados.dart';

class Notificacoes extends StatefulWidget {
  const Notificacoes({Key? key}) : super(key: key);

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  late List<String> tituloList = <String>[];
  late List<String> situacaoList = <String>[];
  late List<int> numero_de_matricula_usuList = <int>[];

  late int selectedOption = numero_de_matricula_usuList.length+1;

  @override
  void initState() {
    getCertificadosFirebase(tituloList, situacaoList, numero_de_matricula_usuList);
    super.initState();
  }

  Future getCertificadosFirebase(List<String> tituloList, List<String> situacaoList,  List<int> numero_de_matricula_usuList, ) async {

    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("certificados_mhc").get());

    final List<DocumentSnapshot> documents = result.docs;

    late String titulo;
    late int numero_de_matricula_usu;
    late String situacao;

    documents.forEach((element) {
      titulo = element.get("cert_titulo").toString();
      tituloList.add(titulo);

      numero_de_matricula_usu = element.get("cert_numero_de_matricula_usu");
      numero_de_matricula_usuList.add(numero_de_matricula_usu);

      situacao = element.get("cert_situacao_do_certificado").toString();
      situacaoList.add(situacao);
    });
    setState(() {
      selectedOption = numero_de_matricula_usuList.length+1;
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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: numero_de_matricula_usuList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(situacaoList[index] == "Pendente"){
                          return const SizedBox();
                        } else {
                          return SizedBox(
                            height: 110,
                            width: 400,
                            child: Container(
                                width: double.maxFinite,
                                //height: 65.0,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                                margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                                    Container(
                                        width: 300,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Certificado "'+tituloList[index]+'"',
                                                style: TextStyle(color: colorTextStyle, fontSize: 15),
                                                textAlign: TextAlign.start,
                                              ),
                                              Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                                              Text(
                                                situacaoList[index],
                                                style: TextStyle(color: Colors.red, fontSize: 15),
                                                textAlign: TextAlign.start,
                                              )
                                            ],
                                          ),
                                        )
                                    )
                                  ],
                                )),
                          );
                        }
                      }
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
