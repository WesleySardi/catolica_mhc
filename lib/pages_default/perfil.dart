import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:catolica_mhc/funcionalidades/crud_certificados/entities/UsuariosCrud.dart';
import '../functions/appLogic.dart';
import '../functions/imageWidget.dart';
import 'certificados.dart';
import 'login.dart';
import 'notificacoes.dart';
import 'dashBoard.dart';
import 'package:image_picker/image_picker.dart';

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 2,
      child: buildCircle(
        color: color,
        all: 5,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 18,
        ),
      ),
    );

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  Icon iconeFloatingButton = Icon(Icons.add);
  bool _activateFieldPhone = false;

  File? image; // Variável de armazenamento local

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
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
              ));
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
              ));
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Falha na obtenção da imagem: $e');
    }
  }

  UsuariosCrud user = UsuariosCrud(
      0,
      // ^^ Matricula
      '_usu_nome',
      '_usu_sobrenome',
      '_usu_email',
      '_usu_senha',
      '_usu_curso',
      '_uso_telefone',
      '_uso_img_perfil');

  Future<UsuariosCrud> getDataUser() async {
    user.usu_nome;
    user.usu_sobrenome;
    user.usu_email;
    user.usu_senha;
    user.usu_curso;
    user.uso_telefone;
    user.uso_img_perfil;
    await 100;
    return user;
  }

  // initialize the controllers
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  void initState() {
    super.initState();
    getDataUser();
    _controllerPhone.text = user.uso_telefone ?? "";
    _controllerEmail.text = user.usu_email ?? "";
    _controllerPassword.text = user.usu_senha ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFFC0090C);
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
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: const Text(
                  'Perfil',
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
                  image != null
                      ? ImageWidget(
                          image: image!,
                          onClicked: (source) => pickImage(source))
                      : InkWell(
                          child: Stack(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF720507),
                                    radius: 50.0,
                                    backgroundImage:
                                        AssetImage('images/user_icon.png')),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                child: buildEditIcon(color),
                              )
                            ],
                          ),
                          onTap: () => showImageSource(context)),
                  Text(
                    user.usu_nome ?? "",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Text(
                    user.usu_curso ?? "",
                    /*esse ??"" significa que se n tiver valor, ele deixa nulo*/
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(
                      height: 20.0,
                      child: Divider(
                          color: Color(0xFF720507) /*Color(0xFFb81317),*/
                          )),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Color(0xFF720507),
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              onChanged: (String value) =>
                                  iconeFloatingButton = Icon(Icons.edit),
                              controller: _controllerPhone,
                              obscureText: false,
                              enabled: _activateFieldPhone,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                label: Text('Telefone'),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_activateFieldPhone == false) {
                                    _activateFieldPhone = true;
                                  } else if (_activateFieldPhone == true &&
                                      _controllerPhone.text !=
                                          user.uso_telefone) {
                                    _activateFieldPhone = true;
                                    iconeFloatingButton = Icon(Icons.edit);
                                  } else {
                                    _activateFieldPhone = false;
                                    iconeFloatingButton = Icon(Icons.add);
                                  }
                                });
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Color(0xFF720507),
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _controllerEmail,
                              obscureText: false,
                              enabled: false,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                label: Text('Email'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Color(0xFF720507),
                          ),
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: _controllerPassword,
                                  obscureText: true,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text('Senha'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
        floatingActionButton: keyboardIsOpened
            ? null
            : FloatingActionButton(
                //Floating action button on Scaffold
                onPressed: () {
                  //code to execute on button press

                  // Segurança de edição
                  if (_controllerPhone.text != user.uso_telefone) {


                    /*
                     Editar os dados no banco aqui (função criada antes ou sei lá)
                     */


                    print('O botão mudou de função');
                  } else {
                    ShowModal(context);
                  }
                },
                child: iconeFloatingButton, //icon inside button
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

  void dispose() {
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
