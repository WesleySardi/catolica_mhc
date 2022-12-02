import 'package:catolica_mhc/pages_default/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home()
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Prototipo
  //Verificar a possibilidade de não precisar cria sempre que iniciar o app
  /*var collection_usuarios = FirebaseFirestore.instance.collection('usuarios_mhc');
  var collection_certificados = FirebaseFirestore.instance.collection('certificados_mhc');
  var collection_cursos = FirebaseFirestore.instance.collection('cursos_mhc');
  var collection_coordenadores = FirebaseFirestore.instance.collection('coordenadores_mhc');*/

  /*
  -----Prototipo do xingling que deu certo------

  var collection = FirebaseFirestore.instance.collection('usuarios_mhc');
  collection.doc().set(
      {
        'usu_curso':'Engenharia de Software',
        'usu_email':'teste@gmail.com',
        'usu_img_perfil':'https....',
        'usu_senha':'123454564',
        'usu_sobrenome':'Test',
        'usu_telefone':'(47)9994323',
        'usu_nome':'Teste',
        'usu_num_matricula': '4232341'
      }
  ).then((value) => print('Deu certo!')).catchError((error) => print('deu errado! $error'));*/
}