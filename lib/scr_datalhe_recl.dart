import 'package:app_de_saude/scr_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_abertura_recl_a.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DetalheReclScreen extends StatefulWidget {
  const DetalheReclScreen({Key? key, this.documentId, required this.nome}) : super(key: key);
  final String? documentId; // Altere para String? (opcional)
  final String? nome;

  @override
  State<DetalheReclScreen> createState() => _DetalheReclScreenState();
}

class _DetalheReclScreenState extends State<DetalheReclScreen> {

  List<Item> items = [];

  List<String> arrTiposStatus = [
    'Aberto',
    'Em Andamento',
    'Encerrado',
    'Reaberto',
  ];

  List<String> arrTiposSeveriades = [
    'Alta',
    'Baixa',
    'Media',
  ];

  get nome => widget.nome;

  @override
  void initState() {
    super.initState();
    fetchItemsFromFirebase(); // Busca os dados do Firebase quando a tela for carregada
  }

  void updateDataInFirebase() {
    final Item item = items[0]; // Supondo que sempre há apenas um item na lista

    if (item.status == 'Encerrado') {
      final DateTime currentDate = DateTime.now();

      FirebaseFirestore.instance
          .collection('cadastro_reclamacao')
          .doc(widget.documentId)
          .update({
        'status': item.status,
        'severidade': item.severidade,
        'dataConclusao': currentDate,
        'diasAberto': calculateDaysDifference(
          DateFormat('dd/MM/yyyy').parse(item.dataAbertura),
          currentDate,
        ),
      }).then((value) {
        // Atualização bem-sucedida
        print('Dados atualizados com sucesso!');
      }).catchError((error) {
        // Erro ao atualizar os dados
        print('Erro ao atualizar os dados: $error');
      });
    } else {
      FirebaseFirestore.instance
          .collection('cadastro_reclamacao')
          .doc(widget.documentId)
          .update({
        'status': item.status,
        'severidade': item.severidade,
      }).then((value) {
        // Atualização bem-sucedida
        print('Dados atualizados com sucesso!');
      }).catchError((error) {
        // Erro ao atualizar os dados
        print('Erro ao atualizar os dados: $error');
      });
    }
  }

  int calculateDaysDifference(DateTime startDate, DateTime endDate) {
    final difference = endDate.difference(startDate);
    return difference.inDays;
  }

  void fetchItemsFromFirebase() {
    FirebaseFirestore.instance
        .collection('cadastro_reclamacao')
        .doc(widget.documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      final itemData = documentSnapshot.data() as Map<String, dynamic>?;

      if (itemData != null) {
        Timestamp dataAberturaTimestamp = itemData['dataAbertura'] as Timestamp;
        DateTime dataAbertura = dataAberturaTimestamp.toDate();

        Timestamp? dataConclusaoTimestamp = itemData['dataConclusao'] as Timestamp?;
        DateTime? dataConclusao = dataConclusaoTimestamp?.toDate();

        Timestamp dataOcorridoTimestamp = itemData['dataOcorrido'] as Timestamp;
        DateTime dataOcorrido = dataOcorridoTimestamp.toDate();

        String emailAbertura = itemData['emailAbertura']?.toString() ?? '';

        FirebaseFirestore.instance
            .collection('cadastro_cidadao')
            .where('email', isEqualTo: emailAbertura)
            .get()
            .then((QuerySnapshot querySnapshot) {
          //if (querySnapshot.docs.isNotEmpty) {
            final userData = querySnapshot.docs[0].data() as Map<String, dynamic>;

            DateTime dtNasc = userData['dtNasc'].toDate(); // Converter Timestamp em DateTime
            String dtNascFormatted = DateFormat('dd/MM/yyyy').format(dtNasc);

            setState(() {
              items.add(Item(
                codigoRecl: itemData['codigoRecl']?.toString() ?? '-',
                titulo: itemData['titulo']?.toString() ?? '-',
                descricao: itemData['descricao']?.toString() ?? '-',
                dataAbertura: DateFormat('dd/MM/yyyy').format(dataAbertura),
                dataConclusao: dataConclusao != null ? DateFormat('dd/MM/yyyy').format(dataConclusao) : '-',
                dataOcorrido: DateFormat('dd/MM/yyyy').format(dataOcorrido) ?? '-',
                diasAberto: itemData['diasAberto']?.toString() ?? '-',
                selectedEmpresaTerceirizada: itemData['selectedEmpresaTerceirizada']?.toString() ?? '-',
                selectedSecretaria: itemData['selectedSecretaria']?.toString() ?? '-',
                selectedTipoServico: itemData['selectedTipoServico']?.toString() ?? '-',
                selectedUnidades: itemData['selectedUnidades']?.toString() ?? '-',
                severidade: itemData['severidade']?.toString() ?? '-',
                status: itemData['status']?.toString() ?? '-',
                tipoAbertura: itemData['tipoAbertura']?.toString() ?? '-',
                emailAbertura: emailAbertura ?? '-',
                nome: userData['nome']?.toString() ?? '-',
                cpf: userData['cpf']?.toString() ?? '-',
                telMovel: userData['telMovel']?.toString() ?? '-',
                telFixo: userData['telFixo']?.toString() ?? '-',
                dtNasc: dtNascFormatted ?? '-',
                cep: userData['cep']?.toString() ?? '-',
                logradouro: userData['logradouro']?.toString() ?? '-',
                numero: userData['numero']?.toString() ?? '-',
                complemento: userData['complemento']?.toString() ?? '-',
                bairro: userData['bairro']?.toString() ?? '-',
                cidade: userData['cidade']?.toString() ?? '-',
                estado: userData['estado']?.toString() ?? '-',
              ));
            });
          //}
        }).catchError((error) {
          print('Erro ao buscar os dados na coleção "cadastro_cidadao": $error');
          setState(() {
            items.add(Item(
              codigoRecl: itemData['codigoRecl']?.toString() ?? '-',
              titulo: itemData['titulo']?.toString() ?? '-',
              descricao: itemData['descricao']?.toString() ?? '-',
              dataAbertura: DateFormat('dd/MM/yyyy').format(dataAbertura),
              dataConclusao: dataConclusao != null ? DateFormat('dd/MM/yyyy').format(dataConclusao) : '-',
              dataOcorrido: DateFormat('dd/MM/yyyy').format(dataAbertura) ?? '-',
              diasAberto: itemData['diasAberto']?.toString() ?? '-',
              selectedEmpresaTerceirizada: itemData['selectedEmpresaTerceirizada']?.toString() ?? '-',
              selectedSecretaria: itemData['selectedSecretaria']?.toString() ?? '-',
              selectedTipoServico: itemData['selectedTipoServico']?.toString() ?? '-',
              selectedUnidades: itemData['selectedUnidades']?.toString() ?? '-',
              severidade: itemData['severidade']?.toString() ?? '-',
              status: itemData['status']?.toString() ?? '-',
              tipoAbertura: itemData['tipoAbertura']?.toString() ?? '-',
              emailAbertura: '-',
              nome: '-',
              cpf: '-',
              telMovel: '-',
              telFixo: '-',
              dtNasc: '-',
              cep: '-',
              logradouro: '-',
              numero: '-',
              complemento: '-',
              bairro: '-',
              cidade: '-',
              estado: '-',
            ));
          });
        });
      }
    }).catchError((error) {
      print('Erro ao buscar os itens: $error');
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
                title: Text('Histórico de Reclamações'),
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
                title: Text('Abrir Reclamação'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScrAberturaRecl(),
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
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Olá, $nome!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5, bottom: 20),
                    child: Text(
                      'Aqui está seu histórico de reclamações:',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: items.length == 0
                        ? Center(
                      child: Text(
                        'Não há reclamações abertas',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return buildItem(context, items[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            child: Icon(Icons.save),
            backgroundColor: Colors.green,
            onPressed: () {
              updateDataInFirebase();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScrMainMenu(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScrAberturaRecl(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reclamação - ${item.codigoRecl}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Título:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.titulo,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Descrição:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.descricao,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Data de Abertura:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.dataAbertura,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Status:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              DropdownButtonFormField<String>(
                value: item.status,
                items: arrTiposStatus.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? selectedStatus) {
                  setState(() {
                    item.status = selectedStatus ?? '';
                  });
                },
              ),
              SizedBox(height: 8),
              Text(
                'Data de Conclusão:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.dataConclusao,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Data do Ocorrido:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.dataOcorrido,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Dias até a conclusão:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.diasAberto,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Empresa Terceirizada:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.selectedEmpresaTerceirizada,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Secretaria:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.selectedSecretaria,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Tipo de Serviço:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.selectedTipoServico,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Unidades:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.selectedUnidades,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Severidade:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              DropdownButtonFormField<String>(
                value: item.severidade,
                items: arrTiposSeveriades.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? selectedSeveridade) {
                  setState(() {
                    item.severidade = selectedSeveridade ?? '';
                  });
                },
              ),
              SizedBox(height: 8),
              Text(
                'Tipo de Abertura:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.tipoAbertura,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Email Reclamante:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.emailAbertura,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'Nome',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.nome,
                maxLines: null,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Text(
                'CPF',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.cpf,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Telefone Móvel',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.telMovel,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Telefone Fixo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.telFixo,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Data de Nascimento',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.dtNasc,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'CEP',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.cep,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Logradouro',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.logradouro,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Número',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.numero,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Complemento',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.complemento,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Bairro',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.bairro,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Cidade',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.cidade,
                maxLines: null,
                readOnly: true,
              ),

              SizedBox(height: 8),
              Text(
                'Estado',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                initialValue: item.estado,
                maxLines: null,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final String codigoRecl;
  final String titulo;
  final String descricao;
  final String dataAbertura;
  final String dataConclusao;
  final String dataOcorrido;
  final String diasAberto;
  final String selectedEmpresaTerceirizada;
  final String selectedSecretaria;
  final String selectedTipoServico;
  final String selectedUnidades;
  final String emailAbertura;
  final String nome;
  final String cpf;
  final String telMovel;
  final String telFixo;
  final String dtNasc;
  final String cep;
  final String logradouro;
  final String numero;
  final String complemento;
  final String bairro;
  final String cidade;
  final String estado;
  String severidade;
  String status;
  final String tipoAbertura;

  Item({
    required this.codigoRecl,
    required this.titulo,
    required this.descricao,
    required this.dataAbertura,
    required this.dataConclusao,
    required this.dataOcorrido,
    required this.diasAberto,
    required this.selectedEmpresaTerceirizada,
    required this.selectedSecretaria,
    required this.selectedTipoServico,
    required this.selectedUnidades,
    required this.severidade,
    required this.status,
    required this.tipoAbertura,
    required this.emailAbertura,
    required this.nome,
    required this.cpf,
    required this.telMovel,
    required this.telFixo,
    required this.dtNasc,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });
}
