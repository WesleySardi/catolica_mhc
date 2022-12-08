import 'package:catolica_mhc/database/db_functions.dart';
import 'package:catolica_mhc/pages_default/enviarCertificados.dart';
import 'package:catolica_mhc/pages_default/login.dart';
import 'package:catolica_mhc/pages_default/perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../functions/appLogic.dart';
import '../services/auth_service.dart';
import 'certificados.dart';
import 'doughnutChart.dart';
import 'notificacoes.dart';

List<String> usu_curso = <String>[];
List<String> usu_email = <String>[];
List<String> usu_img_perfil = <String>[];
List<String> usu_nome = <String>[];
List<int> usu_num_matricula = <int>[];
List<String> usu_sobrenome = <String>[];
List<String> usu_telefone = <String>[];

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

//---------------------------------------------------------
class _DashBoardState extends State<DashBoard> {
  // Dados do estudante
  late TooltipBehavior _tooltipBehavior;

  late List<int> matriculaList = <int>[];

  late List<String> instituicaoList = <String>[];
  late List<String> imgList = <String>[];
  late List<double> carga_horariaList = <double>[];
  late List<String> tipo_certificacaoList = <String>[];
  late List<String> statusList = <String>[];
  late double percent = 0;

  late double somaDeCargaHorariaTeste = 0.0;
  late double somaDeCargaHorariaEstagio = 0.0;
  late double somaDeCargaHorariaPalestra = 0.0;
  late double somaDeCargaHorariaOutros = 0.0;


  @override
  void initState() {
    getMatriculaUsuario(AuthService.to.user.email, usu_curso, usu_email, usu_img_perfil, usu_nome, usu_num_matricula, usu_sobrenome, usu_telefone);
    getDefineDadosGrafico();

    getCertificadosFirebase(matriculaList, instituicaoList, imgList, carga_horariaList, tipo_certificacaoList, statusList);
    _tooltipBehavior =
        TooltipBehavior(enable: true, textStyle: const TextStyle(fontSize: 16));
    super.initState();
  }


//---------------------------------------------------------

  List<Map<String, String>> listaDeMap = <Map<String, String>>[];
  List<ChartData> chartData = <ChartData>[];

  // Pega os dados pro gráfico e organiza
  Future getDefineDadosGrafico() async {
    await getMatriculaUsuario(AuthService.to.user.email, usu_curso, usu_email, usu_img_perfil, usu_nome, usu_num_matricula, usu_sobrenome, usu_telefone);

    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("certificados_mhc").get());
    final List<DocumentSnapshot> documents = result.docs;

    late List<double> carga_horariaUsuario = <double>[];
    late List<String> tipo_certificadoUsuario = <String>[];

    // Pra cada documento dentro da collection usuarios_mhc
    documents.forEach((element) {
      if(element.get("cert_numero_de_matricula_usu") == usu_num_matricula[0]){
        carga_horariaUsuario.add(double.parse(element.get("cert_carga_horaria").toString()));
        // print("Carga Horaria: $carga_horariaUsuario");
        tipo_certificadoUsuario.add(element.get("cert_tipo_certificado").toString());
        // print("Tipo certificado: $tipo_certificadoUsuario");
      }
    });

    if(tipo_certificadoUsuario.length == carga_horariaUsuario.length){
      for(int i = 0; i < tipo_certificadoUsuario.length; i++){
        Map<String, String> mapTemp = {};

        mapTemp['tipo_certificado'] = tipo_certificadoUsuario[i];
        mapTemp['carga_horaria'] = carga_horariaUsuario[i].toString();

        listaDeMap.add(mapTemp);
      }

      for(int i = 0; i < listaDeMap.length; i++) {
        if(listaDeMap[i]['tipo_certificado'] == 'Outros'){
          somaDeCargaHorariaOutros += double.parse(listaDeMap[i]['carga_horaria']!);
          //print('somaDeCargaHorariaOutros: $somaDeCargaHorariaOutros');
        } else if(listaDeMap[i]['tipo_certificado'] == 'Estágio'){
          somaDeCargaHorariaEstagio += double.parse(listaDeMap[i]['carga_horaria']!);
          //print('somaDeCargaHorariaEstagio: $somaDeCargaHorariaEstagio');
        }
        else if(listaDeMap[i]['tipo_certificado'] == 'Palestra'){
          somaDeCargaHorariaPalestra += double.parse(listaDeMap[i]['carga_horaria']!);
          //print('somaDeCargaHorariaPalestra: $somaDeCargaHorariaPalestra');
        }
      }
    } else {
      throw Exception('Não passou na validação');
    }

    chartData = [
      ChartData("Outros", somaDeCargaHorariaOutros, Color.fromRGBO(9,0,136,1)),
      ChartData("Estágio", somaDeCargaHorariaEstagio, Color.fromRGBO(147,0,119,1)),
      ChartData("Palestra", somaDeCargaHorariaPalestra, Color.fromRGBO(228,0,124,1)),
    ];

    percent = calcularHorasFaltantes(somaDeCargaHorariaOutros, somaDeCargaHorariaEstagio, somaDeCargaHorariaPalestra);

    setState(() {});
  }
  
  // Pega os dados do certificado
  Future getCertificadosFirebase(List<int> matriculaList,List<String> instituicaoList, List<String> imgList, List<double> carga_horariaList, List<String> tipo_certificacaoList, List<String> statusList) async {

    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("certificados_mhc").get()); //.limit(1).

    final List<DocumentSnapshot> documents = result.docs;

    late int matriculaCertificado;

    late String instituicao;
    late String img;
    late double carga_horaria;
    late String tipo_certificacao;
    late String status;

    documents.forEach((element) {
      matriculaCertificado = element.get("cert_numero_de_matricula_usu");
      matriculaList.add(matriculaCertificado);

      instituicao = element.get("cert_instituicao").toString();
      instituicaoList.add(instituicao);

      img = element.get("cert_img").toString();
      imgList.add(img);

      carga_horaria = double.parse(element.get("cert_carga_horaria").toString());
      carga_horariaList.add(carga_horaria);

      status = element.get("cert_status").toString();
      statusList.add(status);

      tipo_certificacao = element.get("cert_tipo_certificado").toString();
      tipo_certificacaoList.add(tipo_certificacao);
    });
  }

  double calcularHorasFaltantes(double somaDeCargaHorariaOutros, double somaDeCargaHorariaEstagio, double somaDeCargaHorariaPalestra){
    double somaDasHoras = 0;
    double horasFaltantes = 0;
    double porcentagem = 0;

    somaDasHoras = somaDeCargaHorariaOutros + somaDeCargaHorariaEstagio + somaDeCargaHorariaPalestra;
    //print('somaDasHoras: $somaDasHoras');
    horasFaltantes = (somaDasHoras*100/238)/100;
    //print('horasFaltantes; $horasFaltantes');
    porcentagem = horasFaltantes;
    //print('porcentagem: $porcentagem');

    return porcentagem;
  }

  // Construção da dash
  @override
  Widget build(BuildContext context) {
    double valorTextoProgress = percent * 100;
    late String textoProgressBar = valorTextoProgress.toStringAsFixed(1);

    //addCertificado();
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
                AuthService.to.logout();
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
                      Navigator.pop(context);
                      AuthService.to.logout();
                    }
                  }),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                  alignment: FractionalOffset.topLeft,
                  margin: EdgeInsets.only(left: 40, top: 20, bottom: 15),
                  child: usu_nome.isEmpty ? const Center(child: CircularProgressIndicator()) : Text(
                    "Olá, \n ${'${usu_nome.first} ${usu_sobrenome.first}'}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  "Suas Estatísticas",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
               alignment: FractionalOffset.center,
               children: [
                 Container(
                   alignment: Alignment.bottomCenter,
                   child: SfCircularChart(
                     legend: Legend(
                       isVisible: true,
                       overflowMode: LegendItemOverflowMode.wrap,
                       position: LegendPosition.bottom,
                       textStyle: TextStyle(fontSize: 14),
                     ),
                     // Legenda abaixo do gráfico (default: direita)
                     tooltipBehavior: _tooltipBehavior,
                     series: <CircularSeries>[
                       // Renders doughnut chart
                       DoughnutSeries<ChartData, String>(
                         dataSource: chartData,
                         pointColorMapper: (ChartData data, _) => data.color,
                         xValueMapper: (ChartData data, _) => data.x,
                         yValueMapper: (ChartData data, _) => data.y,
                         radius: '100%',

                         dataLabelSettings: DataLabelSettings(
                           isVisible: false,
                           offset: Offset.fromDirection(1),
                           textStyle: TextStyle(fontSize: 16),
                         ),
                         enableTooltip: true,
                         //Liberando modificações Tooltip

                         explode:
                         true, //Clicar no gráfico destaca a sua estatística
                       ),
                     ],
                   ),

                   // Desenvolvimento de progress bar e resumo
                 ),
                 Positioned(
                   top: 88,
                     child: Container(
                       decoration: BoxDecoration(
                           color: Colors.green, shape: BoxShape.circle),
                       child: IconButton(
                         iconSize: 70,
                         onPressed: () {
                           ShowDialogResumoDashboard(context);
                         },
                         icon: Icon(Icons.pending_actions, size: 50,
                             color: Color.fromRGBO(255, 255, 255, 1.0)),
                       ),
                     ),
                 ),
               ]),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 23),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.6,
                      animation: true,
                      alignment: MainAxisAlignment.center,
                      barRadius: Radius.circular(10),
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: percent < 0 ? percent = 0 : percent,
                      center: Text(
                        '$textoProgressBar%',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.green, shape: BoxShape.circle),
                  //   child: IconButton(
                  //     iconSize: 70,
                  //     onPressed: () {
                  //       ShowDialogResumo(context);
                  //     },
                  //     icon: Icon(Icons.pending_actions, size: 50,
                  //         color: Color.fromRGBO(255, 255, 255, 1.0)),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
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
                      // Dashboard
                      setState(() {

                      });
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Perfil()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  // Modal Enviar certificado
  void ShowModal(BuildContext context) {
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
                                builder: (context) => EnviarCertificados()));
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
  }
}
