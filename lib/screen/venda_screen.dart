import 'package:DrezuBiju/screen/produto_card.dart';
import 'package:flutter/material.dart';

import 'produto_form.dart' as ProdutoScreen;
import '../utils/utils.dart' as Utils;

import 'package:DrezuBiju/model/ProdutoModel.dart';

class Screen extends StatefulWidget {
  Screen({Key key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool _pago = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Utils.BACKGROUND_BASE,
      ),
      body: Column(
        children: [
          Material(
            elevation: 4,
            color: Utils.BACKGROUND_BASE,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cadastro Venda",
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    new SwitchListTile(
                      title: Text(
                        'Pagamento realizado?',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: _pago,
                      onChanged: (value) {
                        setState(() {
                          _pago = !_pago;
                        });
                      },
                      secondary: const Icon(Icons.payments_outlined),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Comprador",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 10, child: null)
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 4),
              child: ProdutoCard(),
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: 20,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.pink,
            elevation: 4,
            onTap: (idx) {
              switch (idx) {
                case 0:
                  Navigator.pop(context);
                  break;
                case 1:
                  _showConfirmExclusao(context);
                  break;
                case 2:
                  break;
                default:
                  _showBottomSheet(context);
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                title: Text(
                  "Voltar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  "Excluir",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.save, color: Colors.white),
                title: Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.plus_one, color: Colors.white),
                title: Text(
                  "Produto",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmExclusao(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Deseja excluir está venda?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("NÃO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("SIM"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      backgroundColor: Utils.BACKGROUND_BASE,
      builder: (BuildContext ctx) {
        return ProdutoScreen.Screen(
          pModel: new ProdutoModel(),
        );
      },
    ).then((value) => {print(ProdutoModel.fromDynamic(value))});
  }
}
