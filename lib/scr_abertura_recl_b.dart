import 'package:flutter/material.dart';
import 'package:app_de_saude/scr_abertura_recl_c.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';

class ScrAberturaReclB extends StatefulWidget {
  const ScrAberturaReclB({Key? key}) : super(key: key);

  @override
  State<ScrAberturaReclB> createState() => _ScrAberturaReclBState();
}

class _ScrAberturaReclBState extends State<ScrAberturaReclB> {
  List<String> secretarias = [
    'Secretaria Estadual de Saúde - PE',
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
  String? selectedTipoServico;
  String? selectedEmpresaTerceirizada;

  bool showError = false; // Variável para controlar a exibição do erro

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
              color: Colors.blue, // Cor de fundo desejada para as margens
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
                      padding: EdgeInsets.only(bottom: 40),
                      child: Text(
                        'Nova Reclamação',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
                          // Verificar se todos os campos foram selecionados
                          if (selectedSecretaria == null ||
                              selectedTipoServico == null ||
                              selectedEmpresaTerceirizada == null) {
                            showError = true; // Exibir erro se algum campo estiver faltando
                          } else {
                            showError = false; // Esconder erro se todos os campos estiverem preenchidos
                            printSelectedValues();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScrAberturaReclC(),
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
  void printSelectedValues() {
    print('selecionado secretaria $selectedSecretaria');
    print('selecionado tipo serviço $selectedTipoServico');
    print('selecionado empresa terceirizada $selectedEmpresaTerceirizada');
  }
}

