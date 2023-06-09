import 'package:app_de_saude/scr_signup.dart';
import 'package:app_de_saude/scr_cadastro_cidadao_a.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ScrCadastroOuvidor extends StatefulWidget {
  final int? tipoUser;
  final String? nome;
  final String? email;
  final String? senha;
  final _firebaseAuth = FirebaseAuth.instance;

  ScrCadastroOuvidor({
    Key? key,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipoUser,
  }) : super(key: key){
    emailController.text = email ?? '';
    passwordController.text = senha ?? '';
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<ScrCadastroOuvidor> createState() => _ScrCadastroOuvidorState();

  removeUser(context) async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if(userCredential != null){
        User? user = FirebaseAuth.instance.currentUser;
        try {
          await user?.delete();
        } catch (e) {
          print(e);
        }
      }
    }on FirebaseAuthException catch(erro) {
      print(erro.hashCode);
      print(erro);
    }
  }

  loginUser(context) async {
  //   try {
  //     UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //
  //     // O usuário foi criado com sucesso
  //     if (userCredential != null) {
  //       // Faça o que for necessário após o usuário ter sido criado
  //     }
  //   } on FirebaseAuthException catch (erro) {
  //     print(erro);
  //     // Lida com erros específicos do FirebaseAuth
  //     if (erro.code == 'weak-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('A senha é muito fraca')),
  //       );
  //     } else if (erro.code == 'email-already-in-use') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('O email já está em uso')),
  //       );
  //     } else {
  //       // Lida com outros erros do FirebaseAuth
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Erro ao criar usuário')),
  //       );
  //     }
  //   } catch (erro) {
  //     print(erro);
  //     // Lida com outros erros não relacionados ao FirebaseAuth
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Erro ao criar usuário')),
  //     );
  //   }
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
    }on FirebaseAuthException catch(erro) {
      print(erro.hashCode);
      print(erro);
    }
  }
}

final String collectionName = 'cadastro_ouvidor';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ScrCadastroOuvidorState extends State<ScrCadastroOuvidor> {
  String? matricula;
  String? telMovel;
  String? tipoServidor;
  DateTime? dtEfetivacao;

  bool showError = false;
  bool showErrorTipoServidor = false;
  bool showErrorMatricula = false;
  bool showErrorTelMovel = false;
  bool showErrorDtEfetivacao = false;

  TextEditingController matriculaController = TextEditingController();
  TextEditingController telMovelController = TextEditingController();
  TextEditingController tipoServidorController = TextEditingController();
  TextEditingController dtEfetivacaoController = TextEditingController();

  List<String> arrTipoContratacao = [
    'Concursado',
    'Comissionado',
    'Terceirizado',
  ];

  void finalizarCadastroCidadao() {
    print('');
    print('Retorno Cadastro de Usuario Cidadao');
    print('');

    print('tipoUser: ${widget.tipoUser}');
    print('Nome: ${widget.nome}');
    print('Email: ${widget.email}');
    print('Senha: ${widget.senha}');
    print('Matricula: $matricula');
    print('TelMovel: $telMovel');
    print('TipoServidor: $tipoServidor');
    print('DtEfetivacao: $dtEfetivacao');

    _firestore.collection(collectionName).add({
      'tipoUser': widget.tipoUser,
      'nome': widget.nome,
      'email': widget.email,
      'senha': widget.senha,
      'matricula': matricula,
      'telMovel': telMovel,
      'tipoServidor': tipoServidor,
      'dtEfetivacao': dtEfetivacao,
    }).then((value) {
      print('Dados armazenados com sucesso no Firebase!');
    }).catchError((error) {
      print('Erro ao armazenar dados no Firebase: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text('SRASP'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("teste busca");
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                print("teste configurações");
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Histórico'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScrMainMenu(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Sair'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              margin: EdgeInsets.all(40),
              color: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Cadastro Ouvidor',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'Matricula',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: showErrorMatricula ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: matriculaController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          matricula = value;
                          showErrorMatricula = false;
                        },
                      ),
                    ),
                    if (showErrorMatricula)
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Obrigatório',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red),
                          ),
                        ),
                      ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'Telefone Móvel',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: showErrorTelMovel
                              ? Colors.red
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneNumberInputFormatter(),
                        ],
                        controller: telMovelController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          telMovel = value;
                          showErrorTelMovel = false;
                        },
                      ),
                    ),
                    if (showErrorTelMovel)
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Obrigatório',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red),
                          ),
                        ),
                      ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'Tipo de Contratação',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: showErrorTipoServidor && tipoServidor == null ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: tipoServidor,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (value) {
                          setState(() {
                            tipoServidor = value;
                            showErrorTipoServidor = false;
                          });
                        },
                        items: arrTipoContratacao.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                value,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    if (showErrorTipoServidor && tipoServidor == null)
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Obrigatório',
                            style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
                          ),
                        ),
                      ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'Data de Efetivação',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: showErrorDtEfetivacao && dtEfetivacao == null ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          setState(() {
                            dtEfetivacao = selectedDate;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.calendar_today),
                              Expanded(
                                child: Text(
                                  dtEfetivacao != null ? formatDate(dtEfetivacao!) : 'Selecione a data',
                                  textAlign: TextAlign.center, // Alinhar o texto no centro
                                  style: TextStyle(
                                    color: dtEfetivacao != null ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (showErrorDtEfetivacao && dtEfetivacao == null)
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Obrigatório',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red),
                          ),
                        ),
                      ),
                    SizedBox(height: 60),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await widget.removeUser(context);
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()
                                  ),
                                );
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                              fixedSize:
                              MaterialStateProperty.all(Size(150, 50)),
                            ),
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() async {
                                showError = false;
                                if (matriculaController.text.isEmpty ||
                                    telMovelController.text.isEmpty ||
                                    tipoServidor == null  ||
                                    dtEfetivacao  == null) {
                                  showErrorMatricula = matriculaController.text.isEmpty;
                                  showErrorTelMovel =
                                      telMovelController.text.isEmpty;
                                  showErrorTipoServidor =
                                      tipoServidorController.text.isEmpty;
                                  showErrorDtEfetivacao =
                                      dtEfetivacaoController.text.isEmpty;
                                } else {
                                  showErrorMatricula = false;
                                  showErrorTelMovel = false;
                                  showErrorTipoServidor = false;
                                  showErrorDtEfetivacao = false;
                                  finalizarCadastroCidadao();
                                  await widget.loginUser(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScrMainMenu(),
                                    ),
                                  );
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.lightGreen[800]),
                              fixedSize:
                              MaterialStateProperty.all(Size(150, 50)),
                            ),
                            child: Text(
                              'Finalizar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                        ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year.toString()}';
  }
}
