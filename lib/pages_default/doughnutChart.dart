// Arquivo para entrada de dados do gráfico que se encontra
// na dashBoard inicial após feito o login
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dashBoard.dart';


// -- Obtenção de dados

// teste Pegar matricula
  late List<int> matriculaList = <int>[];

  // Map<int, List<String>> params = {
  //     'matriculaUsuario': null,
  //     'certificados': [],
  // } as Map<int, List<String>>;

  var listaMatriculaComCertificadosVinculados = {
    'matriculaUsuario': 0,
    'certificados': {
      'instituicao' : '',
      'img': '',
      'carga_horaria': 0,
      'tipo_certificado': '',
      'status': '',
      /*
      https://www.tutorialspoint.com/dart_programming/dart_programming_map.htm
      fiz com base nesse site aqui
       */
  }};

Future getUsuarioRelationFirebase(List<int> matriculaList) async {
  final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("usuarios_mhc").get()); //.limit(1).
  final List<DocumentSnapshot> documents = result.docs;

  late int matriculaUsuario;
  var matriculas;

  // Pra cada documento dentro da collection usuarios_mhc
  documents.forEach((element){

    // Pega a matricula do usuário
    matriculaUsuario = element.get("usu_num_matricula");

    // pra cada matricula em matriculaList (matriculas que estão na parte do certificado)
    for(matriculas in matriculaList){
      /*
        * checa se a matricula do usuário que pegou anteriormente,
        * é igual a matricula que está na collection de certificados
        * */
      if(matriculaUsuario == matriculas){
        listaMatriculaComCertificadosVinculados['matriculaUsuario'] = matriculaUsuario;
        listaMatriculaComCertificadosVinculados['certificados'] = {
          'instituicao': instituicaoList[matriculas],
          'img': imgList[matriculas],
          'carga_horaria': carga_horariaList[matriculas],
          'tipo_certificado': tipo_certificacaoList[matriculas],
          'status': statusList[matriculas],
        };
      }
    }
  });
}
// fim teste

  late List<String> instituicaoList = <String>[];
  late List<String> imgList = <String>[];
  late List<double> carga_horariaList = <double>[];
  late List<String> tipo_certificacaoList = <String>[];
  late List<String> statusList = <String>[];
  Future getCertificadosFirebase(List<int> matriculaList, List<String> instituicaoList, List<String> imgList, List<double> carga_horariaList, List<String> tipo_certificacaoList, List<String> statusList) async {

    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance.collection("certificados_mhc").get()); //.limit(1).

    final List<DocumentSnapshot> documents = result.docs;

    // Parte do teste pegar matricula
    late int matricula;
    //

    late String instituicao;
    late String img;
    late double carga_horaria;
    late String tipo_certificacao;
    late String status;

    documents.forEach((element) {
      matricula = element.get("usu_numero_de_matricula").toString() as int;
      matriculaList.add(matricula);

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
  }


// -- Fim obtenção de dados

  // final List<ChartData> chartData = [
  //   ChartData('Estágios', 300, Color.fromRGBO(9,0,136,1)),
  //   ChartData('Palestras', 15, Color.fromRGBO(147,0,119,1)),
  //   ChartData('Cursos', 20, Color.fromRGBO(228,0,124,1)),
  //   ChartData('Outros', 5, Color.fromRGBO(255,189,57,1)),
  // ];

class ChartData {
  final String x; // Nome
  final double y; // Porcentagem
  final Color color;
  ChartData(this.x, this.y, this.color);
}