import 'package:app_de_saude/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleReclame(null),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    'Digite seu e-mail, CPF ou matrícula e enviaremos um link para gerar uma nova senha.',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    campoForm(emailController, TextInputType.text, false,
                        'Informe CPF, Matrícula ou E-mail'),
                    botaoSubmit(context,_formKey,'Esqueceu a senha'),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Voltar',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                linkCadastreSe(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
