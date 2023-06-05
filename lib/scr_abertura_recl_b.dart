import 'package:flutter/material.dart';
import 'package:app_de_saude/scr_abertura_recl_c.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';

class ScrAberturaReclB extends StatefulWidget {
  const ScrAberturaReclB({Key? key, required this.tipoAbertura}) : super(key: key);

  final int? tipoAbertura;

  @override
  State<ScrAberturaReclB> createState() => _ScrAberturaReclBState();
}

class _ScrAberturaReclBState extends State<ScrAberturaReclB> {
  List<String> secretarias = [
    'Secretaria Estadual de Saúde - PE',
    'Outros',
  ];

  List<String> unidades = [
    'UPAe Limoeiro',
    'UPA São Lourenço da Mata - Professor Fernando Figueira',
    'Outros',
  ];

  List<String> tiposServico = [
    'Emissão de Documentos',
    'Limpeza',
    'Outros',
  ];

  List<String> empresasTerceirizadas = [
    'Sem Empresa Envolvida',
    'ABC Serviços Gerais',
    'CBA Segurança',
  ];

  String? selectedSecretaria;
  String? selectedUnidades;
  String? selectedTipoServico;
  String? selectedEmpresaTerceirizada;

  bool showError = false;

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
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(color: Colors.white54),
                      ),
                      child: LinearProgressIndicator(
                        value: 0.50,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Para qual a secretaria deseja abrir a reclamação?',
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
                          color: showError && selectedSecretaria == null ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedSecretaria,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSecretaria = newValue;
                          });
                        },
                        items: secretarias.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (showError && selectedSecretaria == null)
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
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Qual a Unidade de Saúde está relacionada?',
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
                          color: showError && selectedUnidades == null ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedUnidades,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUnidades = newValue;
                          });
                        },
                        items: unidades.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (showError && selectedUnidades == null)
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
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Sua reclamação está relacionada a qual tipo de serviço?',
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
                          color: showError && selectedTipoServico == null ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedTipoServico,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTipoServico = newValue;
                          });
                        },
                        items: tiposServico.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (showError && selectedTipoServico == null)
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
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Existe alguma empresa terceirizada envolvida na reclamação?',
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
                          color: showError && selectedEmpresaTerceirizada == null ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedEmpresaTerceirizada,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedEmpresaTerceirizada = newValue;
                          });
                        },
                        items: empresasTerceirizadas.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (showError && selectedEmpresaTerceirizada == null)
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
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedSecretaria == null ||
                              selectedUnidades == null ||
                              selectedTipoServico == null ||
                              selectedEmpresaTerceirizada == null) {
                            showError = true;
                          } else {
                            showError = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScrAberturaReclC(
                                  selectedSecretaria: selectedSecretaria!,
                                  selectedUnidades: selectedUnidades!,
                                  selectedTipoServico: selectedTipoServico!,
                                  selectedEmpresaTerceirizada: selectedEmpresaTerceirizada!,
                                  tipoAbertura: widget.tipoAbertura!,
                                ),
                              ),
                            );
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        fixedSize: MaterialStateProperty.all(Size.fromHeight(60)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      child: Text(
                        'Próximo Passo',
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
    );
  }
}

