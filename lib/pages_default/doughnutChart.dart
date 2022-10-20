// Arquivo para entrada de dados do gráfico que se encontra
// na dashBoard inicial após feito o login
import 'dart:ui';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dashBoard.dart';

  final List<ChartData> chartData = [
    ChartData('Estágios', 60, Color.fromRGBO(9,0,136,1)),
    ChartData('Palestras', 15, Color.fromRGBO(147,0,119,1)),
    ChartData('Cursos', 25, Color.fromRGBO(228,0,124,1)),
    //ChartData('Outro aí', 57, Color.fromRGBO(255,189,57,1))
  ];

class ChartData {
  final String x; // Nome
  final double y; // Porcentagem
  final Color color;
  ChartData(this.x, this.y, this.color);
}