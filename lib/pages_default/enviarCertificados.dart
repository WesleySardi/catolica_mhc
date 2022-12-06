import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../funcionalidades/cruds/entities/CertificadosCrud.dart';
import 'certificados.dart';
import 'dashBoard.dart';
import 'login.dart';
import 'notificacoes.dart';
import 'perfil.dart';

const List<String> list = <String>['Palestra', 'Estágio', 'Outros'];
// Aqui colocar dinamicamente quais são ou deixar estático, sei lá

/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAC-4 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnviarCertificados(),
    );
  }
}
*/
class EnviarCertificados extends StatefulWidget {
  const EnviarCertificados({Key? key}) : super(key: key);

  @override
  State<EnviarCertificados> createState() => _EnviarCertificadosState();
}

class _EnviarCertificadosState extends State<EnviarCertificados> {
  int _counter = 0;
  File? image; // Variável de armazenamento local

  String dropDownValue = list.first;

  // modal de foto pra iOS e Android
  Future<ImageSource?> showImageSource(BuildContext context) async {
    if(Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text('Câmera'),
                onPressed: () => pickImage(ImageSource.camera),
              ),
              CupertinoActionSheetAction(
                child: Text('Galeria'),
                onPressed: () => pickImage(ImageSource.gallery),
              ),
            ],
          )
      );
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Câmera'),
                onTap: () => pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Galeria'),
                onTap: () => pickImage(ImageSource.gallery),
              )
            ],
          )
      );
    }
  }

  /*
   Lógica pra abrir de onde vai pegar a foto e armazenar ela na variável local
   image, definida ali em cima ^^
  */
  Future pickImage(ImageSource source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Falha na obtenção da imagem: $e');
    }
  }

  // initialize the controllers
  TextEditingController _controllerDegreeName = TextEditingController();
  TextEditingController _controllerInstitution = TextEditingController();
  TextEditingController _controllerWorkload = TextEditingController();

  CertificadosCrud sendCertificate = CertificadosCrud(
      1, // estudante não define
      1234567, // estudante não define
      'Curso de Java',
      'Cursa Cursos Online',
      'tipo_do_certificado',
      'Em analise', // estudante não define
      40,
      'sem motivo', // estudante não define
      'https://via.placeholder.com/1920x1360?text=Adicione+seu+certificado...');

  Future<CertificadosCrud> getDataEnviarCertificados() async {
    sendCertificate.id;
    sendCertificate.numero_de_matricula;
    sendCertificate.nome_do_curso;
    sendCertificate.tipo_certificado;
    sendCertificate.status;
    sendCertificate.carga_horaria;
    sendCertificate.motivo;
    sendCertificate.imagem;
    await 100;
    return sendCertificate;
  }

  Future enviarCertificados(_controllerDegreeName, _controllerInstitution, _controllerWorkload, image, dropDownValue) async {
    var collection = FirebaseFirestore.instance.collection('certificados_mhc');
    collection.doc().set(
        {
          'usu_imagem': image,
          'usu_carga_horaria': _controllerWorkload.text,
          'usu_id': 1111,
          'usu_instituicao': _controllerInstitution.text,
          'usu_motivo': "Teste",
          'usu_nome_do_curso': _controllerDegreeName.text,
          'usu_numero_de_matricula': 0000,
          'usu_status': "Enviado",
          'usu_tipo_certificado': dropDownValue,
        }
    ).then((value) => print('Deu certo! --> '+collection.doc().toString())).catchError((error) => print('deu errado! $error'));
  }

  void initState(){
    super.initState();
    getDataEnviarCertificados();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

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
          child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: const Text(
                      'Enviar Certificado',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: const Text("Certificado:",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pacifico',
                                  )),
                            ),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset:
                                    Offset(3, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                // Image border
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(85), // Image radius
                                  child: InkWell(
                                    child: image != null ? Image.file(
                                      image!,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(sendCertificate.imagem,
                                      fit: BoxFit.cover,),
                                    onTap: () {
                                      showImageSource(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: const Text(
                                "Dados do certificado:",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 15,
                                          offset: Offset(
                                              9, 7), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      child: ListTile(
                                        title: TextField(
                                            controller: _controllerDegreeName,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                label: Text('Nome do Curso'),
                                                hintText: "Digite o nome do curso..."
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 15,
                                          offset: Offset(
                                              9, 7), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      child: ListTile(
                                        title: TextField(
                                            controller: _controllerInstitution,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                label: Text('Instituição'),
                                                hintText: "Digite o nome da instituição..."
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 15,
                                          offset: Offset(
                                              9, 7), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      child: ListTile(
                                        title: TextField(
                                            controller: _controllerWorkload,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                label: Text('Carga horária'),
                                                hintText: "Digite as horas do certificado..."
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 15,
                                          offset: Offset(
                                              9, 7), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      child: ListTile(
                                          title: DropdownButton<String>(
                                            value: dropDownValue,
                                            icon: const Icon(Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropDownValue = value!;
                                                print("Opção selecionada: $dropDownValue");
                                              });
                                            },
                                            items: list.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
        floatingActionButton: keyboardIsOpened ? null : FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {

            enviarCertificados(_controllerDegreeName, _controllerInstitution, _controllerWorkload, image, dropDownValue);

          },
          child: Icon(Icons.check), //icon inside button
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