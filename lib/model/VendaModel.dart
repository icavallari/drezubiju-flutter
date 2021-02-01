import 'package:DrezuBiju/model/ProdutoModel.dart';

class VendaModel {
  int id;
  bool pago;
  String comprador;
  DateTime dataVenda;
  List<ProdutoModel> produtos;

  VendaModel({
    this.id,
    this.pago,
    this.comprador,
    this.dataVenda,
    this.produtos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pago': pago,
      'comprador': comprador,
      'dataVenda': dataVenda,
    };
  }

  VendaModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.pago = map['pago'];
    this.comprador = map['comprador'];
    this.dataVenda = map['dataVenda'];
  }
}
