import 'package:app_de_saude/scr_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'login_screen.dart';

class ScrCadastroCidadao extends StatefulWidget {
  final String nome;
  final String email;
  final String senha;

  const ScrCadastroCidadao({
    Key? key,
    required this.nome,
    required this.email,
    required this.senha,
  }) : super(key: key);

  @override
  State<ScrCadastroCidadao> createState() => _ScrCadastroCidadaoState();
}

class _ScrCadastroCidadaoState extends State<ScrCadastroCidadao> {
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  bool showError = false;

  @override
  void initState() {
    super.initState();
    cepController.addListener(() {
      final String cep = cepController.text;
      if (cep.isNotEmpty) {
        _fetchAddressFromAPI(cep);
      }
    });
  }

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  Future<void> buscarCEP(String cep) async {
    String url = 'https://viacep.com.br/ws/$cep/json/';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        logradouroController.text = data['logradouro'];
        complementoController.text = data['complemento'];
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
    String numero = numeroController.text;
    String complemento = complementoController.text;
    String bairro = bairroController.text;
    String cidade = cidadeController.text;
    String estado = estadoController.text;

    print('');
    print('Retorno Cadastro de Usuario Cidadao');
    print('');

    print('Nome: ${widget.nome}');
    print('Email: ${widget.email}');
    print('Senha: ${widget.senha}');
    print('CEP: $cep');
    print('Logradouro: $logradouro');
    print('Número: $numero');
    print('Complemento: $complemento');
    print('Bairro: $bairro');
    print('Cidade: $cidade');
    print('Estado: $estado');
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
                          'Cadastro Cidadão',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: cepController,
                        decoration: InputDecoration(
                          labelText: 'CEP',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: logradouroController,
                        decoration: InputDecoration(
                          labelText: 'Logradouro',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: numeroController,
                        decoration: InputDecoration(
                          labelText: 'Número',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: complementoController,
                        decoration: InputDecoration(
                          labelText: 'Complemento',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: bairroController,
                        decoration: InputDecoration(
                          labelText: 'Bairro',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: cidadeController,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: estadoController,
                        decoration: InputDecoration(
                          labelText: 'Estado',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          finalizarCadastroCidadao();
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
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white),
                          fixedSize: MaterialStateProperty.all(
                              Size.fromHeight(60)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
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
                      SizedBox(height: 10),
                      if (showError)
                        Text(
                          'Erro ao buscar o endereço. Verifique o CEP e tente novamente.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
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

  Future<void> _fetchAddressFromAPI(String cep) async {
    final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
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
}