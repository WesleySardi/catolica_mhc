import 'package:catolica_mhc/pages_default/login.dart';
import 'package:catolica_mhc/pages_default/perfil.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../functions/appLogic.dart';
import 'certificados.dart';
import 'doughnutChart.dart';
import 'notificacoes.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

//---------------------------------------------------------
class _DashBoardState extends State<DashBoard> {
  late TooltipBehavior _tooltipBehavior;

  String nome = 'Uéixley'; // Trocar depois pra pegar o nome do banco

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, textStyle: const TextStyle(fontSize: 16));
    super.initState();
  }

//---------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    getUsuarioRelationFirebase();
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
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
                  child: Text(
                    "Olá, \n${nome}!",
                    style: TextStyle(
                      fontSize: 30,
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
              Container(
                alignment: Alignment.bottomCenter,
                child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: Container(
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: IconButton(
                        iconSize: 70,
                        onPressed: () {
                          ShowDialogResumo(context);
                        },
                        icon: Icon(Icons.pending_actions,
                            size: 50,
                            color: Color.fromRGBO(255, 255, 255, 1.0)),
                      ),
                    ))
                  ],
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
                      percent: 0.5,
                      center: const Text(
                        "50.0%",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
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

      // Barra inferior antiga, descontinuada
      /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffb81317),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("img/home_icon_branco.png", height: 33,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("img/relatorio_icon_branco.png", height: 33,),
            label: "Certificados",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("img/btn_add.png", height: 43,),
            label: "Enviar",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("img/notification_icon_branco.png", height: 33,),
            label: "Notificações",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("img/usuario_icon_branco.png", height: 33,),
            label: "Perfil",
          ),
        ],
      ), */
    );
  }
}
