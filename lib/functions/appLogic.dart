import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages_default/enviarCertificados.dart';

void ShowModal(BuildContext context) {
  //code to execute on button press
  //botao aparece as coisas
  showModalBottomSheet<void>(
    context: context,

    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
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