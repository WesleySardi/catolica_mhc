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

void addCertificado(
    /*Pegar os dados que serão inseridos e dps substituir*/) async {
  FirebaseFirestore db = await DBFirestore.get();

  // Referencia ao documento remoto
  var docRef = await db.collection('certificados_mhc');

  docRef
      .doc()
      .set({
        'cert_carga_horaria': 99999,
        'cert_coord_obs': 'testando pelo DBFirestore',
        'cert_id': 9999,
        'cert_img': 'imagem muito incrivel',
        'cert_instituicao': 'instituicao mt incrivel tbm',
        'cert_numero_de_matricula_usu': AuthService.to.user.email,
        'cert_situacao_do_certificado': 'Pendente',
        'cert_status': 'Enviado',
        'cert_tipo_certificado': 'Palestra',
        'cert_titulo': 'Curso incrivelmente legal'
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
