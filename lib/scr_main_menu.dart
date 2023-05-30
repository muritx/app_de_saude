import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_abertura_recl_a.dart';

class ScrMainMenu extends StatefulWidget {
  const ScrMainMenu({Key? key}) : super(key: key);

  @override
  State<ScrMainMenu> createState() => _ScrMainMenuState();
}

class _ScrMainMenuState extends State<ScrMainMenu> {
  final String? nome = 'Teste'; // Variável que recebe nomes

  // Simulação de dados do banco de dados
  final List<Item> items = [
    Item(
      id: 'KPK 1385 XS F',
      descricao: 'Descrição do Item 1',
      status: 'Aberto',
      severidade: 'Alta',
      dataAbertura: '01/01/2023',
      dataConclusao: '05/01/2023',
      diasAberto: '4',
    ),
    Item(
      id: 'WPH 7924 JU C',
      descricao: 'Descrição do Item 2',
      status: 'Fechado',
      severidade: 'Baixa',
      dataAbertura: '02/01/2023',
      dataConclusao: '03/01/2023',
      diasAberto: '1',
    ),
    Item(
      id: 'LZH 0962 ZN R',
      descricao: 'Descrição do Item 3',
      status: 'Aberto',
      severidade: 'Média',
      dataAbertura: '03/01/2023',
      dataConclusao: 'null',
      diasAberto: 'Atual',
    ),
    Item(
      id: 'RHX 7969 IH T',
      descricao: 'Descrição do Item 4',
      status: 'Fechado',
      severidade: 'Alta',
      dataAbertura: '04/01/2023',
      dataConclusao: '06/01/2023',
      diasAberto: '2',
    ),
    Item(
      id: 'ZZY 3732 QA P',
      descricao: 'Descrição do Item 5',
      status: 'Aberto',
      severidade: 'Baixa',
      dataAbertura: '05/01/2023',
      dataConclusao: 'null',
      diasAberto: 'Atual',
    ),
    Item(
      id: 'XMC 6350 OI T',
      descricao: 'Descrição do Item 6',
      status: 'Aberto',
      severidade: 'Média',
      dataAbertura: '06/01/2023',
      dataConclusao: 'null',
      diasAberto: 'Atual',
    ),
    Item(
      id: 'RAC 6352 NL N',
      descricao: 'Descrição do Item 7',
      status: 'Aberto',
      severidade: 'Baixa',
      dataAbertura: '07/01/2023',
      dataConclusao: 'null',
      diasAberto: 'Atual',
    ),
    Item(
      id: 'YIF 5975 BL Y',
      descricao: 'Descrição do Item 8',
      status: 'Fechado',
      severidade: 'Alta',
      dataAbertura: '08/01/2023',
      dataConclusao: '09/01/2023',
      diasAberto: '1',
    ),
  ];

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
                  Expanded(
                    child: items.isEmpty
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
    return Container(
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
            'ID ${item.id}',
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
          SizedBox(height: 8),
          Text(
            'Severidade: ${item.severidade}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Data de Abertura: ${item.dataAbertura}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Data de Conclusão: ${item.dataConclusao}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Dias Aberto: ${item.diasAberto}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String? id;
  final String? descricao;
  final String? status;
  final String? severidade;
  final String? dataAbertura;
  final String? dataConclusao;
  final String? diasAberto;

  Item({
    required this.id,
    required this.descricao,
    required this.status,
    required this.severidade,
    required this.dataAbertura,
    required this.dataConclusao,
    required this.diasAberto,
  });
}
