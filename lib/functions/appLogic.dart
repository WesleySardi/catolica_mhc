import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages_default/enviarCertificados.dart';

void ShowModal(BuildContext context) {
  //code to execute on button press
  //botao aparece as coisas
  showModalBottomSheet<void>(
    context: context,

    elevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(50)
        ),
    ),
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
                        Text("Inserir certificado     ", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EnviarCertificados())
                      );
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
                      Text("Escanear certificado", style: TextStyle(fontSize: 20),),
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

Color colorTextStyle = Color.fromRGBO(17, 17, 17, 1.0);

Future<void> ShowDialogResumo(BuildContext context, List<String> instituicaoList, List<String> tipo_certificacaoList, List<double> carga_horariaList, List<String> statusList, List<String> imgList, int index) {
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
        content: Column(
          //mainAxisSize: MainAxisSize.min --> Deixa o pop-up menor, como um quadrado, igual o da dashboard
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Instituição: ${instituicaoList[index]}",
                  style: TextStyle(color: colorTextStyle),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Status: ${statusList[index]}",
                  style: TextStyle(color: colorTextStyle),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Carga horária: ${carga_horariaList[index]}",
                  style: TextStyle(color: colorTextStyle),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tipo de certificado: ${tipo_certificacaoList[index]}",
                  style: TextStyle(color: colorTextStyle),
                  textAlign: TextAlign.start,
                ),
              ),
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