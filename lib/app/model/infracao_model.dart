enum ResponsavelInfracao {
  condutor,
  proprietario,
  transportador,
  embarcador,
  embarcador_transportador,
}

enum GravidadeInfracao {
  leve,
  media,
  grave,
  gravissima,
}

enum TipoFiscalizacaoPeso {
  balanca,
  nota_fiscal,
}

class InfracaoModel {
  String codigo;
  String artigoCtb;
  String amparoLegal;
  String observacaoAuto;
  String medidaAdministrativa;
  ResponsavelInfracao responsavel;
  double valor;
  String observacoes;
  GravidadeInfracao gravidade;

  InfracaoModel({
    this.codigo,
    this.artigoCtb,
    this.amparoLegal,
    this.observacaoAuto,
    this.medidaAdministrativa,
    this.responsavel,
    this.valor,
    this.observacoes,
    this.gravidade,
  });
}
