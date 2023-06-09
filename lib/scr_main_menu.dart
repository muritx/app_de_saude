import 'package:app_de_saude/scr_datalhe_recl.dart';
import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_abertura_recl_a.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScrMainMenu extends StatefulWidget {
  const ScrMainMenu({Key? key}) : super(key: key);

  @override
  State<ScrMainMenu> createState() => _ScrMainMenuState();
}

class _ScrMainMenuState extends State<ScrMainMenu> {
  late String nome = '';
  late int tipoUser = -1;
  bool isLoading = false;

  List<Item> items = [];

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  void fetchItemsFromFirebase() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('cadastro_reclamacao')
        .get()
        .then((QuerySnapshot querySnapshot) {
      items.clear(); // Limpa a lista de items antes de adicioná-los

      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        final itemData = documentSnapshot.data() as Map<String, dynamic>?;

        // Verifica se itemData é nulo antes de acessar os campos
        if (itemData != null) {
          Timestamp dataAberturaTimestamp = itemData['dataAbertura'] as Timestamp;
          DateTime dataAbertura = dataAberturaTimestamp.toDate();

          Timestamp? dataConclusaoTimestamp = itemData['dataConclusao'] as Timestamp?;
          DateTime? dataConclusao = dataConclusaoTimestamp?.toDate();

          items.add(Item(
            id: documentSnapshot.reference.id,
            codigoRecl: itemData['codigoRecl']?.toString() ?? '-',
            descricao: itemData['descricao']?.toString() ?? '-',
            status: itemData['status']?.toString() ?? '-',
            severidade: itemData['severidade']?.toString() ?? '-',
            dataAbertura: DateFormat('dd/MM/yyyy').format(dataAbertura),
            dataConclusao: dataConclusao != null ? DateFormat('dd/MM/yyyy').format(dataConclusao) : '-',
            diasAberto: itemData['diasAberto']?.toString() ?? '-',
          ));
        }
      });

      setState(() {}); // Atualiza o estado para refletir as mudanças na interface
    }).catchError((error) {
      print('Erro ao buscar os itens: $error');
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user.email ?? '';

      await fetchUserDataByEmail(email);

      // Restante do código...
    }
  }

  Future<void> fetchUserDataByEmail(String email) async {
    QuerySnapshot cidadaoSnapshot = await FirebaseFirestore.instance
        .collection('cadastro_cidadao')
        .where('email', isEqualTo: email)
        .get();

    QuerySnapshot ouvidorSnapshot = await FirebaseFirestore.instance
        .collection('cadastro_ouvidor')
        .where('email', isEqualTo: email)
        .get();
    if (cidadaoSnapshot.docs.isNotEmpty) {
      // Obtém o nome e tipoUser da coleção "cadastro_cidadao"
      Map<String, dynamic>? cidadaoData = cidadaoSnapshot.docs[0].data() as Map<String, dynamic>?;
      if (cidadaoData != null) {
        setState(() {
          nome = cidadaoData.containsKey('nome') ? cidadaoData['nome'] as String : '';
          tipoUser = cidadaoData.containsKey('tipoUser') ? cidadaoData['tipoUser'] as int : -1;
        });

        if (tipoUser == 0) {
          // Executar fetchItemsFromFirebase sem limitações
          fetchItemsFromFirebase();
        } else if (tipoUser == 1) {
          // Executar fetchItemsFromFirebase com limitações
          fetchItemsFromFirebaseLimited(email);
        }

        // Faça o que for necessário com o nome e tipoUser
      }
    } else if (ouvidorSnapshot.docs.isNotEmpty) {
      // Obtém o nome e tipoUser da coleção "cadastro_ouvidor"
      Map<String, dynamic>? ouvidorData = ouvidorSnapshot.docs[0].data() as Map<String, dynamic>?;

      if (ouvidorData != null) {
        setState(() {
          nome = ouvidorData.containsKey('nome') ? ouvidorData['nome'] as String : '';
          tipoUser = ouvidorData.containsKey('tipoUser') ? ouvidorData['tipoUser'] as int : -1;
        });

        if (tipoUser == 0) {
          // Executar fetchItemsFromFirebase sem limitações
          fetchItemsFromFirebase();
        } else if (tipoUser == 1) {
          // Executar fetchItemsFromFirebase com limitações
          fetchItemsFromFirebaseLimited(email);
        }

        // Faça o que for necessário com o nome e tipoUser
      }
    }
  }

  void fetchItemsFromFirebaseLimited(String email) {
    FirebaseFirestore.instance
        .collection('cadastro_reclamacao')
        .where('emailAbertura', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      //await Future.delayed(Duration(seconds: 10));
      items.clear(); // Limpa a lista de items antes de adicioná-los
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        final itemData = documentSnapshot.data() as Map<String, dynamic>?;

        // Verifica se itemData é nulo antes de acessar os campos
        if (itemData != null) {
          Timestamp dataAberturaTimestamp = itemData['dataAbertura'] as Timestamp;
          DateTime dataAbertura = dataAberturaTimestamp.toDate();

          Timestamp? dataConclusaoTimestamp = itemData['dataConclusao'] as Timestamp?;
          DateTime? dataConclusao = dataConclusaoTimestamp?.toDate();

          items.add(Item(
            id: documentSnapshot.reference.id,
            codigoRecl: itemData['codigoRecl']?.toString() ?? '-',
            descricao: itemData['descricao']?.toString() ?? '-',
            status: itemData['status']?.toString() ?? '-',
            severidade: itemData['severidade']?.toString() ?? '-',
            dataAbertura: DateFormat('dd/MM/yyyy').format(dataAbertura),
            dataConclusao: dataConclusao != null ? DateFormat('dd/MM/yyyy').format(dataConclusao) : '-',
            diasAberto: itemData['diasAberto']?.toString() ?? '-',
          ));
        }
      });

      setState(() {}); // Atualiza o estado para refletir as mudanças na interface
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
                  Visibility(
                    visible: tipoUser == 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScrAberturaRecl()),
                          );
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green[800]),
                        fixedSize: MaterialStateProperty.all(Size(1500, 50)),
                      ),
                      child: Text(
                        'Abrir uma Nova Reclamação',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                        : items.length == 0
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
      ),
    );
  }

  Widget buildItem(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheReclScreen(documentId: item.id!, nome: nome,),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID ${item.codigoRecl}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${item.status}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Severidade: ${item.severidade}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Data de Abertura: ${item.dataAbertura}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Data de Conclusão: ${item.dataConclusao}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Dias em Aberto: ${item.diasAberto}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  String? id;
  String? codigoRecl;
  String? descricao;
  String? status;
  String? severidade;
  String? dataAbertura;
  String? dataConclusao;
  String? diasAberto;

  Item({
    this.id,
    this.codigoRecl,
    this.descricao,
    this.status,
    this.severidade,
    this.dataAbertura,
    this.dataConclusao,
    this.diasAberto,
  });
}
