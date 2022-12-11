import 'package:catolica_mhc/pages_default/certificados.dart';
import 'package:catolica_mhc/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../functions/appLogic.dart';
import '../pages_default/notificacoes.dart';
import 'db_firestore.dart';

List<Map<String, String>> listaComDadosDosEstudantes = <Map<String, String>>[];
List<Map<String, String>> listaEstudanteAtual = <Map<String, String>>[];

Future getMatriculaUsuario(
    String? email,
    List<String> usu_curso,
    List<String> usu_email,
    List<String> usu_img_perfil,
    List<String> usu_nome,
    List<String> usu_senha,
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
    usu_senha.add(element.get('usu_senha'));
    usu_num_matricula.add(element.get('usu_num_matricula'));
    usu_sobrenome.add(element.get('usu_sobrenome'));
    usu_telefone.add(element.get('usu_telefone'));
  });
}

Future alterarSituacaoCertificado(List<int> idListNotificacoes) async {
  await getMatriculaUsuario(email, usu_curso, usu_email, usu_img_perfil, usu_nome, usu_senha, usu_num_matricula, usu_sobrenome, usu_telefone);
  FirebaseFirestore db = await DBFirestore.get();
  final QuerySnapshot result = await db.collection('certificados_mhc').where('cert_id',
      isEqualTo:idListNotificacoes[indexDoCertificadoSelecionadoNotificacoes]).get();
  final List<DocumentSnapshot> documents = result.docs;

  int idCertificadoNotificacoes = idListNotificacoes[indexDoCertificadoSelecionadoNotificacoes];

  documents.forEach((element) async {
    if(element.get('cert_id') == idCertificadoNotificacoes){
      String name_doc = result.docs.first.id;
      await db.collection('certificados_mhc').doc(name_doc).update({
        'cert_situacao_do_certificado': 'Pendente'
      }).then((value) => print("Documento Atualizado para Pendente"),
        onError: (e) => print("Erro atualizando o documento: $e"),);
    }
  });
}

void editarPerfil(String novo_numero_tel) async {
  FirebaseFirestore db = await DBFirestore.get();
  await getMatriculaUsuario(email,
      usu_curso,
      usu_email,
      usu_img_perfil,
      usu_nome,
      usu_senha,
      usu_num_matricula,
      usu_sobrenome,
      usu_telefone);

  final QuerySnapshot result = await db.collection('usuarios_mhc').where('usu_email', isEqualTo: email).get();
  final List<DocumentSnapshot> documents = result.docs;

  String nome_doc;

  documents.forEach((element) async {
    if(element.get('usu_email') == usu_email[0]) {
      nome_doc = result.docs.first.id;
      await db.collection('usuarios_mhc').doc(nome_doc).update({
            'usu_telefone': novo_numero_tel,
          }
      ).then((value) => print("Documento Atualizado"),
          onError: (e) => print("Erro atualizando o documento: $e"),);
    }
  });

}

void deletarCertificado(List<int> idListCertificado) async {
  FirebaseFirestore db = await DBFirestore.get();
  final QuerySnapshot result = await db.collection("certificados_mhc").get();
  final List<DocumentSnapshot> documents = result.docs;

  int idCertificado = idListCertificado[indexDoCertificadoSelecionadoCertificados];

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

}

void addCertificado(
    double cert_carga_horaria,
    String cert_img,
    String cert_instituicao,
    String cert_tipo_certificado,
    String cert_titulo) async {
  FirebaseFirestore db = await DBFirestore.get();
  await getMatriculaUsuario(email,
      usu_curso,
      usu_email,
      usu_img_perfil,
      usu_nome,
      usu_senha,
      usu_num_matricula,
      usu_sobrenome,
      usu_telefone);
  // Referencia ao documento remoto
  final QuerySnapshot result = await db.collection("certificados_mhc").get();
  final List<DocumentSnapshot> documents = result.docs;
  int id_do_certificado_novo = 1;

  documents.forEach((element) {
    id_do_certificado_novo++;
  });

  var docRef = await db.collection("certificados_mhc");

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

/*
  Adição de usuários é somente feita pela católica
 */
// void addUsuario() async {
//   FirebaseFirestore db = await DBFirestore.get();
//
//   var docRef = await db.collection('usuarios_mhc');
//
//   docRef
//       .doc()
//       .set({
//         'usu_curso': 'Engenharia de Software',
//         'usu_email': email,
//         'usu_img_perfil': 'https:// aaaaa',
//         'usu_nome': 'Usuario',
//         'usu_num_matricula': 123456789,
//         'usu_senha': 'teste123',
//         'usu_sobrenome': 'de Teste',
//         'usu_telefone': '(47) 91234-5678'
//       })
//       .then((value) => print("Deu certo!"))
//       .catchError((error) => print('Deu errado :( $error'));
// }
