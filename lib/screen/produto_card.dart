import 'package:flutter/material.dart';
import 'package:DrezuBiju/model/ProdutoModel.dart';
import 'package:DrezuBiju/repository/DbHelper.dart';

class ProdutoCard extends StatefulWidget {
  ProdutoCard({Key key}) : super(key: key);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<ProdutoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<ProdutoModel>>(
        future: DbHelper().getProdutos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              ProdutoModel pModel = snapshot.data[index];

              return Card(
                margin: EdgeInsets.all(5),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text("$pModel.codigo - $pModel.tipo"),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Valor Venda: $pModel.valorVenda",
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Valor Pagar: $pModel.valorPagar",
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
        },
      ),
    );
  }
}
