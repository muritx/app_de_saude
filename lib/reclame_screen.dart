import 'package:app_de_saude/login_screen.dart';
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        botaoTipoCadastro(
                          'Ouvidor',
                          'Se deseja abrir reclamações',
                          const Icon(Icons.hearing, size: 25),
                        ),
                        botaoTipoCadastro(
                          'Cidadão',
                          'Se faz parte da equipe de ouvidoria da SES',
                          const Icon(Icons.person, size: 25),
                        ),
                      ],
                    ),
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
                    botaoSubmit(context, _formKey, 'Cadastre-se'),
                  ],
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
