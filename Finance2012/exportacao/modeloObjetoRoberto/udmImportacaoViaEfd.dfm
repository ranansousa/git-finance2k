object dmImportacaoViaEfd: TdmImportacaoViaEfd
  OldCreateOrder = False
  Height = 723
  Width = 886
  object cdsParticipanteTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 452
    object cdsParticipanteTempID_FPARTICIPANTE: TStringField
      FieldName = 'ID_FPARTICIPANTE'
      Size = 40
    end
    object cdsParticipanteTempCOD_PART: TStringField
      FieldName = 'COD_PART'
      Size = 60
    end
    object cdsParticipanteTempNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsParticipanteTempINSCMF: TStringField
      FieldName = 'INSCMF'
      Size = 18
    end
    object cdsParticipanteTempTIPO_INSCMF: TIntegerField
      FieldName = 'TIPO_INSCMF'
    end
    object cdsParticipanteTempIE: TStringField
      FieldName = 'IE'
      Size = 14
    end
    object cdsParticipanteTempEND: TStringField
      FieldName = 'END'
      Size = 60
    end
    object cdsParticipanteTempNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object cdsParticipanteTempCOMPL: TStringField
      FieldName = 'COMPL'
      Size = 60
    end
    object cdsParticipanteTempBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 60
    end
    object cdsParticipanteTempEXISTE: TSmallintField
      FieldName = 'EXISTE'
    end
    object cdsParticipanteTempCOD_PAIS: TStringField
      FieldName = 'COD_PAIS'
      Size = 5
    end
    object cdsParticipanteTempCOD_MUN: TStringField
      FieldName = 'COD_MUN'
      Size = 7
    end
    object cdsParticipanteTempUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsParticipanteTempID_CIDADE: TStringField
      FieldName = 'ID_CIDADE'
      Size = 40
    end
    object cdsParticipanteTempID_ESTADO: TStringField
      FieldName = 'ID_ESTADO'
      Size = 40
    end
  end
  object cdsDFETemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 8
  end
  object cdsDFEAnaliticoTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 52
    Top = 68
  end
  object cdsDFSTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 52
    Top = 124
  end
  object cdsDFSAnaliticoTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 52
    Top = 178
  end
  object cdsDFSEcfTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 180
    Top = 8
  end
  object cdsDFSEcfAnaliticoTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 178
    Top = 68
  end
  object cdsCstPisCofinsSaidas: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxCodigo'
        Fields = 'CODIGO'
      end>
    IndexName = 'idxCodigo'
    Params = <>
    StoreDefs = True
    Left = 201
    Top = 384
    object cdsCstPisCofinsSaidasCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 2
    end
    object cdsCstPisCofinsSaidasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object cdsCstPisCofinsEntradas: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxCodigo'
        Fields = 'CODIGO'
      end>
    IndexName = 'idxCodigo'
    Params = <>
    StoreDefs = True
    Left = 239
    Top = 452
    object StringField1: TStringField
      FieldName = 'CODIGO'
      Size = 2
    end
    object StringField2: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object cdsDFSM2Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 52
    Top = 246
  end
  object cdsDFSM2AnaliticoTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 312
  end
  object qryCfop: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  C.ID_FCFOP,'
      '  C.CODIGO,'
      '  C.OPERACAO,'
      '  C.UTILIZACAO,'
      '  C.USO_ECF,'
      '  C.USO_MODELO_02'
      'FROM'
      '  FCFOP C'
      'WHERE'
      '  (C.CODIGO = :pCfop)'
      '')
    Left = 322
    Top = 206
    ParamData = <
      item
        Name = 'PCFOP'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object cdsCstIpi: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxCodigo'
        Fields = 'CODIGO'
      end>
    IndexName = 'idxCodigo'
    Params = <>
    StoreDefs = True
    Left = 333
    Top = 390
    object StringField3: TStringField
      FieldName = 'CODIGO'
      Size = 2
    end
    object StringField4: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object cdsDFSM2TempCondensado: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 386
  end
  object cdsDFSM2AnaliticoTempCondensado: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 458
  end
  object qryDFModelo: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  M.ID_FDF_MODELO,'
      '  M.CODIGO,'
      '  M.TIPO_DE_USO,'
      '  M.MODELO'
      'FROM'
      '  FDF_MODELO M'
      '')
    Left = 178
    Top = 134
  end
  object qryCidadeEstado: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  C.ID_CIDADES,'
      '  E.ID_ESTADOS,'
      '  C.CODIGO_IBGE,'
      '  E.SIGLA AS SIGLA_UF'
      'FROM'
      '  CIDADES C'
      'LEFT JOIN'
      '  ESTADOS E ON (C.FK_ESTADO = E.ID_ESTADOS)'
      'WHERE'
      '  (C.CODIGO_IBGE = :pCodigoMunicipio)'
      '')
    Left = 178
    Top = 194
    ParamData = <
      item
        Name = 'PCODIGOMUNICIPIO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryPais: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  P.ID_PAISES,'
      '  P.CODIGO_IBGE'
      'FROM'
      '  PAISES P'
      'WHERE'
      '  (P.CODIGO_IBGE = :pCodigoPais)'
      '')
    Left = 176
    Top = 248
    ParamData = <
      item
        Name = 'PCODIGOPAIS'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryDFSM2Analitico: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFS_M2_ANALITICO D'
      '')
    Left = 654
    Top = 132
  end
  object qryDFSM2: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFS_M2 D'
      '')
    Left = 654
    Top = 72
  end
  object qryEquipamentoECF: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  E.ID_FEQUIP_ECF,'
      '  E.SERIE_EQUIPAMENTO'
      'FROM'
      '  FEQUIP_ECF E'
      'WHERE'
      '  (E.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (E.SERIE_EQUIPAMENTO = :pEcfFab)'
      '')
    Left = 322
    Top = 8
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PECFFAB'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryPessoaFiscalParametros: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  PFP.ID_PESSOA_FISCAL_PARAMETROS,'
      '  PFP.DATA,'
      '  PFP.FK_PESSOA,'
      '  PFP.PIS_METODO_APROPRIACAO,'
      '  PFP.PIS_REGIME_ESCRITURACAO,'
      '  PFP.TIPO_ATIVIDADE_PREPONDERANTE,'
      '  PFP.PIS_INCIDENCIA_TRIBUTARIA,'
      '  PFP.ATIVIDADE_INDUSTRIA,'
      '  PFP.ATIVIDADE_COMERCIO,'
      '  PFP.ATIVIDADE_SERVICO_TRANSPORTE,'
      '  PFP.ATIVIDADE_SERVICO_COMUNICACAO,'
      '  PFP.ATIVIDADE_SERVICOS_OUTROS,'
      '  PFP.ATIVIDADE_SERVICO_ISSQN,'
      '  PFP.ATIVIDADE_VENDA_COMBUSTIVEL,'
      '  PFP.ATIVIDADE_ENERGIA_ELETRICA,'
      '  PFP.ATIVIDADE_PRODUCAO_RURAL'
      'FROM'
      '  PESSOA_FISCAL_PARAMETROS PFP'
      'WHERE'
      '  (PFP.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (PFP.DATA <= :pData)'
      'ORDER BY'
      '  PFP.DATA DESC'
      '')
    Left = 324
    Top = 72
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PDATA'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryParticipante: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  P.*,'
      '  C.ID_CIDADES,'
      '  E.ID_ESTADOS,'
      '  E.SIGLA AS SIGLA_UF'
      'FROM'
      '  FPARTICIPANTE P'
      'JOIN'
      '  CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES)'
      'JOIN'
      '  ESTADOS E ON (C.FK_ESTADO = E.ID_ESTADOS)'
      'WHERE'
      '  (P.FK_PESSOA = :pIdPessoa)'
      '')
    Left = 324
    Top = 134
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryDFE: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFE D'
      '')
    Left = 324
    Top = 264
  end
  object qryDFEAnalitico: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFE_ANALITICO D'
      '')
    Left = 324
    Top = 330
  end
  object qryDFS: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFS D'
      '')
    Left = 436
    Top = 10
  end
  object qryDFSAnalitico: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFS_ANALITICO D'
      '')
    Left = 440
    Top = 78
  end
  object qryDFSEcf: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFS_ECF D'
      '')
    Left = 442
    Top = 142
  end
  object qryDFSEcfAnalitico: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  D.*'
      'FROM'
      '  FDFS_ECF_ANALITICO D'
      '')
    Left = 444
    Top = 210
  end
  object qryVerificaDFE: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  L.NUMERO,'
      '  DF.LINHA,'
      '  DF.DATA_ENTRADA'
      'FROM'
      '  FDFE DF'
      'JOIN'
      '  FLOTE_ENTRADA L ON (DF.FK_LOTE = L.ID_FLOTE_ENTRADA)'
      'WHERE'
      '  (DF.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (DF.FK_DF_MODELO = :pIdDFModelo)'
      'AND'
      '  (DF.SERIE = :pSerie)'
      'AND'
      '  (DF.NUMERO = :pNumero)'
      'AND'
      '  (DF.FK_PARTICIPANTE = :pIdParticipante)'
      '')
    Left = 444
    Top = 272
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDDFMODELO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PSERIE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PNUMERO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDPARTICIPANTE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryVerificaDFS: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  L.NUMERO,'
      '  DF.LINHA,'
      '  DF.DATA_EMISSAO'
      'FROM'
      '  FDFS DF'
      'JOIN'
      '  FLOTE_SAIDA L ON (DF.FK_LOTE = L.ID_FLOTE_SAIDA)'
      'WHERE'
      '  (DF.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (DF.FK_DF_MODELO = :pIdDFModelo)'
      'AND'
      '  (DF.SERIE = :pSerie)'
      'AND'
      '  (DF.NUMERO = :pNumero)'
      'AND'
      '  (DF.FK_PARTICIPANTE = :pIdParticipante)'
      '')
    Left = 444
    Top = 336
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDDFMODELO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PSERIE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PNUMERO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDPARTICIPANTE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryVerificaDFSM2: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  L.NUMERO,'
      '  DF.LINHA,'
      '  DF.DATA_EMISSAO'
      'FROM'
      '  FDFS_M2 DF'
      'JOIN'
      '  FLOTE_SAIDA_M2 L ON (DF.FK_LOTE = L.ID_FLOTE_SAIDA_M2)'
      'WHERE'
      '  (DF.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (DF.SERIE = :pSerie)'
      'AND'
      
        '  ((:pNumeroInicial BETWEEN DF.NUMERO_INICIAL AND DF.NUMERO_FINA' +
        'L)'
      'OR'
      '  (:pNumeroFinal BETWEEN DF.NUMERO_INICIAL AND DF.NUMERO_FINAL))'
      '')
    Left = 528
    Top = 76
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PSERIE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PNUMEROINICIAL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PNUMEROFINAL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryVerificaDFSEcf: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  L.NUMERO,'
      '  DF.LINHA,'
      '  DF.DATA_EMISSAO'
      'FROM'
      '  FDFS_ECF DF'
      'JOIN'
      '  FLOTE_SAIDA_ECF L ON (DF.FK_LOTE = L.ID_FLOTE_SAIDA_ECF)'
      'WHERE'
      '  (DF.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (DF.FK_EQUIP_ECF = :pIdEquipEcf)'
      'AND'
      '  (((DF.CRZ = :pCRZ)'
      'AND'
      '  (DF.CRO = :pCRO)'
      'AND'
      '  (DF.COO_FINAL = :pCooFinal))'
      'OR'
      '  (DF.DATA_EMISSAO = :pDataEmissao))'
      '')
    Left = 528
    Top = 12
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDEQUIPECF'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PCRZ'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PCRO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PCOOFINAL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PDATAEMISSAO'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryNFMod_02_65: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT FIRST 1'
      '  DF.ID_FDFS_M2,'
      '  DF.FK_PESSOA,'
      '  DF.DATA_EMISSAO,'
      '  DF.FK_LOTE,'
      '  DF.LINHA,'
      '  DF.CODIGO_SITUACAO,'
      '  DF.SERIE,'
      '  DF.NUMERO_INICIAL,'
      '  DF.NUMERO_FINAL,'
      '  DF.VALOR,'
      '  DF.ART_377_RICMS,'
      '  DF.INSCMF,'
      '  DF.CHAVE_NFE,'
      '  DF.FK_DF_MODELO,'
      '  DFA.ID_FDFS_M2_ANALITICO,'
      '  DFA.FK_DFS_M2,'
      '  DFA.CST_ICMS,'
      '  DFA.CST_PIS_COFINS,'
      '  DFA.FK_CFOP,'
      '  DFA.VALOR_OPERACAO,'
      '  DFA.BASE_ICMS,'
      '  DFA.BASE_PIS_COFINS,'
      '  DFA.ALIQUOTA_PIS,'
      '  DFA.ALIQUOTA_COFINS,'
      '  DFA.ALIQUOTA_IR,'
      '  DFA.OBS,'
      '  DFA.ALIQUOTA_ICMS,'
      '  DFA.REDUCAO_BASE_ICMS,'
      '  DFA.OBS_SISTEMA,'
      '  DFA.VALOR_DESCONTO,'
      '  DFA.NATUREZA_RECEITA'
      'FROM'
      '  FDFS_M2 DF'
      'JOIN'
      '  FDFS_M2_ANALITICO DFA ON (DFA.FK_DFS_M2 = DF.ID_FDFS_M2)')
    Left = 654
    Top = 10
  end
  object cdsNFMod_02_65_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 656
    Top = 196
  end
end
