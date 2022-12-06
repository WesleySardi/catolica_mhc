import 'package:catolica_mhc/funcionalidades/cruds/entities/CertificadosCrud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../functions/appLogic.dart';
import 'dashBoard.dart';
import 'login.dart';
import 'notificacoes.dart';
import 'perfil.dart';

class Certificados extends StatefulWidget {
  const Certificados({Key? key}) : super(key: key);

  @override
  State<Certificados> createState() => _CertificadosState();
}

class _CertificadosState extends State<Certificados> {

  late List<String> instituicaoList = <String>[];
  late List<String> imgList = <String>[];
  late List<double> carga_horariaList = <double>[];
  late List<String> tipo_certificacaoList = <String>[];
  late List<String> statusList = <String>[];

  late int selectedOption = imgList.length+1;

  Future getCertificadosFirebase(List<String> instituicaoList, List<String> imgList, List<double> carga_horariaList, List<String> tipo_certificacaoList, List<String> statusList) async {

    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("certificados_mhc").get()); //.limit(1).

    final List<DocumentSnapshot> documents = result.docs;

    late String instituicao;
    late String img;
    late double carga_horaria;
    late String tipo_certificacao;
    late String status;

    documents.forEach((element) {
      instituicao = element.get("usu_instituicao").toString();
      instituicaoList.add(instituicao);

      img = element.get("uso_imagem").toString();
      imgList.add(img);

      carga_horaria = double.parse(element.get("usu_carga_horaria").toString());
      carga_horariaList.add(carga_horaria);

      status = element.get("usu_status").toString();
      statusList.add(status);

      tipo_certificacao = element.get("usu_tipo_certificado").toString();
      tipo_certificacaoList.add(tipo_certificacao);
    });
    setState(() {
      selectedOption = imgList.length+1;
    });
  }

  @override
  void initState() {
    getCertificadosFirebase(instituicaoList, imgList, carga_horariaList, tipo_certificacaoList, statusList);
    super.initState();
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
          physics: ScrollPhysics(),
          child: Container(
            child: Column(
              children: [
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
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: instituicaoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // daqui pra baixo editar VV
                          return SizedBox( // Transformar em outra coisa
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
                                    color: selectedOption == index ? Colors.cyan : Colors.white24,
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
                                                "images/certificado.jpg",
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
                                                'Instituicao: ${instituicaoList[index]}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.5,
                                                ),
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
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
                                                'Status: ${statusList[index]}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.5),
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
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
                                                'Carga Horária: ${carga_horariaList.toString()[index]}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.5),
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
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
                                                'Tipo de certificacao: ${tipo_certificacaoList[index]}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.5),
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
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
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                });
                              },
                            ),
                          );
                        }
                    )
                  ],
                ),
              ],
            ), // --------------------------------------------------------------------------------------------------
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
            ShowModal(context);
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
                          setState(() {
                            /*var collection = FirebaseFirestore.instance.collection('certificados_mhc');
                            collection.doc().set(
                                {
                                  'uso_imagem': "testetestetestetestetestetestetestetestetestetestetestetestetestetestetestetestetestetestetestetestetesteteste",
                                  'usu_carga_horaria': 42,
                                  'usu_id': 3,
                                  'usu_instituicao': "Centro Universitário Católica de Santa Catarina, vulgo Pontíficia Universidade Católica",
                                  'usu_motivo': "Porque o cidadão enviou o certificado repetidas vezes, ocasionando na invalidação do mesmo.",
                                  'usu_nome_do_curso': "Curso de Analise em porta aviões subaquáticos que são movidos a óleo",
                                  'usu_numero_de_matricula': 1234,
                                  'usu_status': "Enviado",
                                  'usu_tipo_certificado': "teste",
                                }
                            );
                            print("teste");*/
                          }
                          );
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