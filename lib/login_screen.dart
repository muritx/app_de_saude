import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forget_password.dart';
import 'reclame_screen.dart';
import 'scr_main_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;

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
                titleReclame(null),
                Column(
                  children: [
                    campoForm(emailController, TextInputType.text, false,
                        'Informe E-mail'),
                    campoForm(passwordController, TextInputType.text, true,
                        'Informe sua senha'),
                    //botaoSubmit(context, _formKey, 'Entrar', login()),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        login();
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
                      child: Text('Entrar'),
                    ),
                    SizedBox(height: 15),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Esqueci a senha',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    linkCadastreSe(context),
                    footer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if(userCredential != null){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScrMainMenu(),
          ),
        );
      }
    }on FirebaseAuthException catch(erro){
      print(erro.hashCode);
      print(erro);
      if(erro.hashCode == 97258406){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Usuário Inexiste',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red, // Cor de fundo do SnackBar
            duration: Duration(seconds: 3), // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating, // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.hashCode == 276186007){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Informe a Senha',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red, // Cor de fundo do SnackBar
            duration: Duration(seconds: 3), // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating, // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.hashCode == 505314357){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Senha Inválida',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red, // Cor de fundo do SnackBar
            duration: Duration(seconds: 3), // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating, // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.hashCode == 276948968){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Informe o Email',
              style: TextStyle(
                fontSize: 16, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red, // Cor de fundo do SnackBar
            duration: Duration(seconds: 3), // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating, // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }else if(erro.hashCode == 121129892){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Usuário Bloqueado! Tente novamente mais tarde ou contate o administrador.',
              style: TextStyle(
                fontSize: 12, // Tamanho da fonte da mensagem
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
            backgroundColor: Colors.red, // Cor de fundo do SnackBar
            duration: Duration(seconds: 3), // Duração de exibição do SnackBar
            behavior: SnackBarBehavior.floating, // Comportamento do SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada do SnackBar
            ),
          ),
        );
      }
    }
  }

}

GestureDetector linkCadastreSe(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ),
      );
    },
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não tem conta? ',
              style: GoogleFonts.openSans(
                color: Colors.white,
              ),
            ),
            Text(
              'Cadastre-se',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Column footer() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SES-PE',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Secretaria\nEstadual de Saúde',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //Trocar para VerticalDivider
              height: 40,
              width: 2,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ],
  );
}

Column titleReclame(String? texto) {
  return Column(
    children: [
      Text(
        'Reclame',
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.w800,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              texto ?? '',
              style: GoogleFonts.openSans(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/images/mao.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    ],
  );
}

Container backgroundColor(
    {required BuildContext context, required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF5B8BDF),
          Color(0xFF00CCE5),
        ],
      ),
    ),
    height: MediaQuery.of(context).size.height,
    child: child,
  );
}

Padding campoForm(TextEditingController textEditingController,
    TextInputType tipoTeclado, bool esconderCaracteres, String textoDica) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
    child: TextFormField(
      validator: (String? value) {
        // Validador de campo vazio
        if (value != null && value.isEmpty) {
          return 'O campo não pode estar vazio!';
        }

        // Validador de email
        if (tipoTeclado == TextInputType.emailAddress &&
            value != null &&
            !isValidEmail(value)) {
          return 'Digite um email válido!';
        }

        // Validador de nome completo
        if (tipoTeclado == TextInputType.name &&
            value != null &&
            !hasMultipleWords(value)) {
          return 'Digite o nome completo!';
        }

        return null;
      },
      controller: textEditingController,
      keyboardType: tipoTeclado,
      obscureText: esconderCaracteres,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: textoDica,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19.0),
          borderSide: const BorderSide(
            color: Colors.indigo,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}

// Função auxiliar para verificar se o email é válido
bool isValidEmail(String email) {
  String pattern =
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}

// Função auxiliar para verificar se o nome completo tem mais de uma palavra
bool hasMultipleWords(String name) {
  List<String> words = name.trim().split(' ');
  return words.length > 1;
}

Padding botaoSubmit(
    BuildContext context, GlobalKey<FormState> formKey, String textoBotao, login()) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScrMainMenu(),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          primary: Colors.indigo,
        ),
        child: Text(
          textoBotao,
          style: GoogleFonts.openSans(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
