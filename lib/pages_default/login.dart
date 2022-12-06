import 'package:catolica_mhc/pages_default/dashBoard.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController inputLogin = new TextEditingController();
  TextEditingController inputSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // Background da aplicação
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // Container da imagem (Logo)
              Container(
                // Logo do topo da página
                child: Image.asset(
                  'images/logo_catolica_branca.png',
                  width: 300,
                  height: 200,
                ),
              ),

              Container(
                child: Image.asset(
                  'images/logo_mhc_branca.png',
                  width: 90,
                  height: 130,
                ),
              ),

              Container(
                  height: 460,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  // TextFields de acesso
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextField(
                              // Textfield de usuário
                              style: TextStyle(
                                fontFamily: 'Alata',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.white,
                              controller: inputLogin,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 1.5)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 1.5)),
                                labelText: 'Digite a sua matrícula...',
                                hoverColor: Colors.white,
                              ),
                            ),


                            TextField(
                              // Textfield de usuário
                              style: TextStyle(
                                fontFamily: 'Alata',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              obscureText: true,
                              controller: inputSenha,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                suffixIconColor: Colors.white,
                                iconColor: Colors.white10,
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 1.5)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 1.5)),
                                labelText: 'Digite a sua senha...',
                                hoverColor: Colors.white,
                              ),
                            ),


                            ElevatedButton(
                              onPressed: () {
                                _validaCadastro();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.fromLTRB(140, 15, 140, 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPrimary: Color(0xFF720507),
                              ),

                              child: Text(
                                "ENTRAR",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Alata',
                                    color: Color(0xFF720507),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _validaCadastro() async{

    String banco_email = inputLogin.text;
    String senha_email = inputSenha.text;

    final QuerySnapshot result = await
    Future.value(FirebaseFirestore.instance.collection("usuarios_mhc").
    where("usu_email", isEqualTo: banco_email).limit(1).get()); //.limit(1).

    final List<DocumentSnapshot> documents = result.docs;

    documents.forEach((element) {
      if(element.get("usu_senha") == senha_email){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      }
    }
    );
  }
}