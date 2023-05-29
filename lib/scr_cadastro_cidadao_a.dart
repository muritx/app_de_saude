import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:app_de_saude/scr_cadastro_cidadao_b.dart';

class ScrCadastroCidadaoA extends StatefulWidget {
  final int tipoUser;
  final String nome;
  final String email;
  final String senha;

  const ScrCadastroCidadaoA({
    Key? key,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipoUser,
  }) : super(key: key);

  @override
  State<ScrCadastroCidadaoA> createState() => _ScrCadastroCidadaoAState();
}

class _ScrCadastroCidadaoAState extends State<ScrCadastroCidadaoA> {
  String? cpf;
  String? telMovel;
  String? telFixo;
  DateTime? dtNasc;

  bool showError = false;
  bool showErrorTelFixo = false;
  bool showErrorCpf = false;
  bool showErrorTelMovel = false;
  bool showErrorDtNasc = false;

  TextEditingController cpfController = TextEditingController();
  TextEditingController telMovelController = TextEditingController();
  TextEditingController telFixoController = TextEditingController();
  TextEditingController dtNascController = TextEditingController();

  void finalizarCadastroCidadao() {
    print('');
    print('Retorno Cadastro de Usuario Cidadao');
    print('');

    print('tipoUser: ${widget.tipoUser}');
    print('Nome: ${widget.nome}');
    print('Email: ${widget.email}');
    print('Senha: ${widget.senha}');
    print('CPF: $cpf');
    print('TelMovel: $telMovel');
    print('TelFixo: $telFixo');
    print('DtNasc: $dtNasc');
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
                        'CPF',
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
                          color: showErrorCpf ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: cpfController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          cpf = value;
                          showErrorCpf = false;
                        },
                      ),
                    ),
                    if (showErrorCpf)
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
                        'Telefone Fixo',
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
                          color: showErrorTelFixo
                              ? Colors.red
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: telFixoController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          telFixo = value;
                          showErrorTelFixo = false;
                        },
                      ),
                    ),
                    if (showErrorTelFixo)
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
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Data de Nascimento',
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
                              showErrorDtNasc ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              dtNasc = selectedDate;
                              dtNascController.text = formatDate(selectedDate);
                              showErrorDtNasc = false;
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.calendar_today),
                              Text(
                                dtNasc != null
                                    ? formatDate(dtNasc!)
                                    : 'Selecione a data',
                                style: TextStyle(
                                  color: dtNasc != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (showErrorDtNasc)
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Obrigatório',
                            style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showError = false;
                                if (cpfController.text.isEmpty ||
                                    telMovelController.text.isEmpty ||
                                    telFixoController.text.isEmpty ||
                                    dtNascController.text.isEmpty) {
                                  showErrorCpf = cpfController.text.isEmpty;
                                  showErrorTelMovel =
                                      telMovelController.text.isEmpty;
                                  showErrorTelFixo =
                                      telFixoController.text.isEmpty;
                                  showErrorDtNasc =
                                      dtNascController.text.isEmpty;
                                } else {
                                  showErrorCpf = false;
                                  showErrorTelMovel = false;
                                  showErrorTelFixo = false;
                                  showErrorDtNasc = false;
                                  finalizarCadastroCidadao();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScrCadastroCidadaoB(
                                        tipoUser: widget.tipoUser!,
                                        nome: widget.nome!,
                                        email: widget.email!,
                                        senha: widget.senha!,
                                        cpf: cpf!,
                                        telFixo: telFixo!,
                                        telMovel: telMovel!,
                                        dtNasc: dtNasc!,
                                      ),
                                    ),
                                  );
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              fixedSize:
                                  MaterialStateProperty.all(Size(200, 50)),
                            ),
                            child: Text(
                              'Finalizar',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
  }
}
