import 'dart:convert';
import 'package:app_de_saude/scr_cadastro_cidadao_a.dart';
import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ScrCadastroCidadaoB extends StatefulWidget {

  ScrCadastroCidadaoB({
    Key? key,
    required this.tipoUser,
    required this.nome,
    required this.email,
    required this.senha,
    required this.cpf,
    required this.telMovel,
    required this.telFixo,
    required this.dtNasc,
  }) : super(key: key){
    emailController.text = email ?? '';
    passwordController.text = senha ?? '';
  }

  final int? tipoUser;
  final String? nome;
  final String? email;
  final String? senha;
  final String? cpf;
  final String? telMovel;
  final String? telFixo;
  final DateTime? dtNasc;
  final _firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<ScrCadastroCidadaoB> createState() => _ScrCadastroCidadaoBState();

  loginUser(context) async {
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

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final String collectionName = 'cadastro_cidadao';

class _ScrCadastroCidadaoBState extends State<ScrCadastroCidadaoB> {
  String? cep;
  String? logradouro;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;

  bool showError = false;
  bool showErrorBairro = false;
  bool showErrorCep = false;
  bool showErrorLogradouro = false;
  bool showErrorNumero = false;
  bool showErrorComplemento = false;
  bool showErrorCidade = false;
  bool showErrorEstado = false;

  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  Future<void> buscarCEP(String cep) async {
    String url = 'https://viacep.com.br/ws/$cep/json/';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        cepController.text = data['cep'];
        logradouroController.text = data['logradouro'];
        bairroController.text = data['bairro'];
        cidadeController.text = data['localidade'];
        estadoController.text = data['uf'];
      });
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  void finalizarCadastroCidadao() {
    String cep = cepController.text;
    String logradouro = logradouroController.text;
    String bairro = bairroController.text;
    String cidade = cidadeController.text;
    String estado = estadoController.text;

    print('');
    print('Retorno Cadastro de Usuario Cidadao');
    print('');

    print('tipoUser: ${widget.tipoUser}');
    print('Nome: ${widget.nome}');
    print('Email: ${widget.email}');
    print('Senha: ${widget.senha}');
    print('CPF: ${widget.cpf}');
    print('Telefone Móvel: ${widget.telMovel}');
    print('Telefone Fixo: ${widget.telFixo}');
    print('Data Nascimento: ${widget.dtNasc}');
    print('CEP: $cep');
    print('Logradouro: $logradouro');
    print('Número: $numero');
    print('Complemento: $complemento');
    print('Bairro: $bairro');
    print('Cidade: $cidade');
    print('Estado: $estado');

    _firestore.collection(collectionName).add({
      'tipoUser': widget.tipoUser,
      'nome': widget.nome,
      'email': widget.email,
      'senha': widget.senha,
      'cpf': widget.cpf,
      'telMovel': widget.telMovel,
      'telFixo': widget.telFixo,
      'dtNasc': widget.dtNasc,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
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
              // ListTile(
              //   title: Text('Histórico'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ScrMainMenu(),
              //       ),
              //     );
              //   },
              // ),
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
                        'Cadastro Cidadão',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'CEP',
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
                          color: showErrorCep ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: cepController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          cep = value;
                          buscarCEP(cep!);
                          showErrorCep = false;
                        },
                      ),
                    ),
                    if (showErrorCep)
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
                        'Logradouro',
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
                          color: showErrorLogradouro
                              ? Colors.red
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: logradouroController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          logradouro = value;
                          showErrorLogradouro = false;
                        },
                      ),
                    ),
                    if (showErrorLogradouro)
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
                        'Número',
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
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          numero = value;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'Complemento',
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
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          complemento = value;
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 1),
                      child: Text(
                        'Bairro',
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
                          color:
                              showErrorBairro ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: bairroController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          bairro = value;
                          showErrorBairro = false;
                        },
                      ),
                    ),
                    if (showErrorBairro)
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
                      padding: EdgeInsets.only(top: 2, bottom: 1),
                      child: Text(
                        'Cidade',
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
                          color:
                              showErrorCidade ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: cidadeController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          cidade = value;
                          showErrorCidade = false;
                        },
                      ),
                    ),
                    if (showErrorCidade)
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
                        'Estado',
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
                          color:
                              showErrorEstado ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: estadoController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          estado = value;
                        },
                      ),
                    ),
                    if (showErrorEstado)
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
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScrCadastroCidadaoA(
                                        tipoUser: widget.tipoUser!,
                                        nome: widget.nome!,
                                        email: widget.email!,
                                        senha: widget.senha!,
                                      )
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
                                if (cepController.text.isEmpty ||
                                    logradouroController.text.isEmpty ||
                                    bairroController.text.isEmpty ||
                                    cidadeController.text.isEmpty ||
                                    estadoController.text.isEmpty) {
                                  showErrorCep = cepController.text.isEmpty;
                                  showErrorLogradouro =
                                      logradouroController.text.isEmpty;
                                  showErrorBairro =
                                      bairroController.text.isEmpty;
                                  showErrorCidade =
                                      cidadeController.text.isEmpty;
                                  showErrorEstado =
                                      estadoController.text.isEmpty;
                                } else {
                                  showErrorCep = false;
                                  showErrorLogradouro = false;
                                  showErrorBairro = false;
                                  showErrorCidade = false;
                                  showErrorEstado = false;
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
                                fontWeight: FontWeight.bold,
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
}
