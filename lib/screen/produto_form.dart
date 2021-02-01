import 'package:flutter/material.dart';
import 'package:DrezuBiju/model/ProdutoModel.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../utils/utils.dart' as Utils;

class Screen extends StatefulWidget {
  final ProdutoModel pModel;

  Screen({Key key, @required this.pModel}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  ProdutoModel pModel;
  TextEditingController vVendaController, vAPagarController;

  @override
  void initState() {
    super.initState();

    pModel = widget.pModel;

    pModel.valorPagar = pModel.valorPagar == null ? pModel.valorPagar : 0.0;
    pModel.valorPagar = pModel.valorVenda == null ? pModel.valorVenda : 0.0;

    vAPagarController = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        initialValue: pModel.valorPagar);

    vVendaController = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        initialValue: pModel.valorVenda);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tipos = Utils.TIPOS_PRODUTO;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          color: Utils.BACKGROUND_BASE,
          margin: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Cadastro Produto",
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                new DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Tipo'),
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: pModel.tipo == null
                      ? null
                      : tipos[tipos.indexOf(pModel.tipo)],
                  items: tipos
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      pModel.tipo = value;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: pModel.codigo != null ? pModel.codigo : "",
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Código"),
                  onSaved: (newValue) {
                    setState(() {
                      pModel.codigo = newValue;
                    });
                  },
                ),
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: vVendaController,
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Valor Venda"),
                  onSaved: (newValue) {
                    setState(() {
                      pModel.valorVenda = stringToDouble(newValue);
                    });
                  },
                ),
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: vAPagarController,
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Valor a Pagar"),
                  onSaved: (newValue) {
                    setState(() {
                      pModel.valorPagar = stringToDouble(newValue);
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton.icon(
                      onPressed: () {},
                      color: Colors.pink,
                      label: Text("Voltar"),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    RaisedButton.icon(
                      onPressed: () {},
                      color: Colors.pink,
                      label: Text("Excluir"),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.white,
                      ),
                    ),
                    RaisedButton.icon(
                      onPressed: () {
                        _formKey.currentState.save();
                      },
                      color: Colors.pink,
                      textColor: Colors.white,
                      label: Text("Salvar"),
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double stringToDouble(String str) {
    if (str.isEmpty) return 0;

    str = str.replaceAll("\.", "").replaceAll(",", ".");
    return double.parse(str);
  }

  String doubleToString(double dbl) {
    if (dbl == null) return "0";
    return dbl.toString();
  }
}
