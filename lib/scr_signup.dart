import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_cadastro_cidadao_a.dart';
import 'package:app_de_saude/scr_cadastro_ouvidor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

  final _firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  cadastroUser(context,emailController,passwordController) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // O usuário foi criado com sucesso
      if (userCredential != null) {
        // Faça o que for necessário após o usuário ter sido criado
      }
      return 0;
    } on FirebaseAuthException catch (erro) {
      print(erro.hashCode);
      print(erro.code);
      print('*' + (erro?.message ?? '') + '*');
      // Lida com erros específicos do FirebaseAuth
      if(erro.message == 'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email inválido',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red,
            // Cor de fundo do SnackBar
            duration: Duration(seconds: 3),
            // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating,
            // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.message == 'An unknown error occurred: FirebaseError: Firebase: The email address is already in use by another account. (auth/email-already-in-use).') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'O email já está em uso',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red,
            // Cor de fundo do SnackBar
            duration: Duration(seconds: 3),
            // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating,
            // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.message == 'An unknown error occurred: FirebaseError: Firebase: An internal AuthError has occurred. (auth/internal-error).') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Não foi possível cadastrar. Verifique credenciais',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red,
            // Cor de fundo do SnackBar
            duration: Duration(seconds: 3),
            // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating,
            // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.message == 'An unknown error occurred: FirebaseError: Firebase: An internal AuthError has occurred. (auth/internal-error).') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Não foi possível cadastrar. Verifique credenciais',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red,
            // Cor de fundo do SnackBar
            duration: Duration(seconds: 3),
            // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating,
            // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.message == 'An unknown error occurred: FirebaseError: Firebase: Password should be at least 6 characters (auth/weak-password).') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'A senha deve ter pelo menos 6 caracteres',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red,
            // Cor de fundo do SnackBar
            duration: Duration(seconds: 3),
            // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating,
            // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }
      return 1;
    } catch (erro) {
      print(erro);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao criar usuário')),
      );
      return 1;
    }
    // try{
    //   UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    //   if(userCredential != null){
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => ScrCadastroCidadaoA(
    //           tipoUser: tipoUser,
    //           nome: nameController.text,
    //           email: emailController.text,
    //           senha: passwordController.text,
    //         ),
    //       ),
    //     );
    //   }
    // }on FirebaseAuthException catch(erro) {
    //   print(erro.hashCode);
    //   print(erro);
    // }
  }
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
                titleReclame(''),
                    //'Apenas algumas informações e seu cadastro estará pronto!'),
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
                  onPressed: () async {
                    int returnValue;
                    returnValue = await widget.cadastroUser(context,emailController,passwordController);
                    print(returnValue);
                    if (returnValue == 0) {
                      if (userOuvidor) {
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
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo, // Cor de fundo do botão
                    onPrimary: Colors.white, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Espaçamento interno do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Borda arredondada do botão
                    ),
                    textStyle: TextStyle(
                      fontSize: 18, // Tamanho do texto do botão
                      fontWeight: FontWeight.bold, // Peso da fonte do texto
                    ),
                  ),
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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
