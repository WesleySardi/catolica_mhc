import 'dart:io';
import 'dart:ui';

import 'dart:math';

import 'package:catolica_mhc/pages_default/certificados.dart';
import 'package:catolica_mhc/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'db_firestore.dart';

List<Map<String, String>> listaComDadosDosEstudantes = <Map<String, String>>[];
List<Map<String, String>> listaEstudanteAtual = <Map<String, String>>[];

Future getMatriculaUsuario(
    String? email,
    List<String> usu_curso,
    List<String> usu_email,
    List<String> usu_img_perfil,
    List<String> usu_nome,
    List<int> usu_num_matricula,
    List<String> usu_sobrenome,
    List<String> usu_telefone) async {

  FirebaseFirestore db = await DBFirestore.get();
  final QuerySnapshot result = await db.collection("usuarios_mhc").where('usu_email', isEqualTo: email).get();
  final List<DocumentSnapshot> documents = result.docs;

  documents.forEach((element) {
    usu_curso.add(element.get('usu_curso'));
    usu_email.add(element.get('usu_email'));
    usu_img_perfil.add(element.get('usu_img_perfil'));
    usu_nome.add(element.get('usu_nome'));
    usu_num_matricula.add(element.get('usu_num_matricula'));
    usu_sobrenome.add(element.get('usu_sobrenome'));
    usu_telefone.add(element.get('usu_telefone'));
  });
}

void editarPerfil(String novo_numero_tel) async {
  FirebaseFirestore db = await DBFirestore.get();
  await getMatriculaUsuario(AuthService.to.user.email,
      usu_curso,
      usu_email,
      usu_img_perfil,
      usu_nome,
      usu_num_matricula,
      usu_sobrenome,
      usu_telefone);

  var docRef = await db.collection("usuarios_mhc");

  docRef.doc().set({
    'usu_curso': usu_curso[0],
    'usu_email': usu_email[0],
    'usu_img_perfil': usu_img_perfil[0],
    'usu_nome': usu_nome[0],
    'usu_num_matricula': usu_num_matricula[0],
    'usu_sobrenome': usu_sobrenome[0],
    'usu_telefone': novo_numero_tel,
  });

}

void deletarCertificado(List<int> idList) async {

  FirebaseFirestore db = await DBFirestore.get();
  final QuerySnapshot result = await db.collection("certificados_mhc").get();
  final List<DocumentSnapshot> documents = result.docs;

  int idCertificado = idList[indexDoCertificadoSelecionado];

  // Firestore.instance.collection("chats").document("ROOM_1")
  //     .collection("messages").document(snapshot.data.documents[index]["id"])
  //     .delete();
  String nome_doc;


  documents.forEach((element) async {
    if(element.get('cert_id') == idCertificado){
      //result.docs.first.data();
      nome_doc = result.docs.first.id;
      await db.collection('certificados_mhc').doc(nome_doc).delete()
          .then((value) => print("Documento deletado"),
          onError: (e) => print("Erro deletando o documento: $e"),);
    }
  });

  print(result.docs.first.id);
}

void addCertificado(
    double cert_carga_horaria,
    String cert_img,
    String cert_instituicao,
    String cert_tipo_certificado,
    String cert_titulo) async {
  FirebaseFirestore db = await DBFirestore.get();
  await getMatriculaUsuario(AuthService.to.user.email,
      usu_curso,
      usu_email,
      usu_img_perfil,
      usu_nome,
      usu_num_matricula,
      usu_sobrenome,
      usu_telefone);
  // Referencia ao documento remoto
  final QuerySnapshot result = await db.collection("certificados_mhc").get();
  final List<DocumentSnapshot> documents = result.docs;
  int id_do_certificado_novo = 1;

  documents.forEach((element) {
    print('Antes de somar: $id_do_certificado_novo');
    id_do_certificado_novo++;
    print('Depois de somar: $id_do_certificado_novo');
  });

  var docRef = await db.collection("certificados_mhc");

  // print('cert_carga_horaria: $cert_carga_horaria');
  // print('cert_img: $cert_img');
  // print('cert_instituicao: $cert_instituicao');
  // print('cert_tipo_certificado: $cert_tipo_certificado');
  // print('cert_titulo: $cert_titulo');
  // Inserir no firebase

  docRef
      .doc()
      .set({
        'cert_carga_horaria': cert_carga_horaria,
        'cert_coord_obs': '',
        'cert_id': id_do_certificado_novo,
        'cert_img': cert_img,
        'cert_instituicao': cert_instituicao,
        'cert_numero_de_matricula_usu': usu_num_matricula[0],
        'cert_situacao_do_certificado': 'Enviado',
        'cert_status': 'Enviado',
        'cert_tipo_certificado': cert_tipo_certificado,
        'cert_titulo': cert_titulo
      })
      .then((value) => print("Deu certo!"))
      .catchError((error) => print('Deu errado :( $error'));
}

void addUsuario() async {
  FirebaseFirestore db = await DBFirestore.get();

  var docRef = await db.collection('usuarios_mhc');

  docRef
      .doc()
      .set({
        'usu_curso': 'Engenharia de Software',
        'usu_email': AuthService.to.user.email,
        'usu_img_perfil': 'https:// aaaaa',
        'usu_nome': 'Davi',
        'usu_num_matricula': 1315684,
        'usu_senha': 'a37476davi',
        'usu_sobrenome': 'Prudente Ferreira',
        'usu_telefone': '(47) 99958-5464'
      })
      .then((value) => print("Deu certo!"))
      .catchError((error) => print('Deu errado :( $error'));
}
