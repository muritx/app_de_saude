import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app_de_saude/scr_abertura_recl_c.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';

class ScrAberturaReclD extends StatefulWidget {
  const ScrAberturaReclD({
    Key? key,
    required this.tipoAbertura,
    required this.selectedSecretaria,
    required this.selectedTipoServico,
    required this.selectedEmpresaTerceirizada,
    required this.titulo,
    required this.descricao,
    required this.data,
  }) : super(key: key);

  final int tipoAbertura;
  final String selectedSecretaria;
  final String selectedTipoServico;
  final String selectedEmpresaTerceirizada;
  final String titulo;
  final String descricao;
  final DateTime data;

  @override
  State<ScrAberturaReclD> createState() => _ScrAberturaReclDState();
}

class _ScrAberturaReclDState extends State<ScrAberturaReclD> {
  bool showError = false;

  late String id_reclamacao;

  @override
  void initState() {
    super.initState();
    id_reclamacao = generateRandomID();
    printSelectedValues();
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
              margin: EdgeInsets.all(40),
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
                          'Nova Reclamação',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 20),
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
                              MaterialStateProperty.all(Colors.white),
                          fixedSize:
                              MaterialStateProperty.all(Size.fromHeight(60)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        child: Text(
                          'Finalizar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
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
    print('selectedTipoServico: ${widget.selectedTipoServico}');
    print('selectedEmpresaTerceirizada: ${widget.selectedEmpresaTerceirizada}');
    print('titulo: ${widget.titulo}');
    print('descricao: ${widget.descricao}');
    print('data: ${widget.data}');
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
