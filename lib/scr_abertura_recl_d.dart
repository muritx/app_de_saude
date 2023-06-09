import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScrAberturaReclD extends StatefulWidget {
  const ScrAberturaReclD({
    Key? key,
    required this.tipoAbertura,
    required this.selectedSecretaria,
    required this.selectedUnidades,
    required this.selectedTipoServico,
    required this.selectedEmpresaTerceirizada,
    required this.titulo,
    required this.descricao,
    required this.dataOcorrido,
  }) : super(key: key);

  final int? tipoAbertura;
  final String? selectedSecretaria;
  final String? selectedUnidades;
  final String? selectedTipoServico;
  final String? selectedEmpresaTerceirizada;
  final String? titulo;
  final String? descricao;
  final DateTime? dataOcorrido;

  @override
  State<ScrAberturaReclD> createState() => _ScrAberturaReclDState();
}

final String collectionName = 'cadastro_reclamacao';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ScrAberturaReclDState extends State<ScrAberturaReclD> {
  bool showError = false;

  late String id_reclamacao;
  DateTime dataAberturaRecl = DateTime.now();

  @override
  void initState() {
    super.initState();
    id_reclamacao = generateRandomID();
    printSelectedValues();
  }

  void uidUsuario() async {
    // Resto do código...

    // Obter o UID do usuário atual se o tipo de abertura for igual a 0
    String? uidAbertura;
    String? emailAbertura;
    if (widget.tipoAbertura == 0) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      uidAbertura = currentUser?.uid;
      emailAbertura = currentUser?.email;
    }

    // Resto do código...

    _firestore
        .collection(collectionName)
        .where('codigoRecl', isEqualTo: id_reclamacao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        document.reference.update({
          'uidAbertura': uidAbertura,
          'emailAbertura': emailAbertura,
        }).then((value) {
          print('Dados atualizados com sucesso no Firebase!');
        }).catchError((error) {
          print('Erro ao atualizar dados no Firebase: $error');
        });
      } else {
        print('Documento não encontrado com o códigoRecl: $id_reclamacao');
      }
    }).catchError((error) {
      print('Erro ao obter documento no Firebase: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: SafeArea(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              margin: EdgeInsets.all(50),
              color: Colors.blue,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Reclamação Aberta!',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.white54),
                        ),
                        child: LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      SizedBox(height: 80),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Este identificador da sua eeclamação:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            id_reclamacao,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScrMainMenu(),
                              ),
                            );
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.green),
                          fixedSize: MaterialStateProperty.all(Size(150, 50)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          'Finalizar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void printSelectedValues() {
    print('');
    print('Retorno Cadastro de Reclamacao');
    print('');
    print('id reclamacao: ${id_reclamacao}');
    print('tipoAbertura: ${widget.tipoAbertura}');
    print('selectedSecretaria: ${widget.selectedSecretaria}');
    print('selectedUnidades: ${widget.selectedUnidades}');
    print('selectedTipoServico: ${widget.selectedTipoServico}');
    print('selectedEmpresaTerceirizada: ${widget.selectedEmpresaTerceirizada}');
    print('titulo: ${widget.titulo}');
    print('descricao: ${widget.descricao}');
    print('dataOcorrido: ${widget.dataOcorrido}');
    print('dataAberturaRecl: ${dataAberturaRecl}');

    _firestore.collection(collectionName).add({
      'codigoRecl': id_reclamacao,
      'tipoAbertura': widget.tipoAbertura,
      'selectedSecretaria': widget.selectedSecretaria,
      'selectedUnidades': widget.selectedUnidades,
      'selectedTipoServico': widget.selectedTipoServico,
      'selectedEmpresaTerceirizada': widget.selectedEmpresaTerceirizada,
      'titulo': widget.titulo,
      'descricao': widget.descricao,
      'dataOcorrido': widget.dataOcorrido,
      'dataAbertura': dataAberturaRecl,
      'status': 'Aberto',
      'severidade': 'Baixa',
      'dataConclusao': null,
      'diasAberto': null,
    }).then((value) {
      uidUsuario();
      print('Dados armazenados com sucesso no Firebase!');
    }).catchError((error) {
      print('Erro ao armazenar dados no Firebase: $error');
    });
  }

  String generateRandomID() {
    final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final random = Random();

    String randomID = '';

    // Generate 3 random letters
    for (int i = 0; i < 3; i++) {
      final randomLetterIndex = random.nextInt(letters.length);
      randomID += letters[randomLetterIndex];
    }

    randomID += ' ';

    // Generate 4 random numbers
    for (int i = 0; i < 4; i++) {
      final randomNumberIndex = random.nextInt(numbers.length);
      randomID += numbers[randomNumberIndex];
    }

    randomID += ' ';

    // Generate 2 random letters
    for (int i = 0; i < 2; i++) {
      final randomLetterIndex = random.nextInt(letters.length);
      randomID += letters[randomLetterIndex];
    }

    randomID += ' ';

    // Generate 1 random letter
    final randomLetterIndex = random.nextInt(letters.length);
    randomID += letters[randomLetterIndex];

    return randomID;
  }
}