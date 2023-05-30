import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:app_de_saude/scr_cadastro_cidadao_b.dart';

class ScrCadastroOuvidor extends StatefulWidget {
  final int? tipoUser;
  final String? nome;
  final String? email;
  final String? senha;

  const ScrCadastroOuvidor({
    Key? key,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipoUser,
  }) : super(key: key);

  @override
  State<ScrCadastroOuvidor> createState() => _ScrCadastroOuvidorState();
}

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
                          color: showErrorTipoServidor
                              ? Colors.red
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: tipoServidorController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          tipoServidor = value;
                          showErrorTipoServidor = false;
                        },
                      ),
                    ),
                    if (showErrorTipoServidor)
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
                          color:
                          showErrorDtEfetivacao ? Colors.red : Colors.transparent,
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
                              dtEfetivacao = selectedDate;
                              dtEfetivacaoController.text = formatDate(selectedDate);
                              showErrorDtEfetivacao = false;
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
                                dtEfetivacao != null
                                    ? formatDate(dtEfetivacao!)
                                    : 'Selecione a data',
                                style: TextStyle(
                                  color: dtEfetivacao != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (showErrorDtEfetivacao)
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
                                if (matriculaController.text.isEmpty ||
                                    telMovelController.text.isEmpty ||
                                    tipoServidorController.text.isEmpty ||
                                    dtEfetivacaoController.text.isEmpty) {
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
