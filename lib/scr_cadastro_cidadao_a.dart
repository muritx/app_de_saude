import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:app_de_saude/scr_cadastro_cidadao_b.dart';
import 'package:flutter/services.dart';

class ScrCadastroCidadaoA extends StatefulWidget {
  final int? tipoUser;
  final String? nome;
  final String? email;
  final String? senha;

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
                        maxLength: 14,
                        decoration: InputDecoration(
                            counterText: ''
                        ),
                        controller: cpfController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            cpf = value;
                            showErrorCpf = false;
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
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
                          setState(() {
                            telMovel = value;
                            showErrorTelMovel = false;
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneNumberInputFormatter(),
                        ],
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
                          setState(() {
                            telFixo = value;
                            showErrorTelFixo = false;
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneNumberInputFormatter(),
                        ],
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
                          color: showErrorDtNasc ? Colors.red : Colors.transparent,
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
                              Expanded(
                                child: Text(
                                  dtNasc != null ? formatDate(dtNasc!) : 'Selecione a data',
                                  textAlign: TextAlign.center, // Alinhar o texto no centro
                                  style: TextStyle(
                                    color: dtNasc != null ? Colors.black : Colors.grey,
                                  ),
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
                              MaterialStateProperty.all(Size(150, 50)),
                            ),
                            child: Text(
                              'Avançar',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          if (showError)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Por favor, preencha todos os campos',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
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
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _maskPhoneNumber(newValue.text);
    final int selectionIndex = formattedText.length;
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  String _maskPhoneNumber(String inputText) {
    final cleanedText = inputText.replaceAll(RegExp(r'\D'), '');
    if (cleanedText.isEmpty) {
      return '';
    } else if (cleanedText.length <= 2) {
      return cleanedText;
    } else if (cleanedText.length <= 6) {
      return '(' +
          cleanedText.substring(0, 2) +
          ') ' +
          cleanedText.substring(2);
    } else if (cleanedText.length <= 10) {
      return '(' +
          cleanedText.substring(0, 2) +
          ') ' +
          cleanedText.substring(2, 6) +
          '-' +
          cleanedText.substring(6);
    } else {
      return '(' +
          cleanedText.substring(0, 2) +
          ') ' +
          cleanedText.substring(2, 7) +
          '-' +
          cleanedText.substring(7, 11);
    }
  }
}


class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _maskCpf(newValue.text);
    final int selectionIndex = formattedText.length;
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  String _maskCpf(String inputText) {
    final cleanedText = inputText.replaceAll(RegExp(r'\D'), '');
    if (cleanedText.isEmpty) {
      return '';
    } else if (cleanedText.length <= 3) {
      return cleanedText;
    } else if (cleanedText.length <= 6) {
      return cleanedText.substring(0, 3) + '.' + cleanedText.substring(3);
    } else if (cleanedText.length <= 9) {
      return cleanedText.substring(0, 3) +
          '.' +
          cleanedText.substring(3, 6) +
          '.' +
          cleanedText.substring(6);
    } else {
      return cleanedText.substring(0, 3) +
          '.' +
          cleanedText.substring(3, 6) +
          '.' +
          cleanedText.substring(6, 9) +
          '-' +
          cleanedText.substring(9);
    }
  }
}

String formatDate(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(4, '0')}";
}
