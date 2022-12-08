import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages_default/enviarCertificados.dart';
import '../database/db_functions.dart';
import '../services/auth_service.dart';


/*void ShowModal(BuildContext context) {
  //code to execute on button press
  //botao aparece as coisas
  showModalBottomSheet<void>(
    context: context,
    elevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    builder: (BuildContext context) {
      return Container(
        height: 200,
        child: Center(
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shape: StadiumBorder(),
                        minimumSize: Size(300, 43),
                        maximumSize: Size(300, 43),
                        backgroundColor: Colors.red[900]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add_chart_sharp),
                        Text("Inserir certificado     ",
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnviarCertificados(matricula: widget.matricula)));
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: StadiumBorder(),
                      minimumSize: Size(300, 43),
                      maximumSize: Size(300, 43),
                      backgroundColor: Colors.red[900]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.camera_enhance),
                      Text(
                        "Escanear certificado",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}*/ // void show modal

String? email = AuthService.to.user.email;
List<String> usu_curso = <String>[];
List<String> usu_email = <String>[];
List<String> usu_img_perfil = <String>[];
List<String> usu_nome = <String>[];
List<int> usu_num_matricula = <int>[];
List<String> usu_sobrenome = <String>[];
List<String> usu_telefone = <String>[];

late double somaDeCargaHorariaTeste = 0.0;
late double somaDeCargaHorariaEstagio = 0.0;
late double somaDeCargaHorariaPalestra = 0.0;
late double somaDeCargaHorariaOutros = 0.0;

List<double> somasList = <double>[];

Color colorTextStyle = Color.fromRGBO(17, 17, 17, 1.0);
Color colorTextStyle_titles = Color.fromRGBO(255, 0, 0, 1.0);

List<Map<String, String>> listaDeMap = <Map<String, String>>[];

Future getDefineDadosModal() async {
  await getMatriculaUsuario(email, usu_curso, usu_email, usu_img_perfil, usu_nome, usu_num_matricula, usu_sobrenome, usu_telefone);


  final QuerySnapshot result = await Future.value(
      FirebaseFirestore.instance.collection("certificados_mhc").get());
  final List<DocumentSnapshot> documents = result.docs;

  late List<double> carga_horariaUsuario = <double>[];
  late List<String> tipo_certificadoUsuario = <String>[];

  // Pra cada documento dentro da collection usuarios_mhc
  documents.forEach((element) {
    if (element.get("cert_numero_de_matricula_usu") == usu_num_matricula[0]) {
      carga_horariaUsuario.add(
          double.parse(element.get("cert_carga_horaria").toString()));
      // print("Carga Horaria: $carga_horariaUsuario");
      tipo_certificadoUsuario.add(
          element.get("cert_tipo_certificado").toString());
      // print("Tipo certificado: $tipo_certificadoUsuario");
    }
  });

  if (tipo_certificadoUsuario.length == carga_horariaUsuario.length) {
    for (int i = 0; i < tipo_certificadoUsuario.length; i++) {
      Map<String, String> mapTemp = {};

      mapTemp['tipo_certificado'] = tipo_certificadoUsuario[i];
      mapTemp['carga_horaria'] = carga_horariaUsuario[i].toString();

      listaDeMap.add(mapTemp);
    }

    for (int i = 0; i < listaDeMap.length; i++) {
      if (listaDeMap[i]['tipo_certificado'] == 'Outros') {
        somaDeCargaHorariaOutros +=
            double.parse(listaDeMap[i]['carga_horaria']!);
        //print('somaDeCargaHorariaOutros: $somaDeCargaHorariaOutros');
      } else if (listaDeMap[i]['tipo_certificado'] == 'Estágio') {
        somaDeCargaHorariaEstagio +=
            double.parse(listaDeMap[i]['carga_horaria']!);
        //print('somaDeCargaHorariaEstagio: $somaDeCargaHorariaEstagio');
      }
      else if (listaDeMap[i]['tipo_certificado'] == 'Palestra') {
        somaDeCargaHorariaPalestra +=
            double.parse(listaDeMap[i]['carga_horaria']!);
        //print('somaDeCargaHorariaPalestra: $somaDeCargaHorariaPalestra');
      }
    }
  } else {
    throw Exception('Não passou na validação');
  }

  retornarValores(somaDeCargaHorariaOutros, somaDeCargaHorariaEstagio, somaDeCargaHorariaPalestra);

}

void retornarValores(double somaDeCargaHorariaOutros, double somaDeCargaHorariaEstagio, double somaDeCargaHorariaPalestra) {
  double somaOutros = 0.0;
  double somaEstagio = 0.0;
  double somaPalestra = 0.0;

  somaOutros = somaDeCargaHorariaOutros;
  somaEstagio = somaDeCargaHorariaEstagio;
  somaPalestra = somaDeCargaHorariaPalestra;

  somasList.add(somaOutros);
  somasList.add(somaEstagio);
  somasList.add(somaPalestra);

}

Future<void> ShowDialogResumoCertificado(BuildContext context, List<String> tituloList, List<String> instituicaoList, List<String> coord_obsList, List<String> imgList, List<double> carga_horariaList, List<String> tipo_certificacaoList, List<String> statusList, int index) {
  String tempObsCoordenador = coord_obsList[index];
  String tempStatus = statusList[index];

  if(coord_obsList[index] == "") {
    tempObsCoordenador = "Sem observações por enquanto";
  }

  if(statusList[index] == "") {
    tempStatus = "Status indefinido";
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        //contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        title: Text(
          'Resumo',
          textAlign: TextAlign.center,
          style: TextStyle(color: colorTextStyle, fontWeight: FontWeight.bold),
        ),
        content:
        Column(
          //mainAxisSize: MainAxisSize.min, --> Deixa o pop-up menor, como um quadrado, igual o da dashboard
          children: [
            Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  child: Image.asset(
                      'images/certificado.jpg',
                      height: 200,
                      fit: BoxFit.cover
                  ),
                )
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                height: 300,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Titulo",
                                style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3)
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
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Instituição",
                                style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3)
                              ),
                              Text(
                                instituicaoList[index],
                                style: TextStyle(color: colorTextStyle),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Observação do Coordenador",
                                style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3)
                              ),
                              Text(
                                //coord_obsList[index],
                                tempObsCoordenador,
                                style: TextStyle(color: colorTextStyle),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Carga horária",
                                style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3)
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
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Tipo de certificado",
                                style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3)
                              ),
                              Text(
                                tipo_certificacaoList[index],
                                style: TextStyle(color: colorTextStyle),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(color: colorTextStyle_titles, fontWeight: FontWeight.bold, fontSize: 17),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3)
                              ),
                              Text(
                                //statusList[index],
                                tempStatus,
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
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,
            ),
            child: const Text(
              'Fechar',
              style: TextStyle(
                  color: Color.fromRGBO(255, 0, 0, 1.0),
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Dashboard
Future<void> ShowDialogResumoDashboard(BuildContext context) async {

  await getDefineDadosModal();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        title: Text(
          'Resumo',
          textAlign: TextAlign.center,
          style: TextStyle(color: colorTextStyle, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Estágio:",
                    style: TextStyle(color: colorTextStyle),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('${somasList[1]}',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: colorTextStyle)),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Outros:",
                    style: TextStyle(color: colorTextStyle),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('${somasList[0]}',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: colorTextStyle)),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Palestras:",
                    style: TextStyle(color: colorTextStyle),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('${somasList[2]}',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: colorTextStyle)),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Fechar',
              style: TextStyle(
                  color: Color.fromRGBO(255, 0, 0, 1.0),
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


