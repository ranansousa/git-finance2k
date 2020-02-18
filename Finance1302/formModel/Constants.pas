unit Constants;

interface

//type
//  TTipoOrdenacao = (
//    Alfabetica = 0,
//    Numerica);
//
//  TTipoRegimeMunicipal = (
//    trm_normal = 0,
//    trm_simples_nacional
//  );
//
//  TTipoRegimeEstadual = (
//    tre_conta_corrente = 0,
//    tre_simples_nacional
//  );
//
//  TTipoRegimeFederal = (
//    trf_nenhum = 0,
//    trf_lucro_presumido,
//    trf_lucro_real,
//    trf_sem_fins_lucrativos,
//    trf_simples_nacional,
//    trf_mei
//  );
//
//  TTipoRegimeConstituicao = (
//    trc_normal = 0,
//    trc_me,
//    trc_pp,
//    trc_mei,
//    trc_nenhum
//  );
//
//  TTipoRegimeConstituicao = (
//    trc_normal = 0,
//    trc_me,
//    trc_pp,
//    trc_mei,
//    trc_nenhum
//  );
//
//  TTipoProvisaoFiscal = (
//    tpf_cofins_credito = 0,
//    tpf_cofins_debito,
//    tpf_cofins_retida,
//    tpf_csll,
//    tpf_csll_retida,
//    tpf_icms_antecipacao_parcial,
//    tpf_icms_antecipacao_parcial_pgto,
//    tpf_icms_antecipacao_tributaria,
//    tpf_icms_devolucao_entradas,
//    tpf_icms_devolucao_saidas,
//    tpf_icms_diferencial_aliquotas,
//    tpf_icms_normal_credito,
//    tpf_icms_normal_debito,
//    tpf_icms_Art377_credito,
//    tpf_icms_Art377_debito,
//    tpf_icms_substituido_saidas,
//    tpf_icms_substituido_devolucao_saidas,
//    tpf_icms_substituido_outras_saidas,
//    tpf_importacao_aduana,
//    tpf_importacao_cofins,
//    tpf_importacao_icms,
//    tpf_importacao_imposto,
//    tpf_importacao_ipi,
//    tpf_importacao_pis,
//    tpf_importacao_siscomex,
//    tpf_imposto_renda,
//    tpf_inss_retido,
//    tpf_ipi_credito,
//    tpf_ipi_debito,
//    tpf_ipi_outras_entradas,
//    tpf_ipi_outras_saidas,
//    tpf_irrf,
//    tpf_iss,
//    tpf_iss_retido,
//    tpf_outras_retencoes,
//    tpf_pis_credito,
//    tpf_pis_debito,
//    tpf_pis_retido,
//    tpf_receita_servicos,
//    tpf_simples_nacional);
//
//  TTipoMensagem = (
//    tpMensagem_contracheque,
//    tpMensagem_rodape);
//
//  TConstsTipoInscMF = class
//  const
//     Juridica = 0;
//     Fisica   = 1;
//     CEI      = 2;
//  end;

const
  //Caracteres de controle para string
  TAB = #09; //Tabulação

  // sessão
  INI_SESSAO_CORES: String = 'COLORS';
  INI_SESSAO_REPPORT: String = 'REPORT';
  INI_SESSAO_TELAS: String = 'TELAS';

  // keys
  INI_KEYS_CONTROLS: String = 'CONTROLS';
  INI_KEYS_FORMS: String = 'FORMS';
  INI_KEYS_FONTS: String = 'FONTS';
  INI_KEYS_LOGOMARCA: String = 'LOGOMARCA';
  INI_KEYS_TELA_ENTRADAS = 'ENTRADAS';
  INI_KEYS_TELA_ENTRADAS_SERVICO = 'ENTRADAS_SERVICO';
  INI_KEYS_TELA_SAIDAS = 'SAIDAS';
  INI_KEYS_TELA_SAIDAS_ECF = 'SAIDAS_ECF';
  INI_KEYS_TELA_SAIDAS_MODELO_02 = 'SAIDAS_MODELO_02';
  INI_KEYS_TELA_SAIDAS_SERVICO = 'SAIDAS_MODELO_SERVICO';

  CODIGO_PESSOA_MIN_LEN : Integer = 5;

  {Datas para controle da aplicação}
  TP_DATA_MAXIMA_LIMITE: Integer = 55153; //55153 corresponde a 31.12.2050
//  TP_DATA_INICIAL: Integer = 29221;  //29221 corresponde a 01.01.1980
  TP_DATA_INICIAL: Integer = 2;  //2 corresponde a 01.01.1900
  TP_DATA_EMPTY: Integer = -693594;  //-693594 corresponde a data vazia

  {Tipos de Regime Municipal}
  TP_REGIME_MUNICIPAL_NORMAL: Integer = 0;
  TP_REGIME_MUNICIPAL_SIMPLES_NACIONAL: Integer = 1;

  {Tipos de Regime Estadual}
//  TP_REGIME_ESTADUAL_ESPECIAL: Integer = 0;
  TP_REGIME_ESTADUAL_CONTA_CORRENTE: Integer = 0;
  TP_REGIME_ESTADUAL_SIMPLES_NACIONAL: Integer = 1;

  {Tipos de Regime Federal}
  TP_REGIME_FEDERAL_NENHUM: Integer = 0;
  TP_REGIME_FEDERAL_LUCRO_PRESUMIDO: Integer = 1;
  TP_REGIME_FEDERAL_LUCRO_REAL: Integer = 2;
  TP_REGIME_FEDERAL_SEM_FINS_LUCRATIVOS: Integer = 3;
  TP_REGIME_FEDERAL_SIMPLES_NACIONAL: Integer = 4;
  TP_REGIME_FEDERAL_MEI: Integer = 5;

  {Constantes de SEXO}
  TP_SEXO_MASCULINO: Integer = 0;
  TP_SEXO_FEMININO: Integer = 1;

  TP_VL_MIN_REC_PREVIDENCIA: Currency = 29.00;
  TP_VL_MIN_REC_IMPOSTOS_FEDERAIS: Currency = 10.00; {LEI Nº 9.430, DE 27 DE DEZEMBRO DE 1996.

                                                      Art. 67. Fica dispensada a retenção de imposto de renda, de valor
                                                      igual ou inferior a R$ 10,00 (dez reais), incidente na fonte sobre
                                                      rendimentos que devam integrar a base de cálculo do imposto devido
                                                      na declaração de ajuste anual.

                                                      http://www.planalto.gov.br/ccivil_03/LEIS/L9430.htm#art67}

                                                      {Decreto nº 3.000, de 26 de março de 1999 - Dispensa de Retenção
                                                      Art. 724.  É dispensada a retenção de imposto, de valor igual ou inferior
                                                      a dez reais, incidente na fonte sobre rendimentos que devam integrar
                                                      (Lei nº 9.430, de 1996, art. 67):
                                                      I - a base de cálculo do imposto devido na declaração de ajuste anual das
                                                      pessoas físicas;
                                                      II - a base de cálculo do imposto devido pelas pessoas jurídicas tributadas
                                                      com base no lucro real, presumido ou arbitrado.}
//  {Tipo de Mensagem}
//  TP_MENSAGEM_RODAPE = 0;
//  TP_MENSAGEM_CONTRACHEQUE = 1;

  TP_PROGRAMA_CONTABIL = 0;
  TP_PROGRAMA_FISCAL   = 1;
  TP_PROGRAMA_PESSOAL  = 2;

  COD_EMPRESA_MIN_LEN      : Integer = 4;
  CODIGO_SINDICATO_MIN_LEN : Integer = 3;

  TP_BUSCA_DATA_MENOR: Integer = 0;
  TP_BUSCA_DATA_MENOR_IGUAL: Integer = 1;
  TP_BUSCA_DATA_EXATA: Integer = 2;
  TP_BUSCA_DATA_MAIOR: Integer = 3;
  TP_BUSCA_DATA_MAIOR_IGUAL: Integer = 4;
  TP_BUSCA_DATA_MAXIMA: Integer = 5;
  TP_BUSCA_NO_MES: Integer = 6;

  {Essa constante é utilizada para atrinuir zero a variáveis, pois,
  nesse caso, o delphi não cria um área na memória para armazenar o zero.
  Ele aponta a variável para o mesmo lugar dessa constante.}
  TP_ZERO: Integer = 0;

  {Tamanhos das Inscrições do Ministerio da Fazenda com e sem máscara }
  TAMANHO_CPF_SEM_MASCARA  = 11;
  TAMANHO_CPF_COM_MASCARA  = 14;
  TAMANHO_CNPJ_SEM_MASCARA = 14;
  TAMANHO_CNPJ_COM_MASCARA = 18;
  TAMANHO_CEI_SEM_MASCARA  = 12;
  TAMANHO_CEI_COM_MASCARA  = 16;

  {Caracter utilizado para separar as informações do Log, no campo OBS, da
  tabela UCTABHISTORY}
//  CARACTER_SEPARADOR_LOG  = 135;
//  CARACTER_SEPARADOR_LOG  = 96;
  CARACTER_SEPARADOR_LOG  = '=#=';

implementation

end.
