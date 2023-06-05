import 'package:flutter/material.dart';
import 'package:app_de_saude/scr_abertura_recl_d.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';

class ScrAberturaReclC extends StatefulWidget {

  const ScrAberturaReclC(
      {Key? key,
      required this.tipoAbertura,
      required this.selectedSecretaria,
      required this.selectedTipoServico,
      required this.selectedEmpresaTerceirizada,
      required this.selectedUnidades})
      : super(key: key);

  final String? selectedSecretaria;
  final String? selectedUnidades;
  final String? selectedTipoServico;
  final String? selectedEmpresaTerceirizada;
  final int? tipoAbertura;

  @override
  State<ScrAberturaReclC> createState() => _ScrAberturaReclCState();
}

class _ScrAberturaReclCState extends State<ScrAberturaReclC> {
  String? titulo;
  String? descricao;
  DateTime? dataOcorrido;
  String? arquivoAnexado;

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
                      Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.white54),
                        ),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Título',
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
                            color: showError &&
                                    (titulo == null || titulo!.length > 100)
                                ? Colors.red
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              titulo = value.length <= 100
                                  ? value
                                  : value.substring(0, 100);
                            });
                          },
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: 'Digite o título para sua reclamação',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (showError && (titulo == null || titulo!.length > 100))
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Obrigatório e deve conter no máximo 100 caracteres',
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
                          'Descrição',
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
                            color: showError &&
                                    (descricao == null ||
                                        descricao!.length > 700)
                                ? Colors.red
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              descricao = value.length <= 700
                                  ? value
                                  : value.substring(0, 700);
                            });
                          },
                          maxLength: 700,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText:
                                'Detalhe um pouco sobre o que tem para reclamar',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (showError &&
                          (descricao == null || descricao!.length > 700))
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Obrigatório e deve conter no máximo 700 caracteres',
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
                          'Data do Ocorrido',
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
                            color: showError && dataOcorrido == null ? Colors.red : Colors.transparent,
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
                              dataOcorrido = selectedDate;
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
                                    dataOcorrido != null ? formatDate(dataOcorrido!) : 'Selecione a data',
                                    textAlign: TextAlign.center, // Alinhar o texto no centro
                                    style: TextStyle(
                                      color: dataOcorrido != null ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (showError && dataOcorrido == null)
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
                        child: InkWell(
                          onTap: () {
                            print('Anexar documento');
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.attach_file),
                                Text(
                                  'Anexar Arquivos',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (titulo == null ||
                                descricao == null ||
                                dataOcorrido == null) {
                              showError =
                                  true;
                            } else {
                              showError =
                                  false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScrAberturaReclD(
                                    titulo: titulo!,
                                    descricao: descricao!,
                                    dataOcorrido: dataOcorrido!,
                                    selectedSecretaria:
                                        widget.selectedSecretaria!,
                                    selectedUnidades:
                                        widget.selectedUnidades!,
                                    selectedTipoServico:
                                        widget.selectedTipoServico!,
                                    selectedEmpresaTerceirizada:
                                        widget.selectedEmpresaTerceirizada!,
                                    tipoAbertura: widget.tipoAbertura!,
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
                              MaterialStateProperty.all(Size.fromHeight(60)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
  }
}
