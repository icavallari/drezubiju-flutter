import 'package:flutter/material.dart';
import 'venda_screen.dart' as Venda;
import '../utils/utils.dart' as Utils;

class Screen extends StatefulWidget {
  Screen({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  bool _hideFAB = false;
  ScrollController _sController;

  @override
  void initState() {
    super.initState();

    _sController = ScrollController();
    _sController.addListener(() {
      setState(() {
        _hideFAB = _sController.hasClients && _sController.offset > 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Utils.BACKGROUND_BASE,
      ),
      body: Column(children: [
        _cabecalho(),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 4),
            child: _itensListView(context, _sController),
          ),
        )
      ]),
      floatingActionButton: _hideFAB
          ? Container()
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Venda.Screen()),
                );
              },
              label: Text("Venda"),
              icon: Icon(Icons.add),
            ),
    );
  }
}

Widget _cabecalho() {
  return Material(
    elevation: 4,
    color: Utils.BACKGROUND_BASE,
    child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Olá Andressa"),
          Text(
            " =)",
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "0",
                  style: TextStyle(fontSize: 30),
                ),
                Text("Itens Vendidos"),
              ],
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.all(7),
            child: Image.asset('assets/images/logo.png'),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "0",
                  style: TextStyle(fontSize: 30),
                ),
                Text("Itens Pagos"),
              ],
            ),
          ),
        ],
      ),
    ]),
  );
}

Widget _itensListView(BuildContext context, ScrollController sController) {
  return ListView.builder(
    itemCount: 20,
    controller: sController,
    itemBuilder: (context, index) {
      return Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          tileColor: Colors.white,
          title: Text("Comprador nome $index"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "X Produtos",
                textAlign: TextAlign.start,
              ),
              Text(
                "status",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
