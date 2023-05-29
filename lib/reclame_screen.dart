import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_cadastro_cidadao_a.dart';
import 'package:app_de_saude/scr_cadastro_ouvidor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool userOuvidor = false;
  bool userCidadao = true;
  int tipoUser = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: backgroundColor(
          context: context,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                titleReclame(
                    'Apenas algumas informações e seu cadastro está pronto'),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              userOuvidor = true;
                              userCidadao = false;
                            });
                          },
                          child: Container(
                            width: userOuvidor ? 200 : 180,
                            height: userOuvidor ? 100 : 80,
                            decoration: BoxDecoration(
                            color: userOuvidor ? Colors.indigo : Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                          ),
                            child: Center(
                              child: Text(
                                'Cadastro Ouvidoria',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: userOuvidor ? 17 : 15,
                                  fontWeight: userOuvidor ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              userOuvidor = false;
                              userCidadao = true;
                            });
                          },
                          child: Container(
                            width: userCidadao ? 200 : 180,
                            height: userCidadao ? 100 : 80,
                            decoration: BoxDecoration(
                              color: userCidadao ? Colors.indigo : Colors.white24,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Cadastro Cidadão',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: userCidadao ? 17 : 15,
                                  fontWeight: userCidadao ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    campoForm(
                        nameController, TextInputType.name, false, 'Nome completo'),
                    campoForm(emailController, TextInputType.emailAddress, false,
                        'E-mail'),
                    campoForm(
                        passwordController, TextInputType.text, true, 'Senha'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (userOuvidor){
                      tipoUser = 0;
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrCadastroOuvidor(
                              tipoUser: tipoUser,
                              nome: nameController.text,
                              email: emailController.text,
                              senha: passwordController.text,
                            ),
                          ),
                        );
                      }
                    } else {
                      tipoUser = 1;
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrCadastroCidadaoA(
                              tipoUser: tipoUser,
                              nome: nameController.text,
                              email: emailController.text,
                              senha: passwordController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    fixedSize: MaterialStateProperty.all(Size.fromHeight(60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Já é cadastrado? ',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Faça login',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox botaoTipoCadastro(String nome, String descricao, Icon icone) {
  return SizedBox(
    width: 140,
    child: Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(140, 40), // Define a largura máxima do botão
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                nome,
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icone,
            ],
          ),
        ),
        Text(
          descricao,
          style: GoogleFonts.openSans(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
