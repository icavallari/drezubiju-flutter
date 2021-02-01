class ProdutoModel {
  int id;
  String tipo;
  String codigo;
  double valorVenda;
  double valorPagar;
  int solicitacaoId;

  ProdutoModel({
    this.id,
    this.tipo,
    this.codigo,
    this.valorVenda,
    this.valorPagar,
    this.solicitacaoId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'codigo': codigo,
      'valorVenda': valorVenda,
      'valorPagar': valorPagar,
      'solicitacaoId': solicitacaoId,
    };
  }

  ProdutoModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.tipo = map['tipo'];
    this.codigo = map['codigo'];
    this.valorVenda = map['valorVenda'];
    this.valorPagar = map['valorPagar'];
    this.solicitacaoId = map['solicitacaoId'];
  }

  ProdutoModel.fromDynamic(dynamic value) {
    this.id = value.id;
    this.tipo = value.tipo;
    this.codigo = value.codigo;
    this.valorVenda = value.valorVenda;
    this.valorPagar = value.valorPagar;
    this.solicitacaoId = value.solicitacaoId;
  }
}
