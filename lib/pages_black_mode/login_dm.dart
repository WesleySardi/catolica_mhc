import 'package:catolica_mhc/pages_black_mode/cadastro_dm.dart';
import 'package:catolica_mhc/pages_black_mode/esqueceusenha_dm.dart';
import 'package:catolica_mhc/pages_default/cadastro.dart';
import 'package:catolica_mhc/pages_default/esqueceusenha.dart';
import 'package:flutter/material.dart';

class HomeDM extends StatefulWidget {
  const HomeDM({Key? key}) : super(key: key);

  @override
  State<HomeDM> createState() => _HomeDMState();
}

class _HomeDMState extends State<HomeDM> {
  TextEditingController inputLogin = new TextEditingController();
  TextEditingController inputSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // Background da aplicação
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_dark_mode.jpg'),
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
                  height: 270,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  // TextFields de acesso
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [


                      TextField(
                        // Textfield de usuário
                        style: TextStyle(
                          fontFamily: 'Alata',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
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
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: const EdgeInsets.fromLTRB(140, 15, 140, 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPrimary: Color(0xFF720507),
                        ),
                        onPressed: () {},
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Alata',
                              color: Color(0xFF720507),
                              fontWeight: FontWeight.bold),
                        ),
                      ),


                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EsqueciSenhaDM()),
                          );
                        },
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Alata'
                          ),
                        ),
                      ),
                    ],
                  )
              ),

              Container(
                  height: 182,
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CadastroDM()),
                      );
                    },
                    child: Text(
                      "Ainda não tem uma conta? Crie uma!",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Alata',
                        fontSize: 18,
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}