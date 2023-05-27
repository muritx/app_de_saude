import 'package:flutter/material.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:app_de_saude/scr_main_menu.dart';

class ScrAberturaRecl extends StatefulWidget {
  const ScrAberturaRecl({Key? key}) : super(key: key);

  @override
  State<ScrAberturaRecl> createState() => _ScrAberturaReclState();
}

class _ScrAberturaReclState extends State<ScrAberturaRecl> {
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
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nova Reclamação',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'Antes de prosseguir, precisamos confirmar que você deseja enviar seus dados pessoais à Ouvidoria para melhor atendê-lo:',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 160),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // todo
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          'Sim, envie meus dados pessoais',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          // todo
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          'Não, quero seguir anonimamente',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
