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

  late List<String> tituloList = <String>[];
  late List<String> instituicaoList = <String>[];
  late List<String> imgList = <String>[];
  late List<double> carga_horariaList = <double>[];
  late List<String> tipo_certificacaoList = <String>[];
  late List<String> statusList = <String>[];
  late List<String> coord_obsList = <String>[];
  late List<String> situacaoList = <String>[];

  late int selectedOption = imgList.length+1;

  @override
  void initState() {
    getCertificadosFirebase(tituloList, instituicaoList, coord_obsList, imgList, carga_horariaList, tipo_certificacaoList, statusList, situacaoList);
    super.initState();
  }

  Future getCertificadosFirebase(List<String> tituloList, List<String> instituicaoList, List<String> coord_obsList, List<String> imgList, List<double> carga_horariaList, List<String> tipo_certificacaoList, List<String> statusList, List<String> situacaoList) async {

    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("certificados_mhc").get());

    final List<DocumentSnapshot> documents = result.docs;

    late String titulo;
    late String img;
    late double carga_horaria;
    late String tipo_certificacao;
    late String status;
    late String instituicao;
    late String coord_obs;
    late String situacao;

    documents.forEach((element) {
      titulo = element.get("cert_titulo").toString();
      tituloList.add(titulo);

      img = element.get("cert_img").toString();
      imgList.add(img);

      instituicao = element.get("cert_instituicao").toString();
      instituicaoList.add(instituicao);

      coord_obs = element.get("cert_coord_obs").toString();
      coord_obsList.add(coord_obs);

      carga_horaria = double.parse(element.get("cert_carga_horaria").toString());
      carga_horariaList.add(carga_horaria);

      status = element.get("cert_status").toString();
      statusList.add(status);

      tipo_certificacao = element.get("cert_tipo_certificado").toString();
      tipo_certificacaoList.add(tipo_certificacao);

      situacao = element.get("cert_situacao_do_certificado").toString();
      situacaoList.add(situacao);
    });
    setState(() {
      selectedOption = imgList.length+1;
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
                          return SizedBox(
                            child: InkWell(
                              child: Container(
                                  width: double.maxFinite,
                                  height: 130.0,// ----> Sem o height ele deixa a caixa do tamanho que os componentem ocuparem, se utilizar ele trava o tamanho conforme o digitado
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
                                          )
                                      ),
                                      Container(
                                        width: 200,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget> [
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "Titulo",
                                                          style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 15),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 3)
                                                        ),
                                                        Text(
                                                          tituloList[index],
                                                          style: TextStyle(color: colorTextStyle),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "Carga horária",
                                                          style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 15),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 3)
                                                        ),
                                                        Text(
                                                          carga_horariaList[index].toString(),
                                                          style: TextStyle(color: colorTextStyle),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "Situação",
                                                          style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 15),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 3)
                                                        ),
                                                        Text(
                                                          situacaoList[index],
                                                          style: TextStyle(color: colorTextStyle),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "Status",
                                                          style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 15),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 3)
                                                        ),
                                                        Text(
                                                          //statusList[index],
                                                          statusList[index],
                                                          style: TextStyle(color: colorTextStyle),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                  ShowDialogResumo(context, tituloList, instituicaoList, coord_obsList, imgList, carga_horariaList, tipo_certificacaoList, statusList, index);
                                });//${instituicaoList[index]}
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
            // var collection = FirebaseFirestore.instance.collection('certificados_mhc');
            // collection.doc().set(
            //     {
            //        'cert_img': "",
            //        'cert_carga_horaria': 40,
            //        'cert_id': 1,
            //        'cert_instituicao': "Centro Universitário Católica de Santa Catarina, vulgo Pontíficia Universidade Católica",
            //        'cert_coord_obs': "Porque o cidadão enviou o certificado repetidas vezes, ocasionando na invalidação do mesmo.",
            //        'cert_titulo': "Curso de Java da Udemy",
            //        'cert_numero_de_matricula_usu': 1234567,
            //        'cert_status': "Enviado",
            //        'cert_tipo_certificado': "Palestra",
            //     }
            // );
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
