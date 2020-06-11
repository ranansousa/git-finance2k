object dmInformacoesSefip: TdmInformacoesSefip
  OldCreateOrder = False
  Height = 391
  Width = 666
  object qryColaboradores: TFDQuery
    SQL.Strings = (
      'SELECT'
      
        '/*O comando list '#233' utilizado em R_IDS, pois o funcion'#225'rio pode t' +
        'er sido '
      
        'transferido para outro estabelecimento e depois retornado no mes' +
        'mo '
      
        'm'#234's. E, nesse caso n'#227'o pode existir para a SEFIP, dois registros' +
        ' do mesmo'
      
        'funcion'#225'rio para o mesmo m'#234's. Depois verificar se ao inv'#233's de ut' +
        'ilizar essa '
      
        'solu'#231#227'o, a utiliza'#231#227'o de MATRICULA_E_SOCIAL n'#227'o resolveria o pro' +
        'blema*/'
      
        '  CAST(LIST(CHR(39)||R_ID||CHR(39),'#39','#39') AS VARCHAR(500)) AS R_ID' +
        'S,'
      '--  CAST(LIST(R_ID,'#39','#39') AS VARCHAR(500)) AS R_IDS,'
      
        '  CAST(LIST(IIF(R_CODIGO_MOVIMENTACAO IN ('#39'I1'#39','#39'I2'#39','#39'I3'#39','#39'I4'#39','#39'J' +
        #39','#39'K'#39','#39'L'#39','#39'S2'#39','#39'S3'#39'),R_DATA_SAIDA,'#39#39'),'#39','#39') AS VARCHAR(500)) AS R' +
        '_DATA_SAIDA,'
      
        '  CAST(LIST(R_CODIGO_MOVIMENTACAO,'#39','#39') AS VARCHAR(500)) AS R_COD' +
        'IGO_MOVIMENTACAO,'
      '--  R_ID_LOCAL,'
      '--  R_DESCRICAO_LOCAL,'
      '  R_INSCMF_TOMADOR,'
      '  R_ID_TOMADOR,'
      '  R_DATA_INICIAL_TOMADOR,'
      '  R_DATA_FINAL_TOMADOR,  R_TIPO_COLABORADOR,'
      '  R_PIS_INSS,'
      '  R_DATA_ADMISSAO,'
      '--  R_DATA_SAIDA,'
      '  R_CATEGORIA_FGTS,'
      '  R_NOME,'
      '  R_MATRICULA_E_SOCIAL,'
      '  R_CTPS,'
      '  R_SERIE_CTPS,'
      '  R_DATA_OPCAO,'
      '  R_DATA_NASCIMENTO,'
      '  CAST(LIST(R_CBO,'#39','#39') AS VARCHAR(500)) AS R_CBO,'
      '  R_OCORRENCIA,'
      '--  R_CODIGO_MOVIMENTACAO,'
      '--  R_DATA_MOVIMENTACAO,'
      '  R_INDICATIVO_RECOLHIMENTO_FGTS,'
      '  R_REMUNERACAO_OUTRAS_EMPRESAS,'
      '  R_DATA_INICIO_MATERNIDADE,'
      '  R_DATA_FIM_MATERNIDADE,'
      '  R_DATA_INICIO_AFASTAMENTO,'
      '  R_DATA_FIM_AFASTAMENTO,'
      '  R_VINCULO,'
      '  R_EMPREITADA_TOTAL_OBRA_PROPRI,'
      '  R_SAIDA_RETORNO_AFASTAMENTO,'
      '  R_SEXO,'
      '  R_GRFC,'
      '  R_ACIDENTADO,'
      '  sum(R_VL_DESC_ADTO_13) AS R_VL_DESC_ADTO_13,'
      '  sum(R_13_RESCISAO) AS R_13_RESCISAO,'
      '  sum(R_REMUNERACAO) AS R_REMUNERACAO,'
      '  sum(R_REMUNERACAO13) AS R_REMUNERACAO13,'
      '  sum(R_13_MOVIMENTO) AS R_13_MOVIMENTO,'
      '  sum(R_13_GPS13) AS R_13_GPS13,'
      '  sum(R_13_DIFERENCA) AS R_13_DIFERENCA,'
      '  sum(R_13_INDENIZADO) AS R_13_INDENIZADO,'
      '  sum(R_DESC_13_DIFERENCA) AS R_DESC_13_DIFERENCA,'
      '  sum(R_DESCONTO_PREVIDENCIA) AS R_DESCONTO_PREVIDENCIA ,'
      
        '  sum(R_BASE_PREVIDENCIA_ACIDENTE) AS R_BASE_PREVIDENCIA_ACIDENT' +
        'E,'
      '  sum(R_INSS_13_RESCISAO) AS R_INSS_13_RESCISAO,'
      
        '  sum(R_INSS_13_SALARIO_DIFERENCA) AS R_INSS_13_SALARIO_DIFERENC' +
        'A,'
      '  sum(R_VL_AVISO_PREVIO) AS R_VL_AVISO_PREVIO'
      'FROM'
      
        '  SP_PCOLABORADORES_DADOS_SEFIP(:PIDPESSOA, :PDATAINICIAL, :PDAT' +
        'AFINAL, :POBRAPROPRIA, :PGPS13, :PTIPORECOLHIMENTO) S'
      'WHERE'
      
        '  (((ABS(S.R_REMUNERACAO) + ABS(S.R_REMUNERACAO13) + ABS(S.R_BAS' +
        'E_PREVIDENCIA_ACIDENTE)) > 0)'
      'AND'
      '  (:PGPS13 = 0))'
      'OR'
      '  ((S.R_13_MOVIMENTO > 0)'
      'AND'
      '  (:PGPS13 = -1))'
      'OR'
      '  (R_SAIDA_RETORNO_AFASTAMENTO = -1)   '
      'GROUP BY'
      '--  R_ID,'
      '--  R_ID_LOCAL,'
      '--  R_DESCRICAO_LOCAL,'
      '  R_INSCMF_TOMADOR,'
      '  R_ID_TOMADOR,'
      '  R_DATA_INICIAL_TOMADOR,'
      '  R_DATA_FINAL_TOMADOR,  R_TIPO_COLABORADOR,'
      '  R_PIS_INSS,'
      '  R_DATA_ADMISSAO,'
      '--  R_DATA_SAIDA,'
      '  R_CATEGORIA_FGTS,'
      '  R_NOME,'
      '  R_MATRICULA_E_SOCIAL,'
      '  R_CTPS,'
      '  R_SERIE_CTPS,'
      '  R_DATA_OPCAO,'
      '  R_DATA_NASCIMENTO,'
      '--  R_CBO,'
      '  R_OCORRENCIA,'
      '--  R_CODIGO_MOVIMENTACAO,'
      '--  R_DATA_MOVIMENTACAO,'
      '  R_INDICATIVO_RECOLHIMENTO_FGTS,'
      '  R_REMUNERACAO_OUTRAS_EMPRESAS,'
      '  R_DATA_INICIO_MATERNIDADE,'
      '  R_DATA_FIM_MATERNIDADE,'
      '  R_DATA_INICIO_AFASTAMENTO,'
      '  R_DATA_FIM_AFASTAMENTO,'
      '  R_VINCULO,'
      '--  R_VL_DESC_ADTO_13,'
      '--  R_13_RESCISAO,'
      '  R_EMPREITADA_TOTAL_OBRA_PROPRI,'
      '  R_SAIDA_RETORNO_AFASTAMENTO,'
      '  R_SEXO,'
      '  R_GRFC,'
      '  R_ACIDENTADO')
    Left = 70
    Top = 50
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'POBRAPROPRIA'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PGPS13'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PTIPORECOLHIMENTO'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryColaboradoresSefip650: TFDQuery
    SQL.Strings = (
      'SELECT'
      
        '  CAST(LIST(CHR(39)||R_ID||CHR(39),'#39','#39') AS VARCHAR(500)) AS R_ID' +
        'S,'
      
        '  CAST(LIST(IIF(R_CODIGO_MOVIMENTACAO IN ('#39'I1'#39','#39'I2'#39','#39'I3'#39','#39'I4'#39','#39'J' +
        #39','#39'K'#39','#39'L'#39','#39'S2'#39','#39'S3'#39'),R_DATA_SAIDA,'#39#39'),'#39','#39') AS VARCHAR(500)) AS R' +
        '_DATA_SAIDA,'
      '  '#39#39' AS R_CODIGO_MOVIMENTACAO,'
      '  R_TIPO_COLABORADOR,'
      '  R_PIS_INSS,'
      '  R_DATA_ADMISSAO,'
      '  R_CATEGORIA_FGTS,'
      '  R_NOME,'
      '  R_MATRICULA_E_SOCIAL,'
      '  R_CTPS,'
      '  R_SERIE_CTPS,'
      '  R_DATA_OPCAO,'
      '  R_DATA_NASCIMENTO,'
      '  CAST(LIST(R_CBO,'#39','#39') AS VARCHAR(500)) AS R_CBO,'
      '  R_OCORRENCIA,'
      '  R_INDICATIVO_RECOLHIMENTO_FGTS,'
      '  R_REMUNERACAO_OUTRAS_EMPRESAS,'
      '  R_VINCULO,'
      '--  R_EMPREITADA_TOTAL_OBRA_PROPRI,'
      '  R_SEXO,'
      '  sum(R_VL_DESC_ADTO_13) AS R_VL_DESC_ADTO_13,'
      '  sum(R_13_RESCISAO) AS R_13_RESCISAO,'
      '  sum(R_REMUNERACAO) AS R_REMUNERACAO,'
      '  sum(R_REMUNERACAO13) AS R_REMUNERACAO13,'
      '  sum(R_13_MOVIMENTO) AS R_13_MOVIMENTO,'
      '  sum(R_13_GPS13) AS R_13_GPS13,'
      '  sum(R_13_DIFERENCA) AS R_13_DIFERENCA,'
      '  sum(R_DESC_13_DIFERENCA) AS R_DESC_13_DIFERENCA,'
      '  sum(R_DESCONTO_PREVIDENCIA) AS R_DESCONTO_PREVIDENCIA ,'
      
        '  sum(R_BASE_PREVIDENCIA_ACIDENTE) AS R_BASE_PREVIDENCIA_ACIDENT' +
        'E,'
      '  sum(R_INSS_13_RESCISAO) AS R_INSS_13_RESCISAO,'
      
        '  sum(R_INSS_13_SALARIO_DIFERENCA) AS R_INSS_13_SALARIO_DIFERENC' +
        'A'
      'FROM'
      
        '  SP_PCOLABORADORES_DADOS_SEFIP(:PIDPESSOA, :PDATAINICIAL, :PDAT' +
        'AFINAL, :POBRAPROPRIA, :PGPS13, :PTIPORECOLHIMENTO) S'
      'WHERE'
      
        '  (((ABS(S.R_REMUNERACAO) + ABS(S.R_REMUNERACAO13) + ABS(S.R_BAS' +
        'E_PREVIDENCIA_ACIDENTE)) > 0)'
      'AND'
      '  (:PGPS13 = 0))'
      'OR'
      '  ((S.R_13_MOVIMENTO > 0)'
      'AND'
      '  (:PGPS13 = -1))'
      'OR'
      '  (R_SAIDA_RETORNO_AFASTAMENTO = -1)'
      'GROUP BY'
      '  R_TIPO_COLABORADOR,'
      '  R_PIS_INSS,'
      '  R_DATA_ADMISSAO,'
      '  R_CATEGORIA_FGTS,'
      '  R_NOME,'
      '  R_MATRICULA_E_SOCIAL,'
      '  R_CTPS,'
      '  R_SERIE_CTPS,'
      '  R_DATA_OPCAO,'
      '  R_DATA_NASCIMENTO,'
      '  R_OCORRENCIA,'
      '  R_INDICATIVO_RECOLHIMENTO_FGTS,'
      '  R_REMUNERACAO_OUTRAS_EMPRESAS,'
      '  R_VINCULO,'
      '--  R_EMPREITADA_TOTAL_OBRA_PROPRI,'
      '  R_SEXO')
    Left = 70
    Top = 114
    ParamData = <
      item
        Name = 'PIDPESSOA'
        ParamType = ptInput
      end
      item
        Name = 'PDATAINICIAL'
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        ParamType = ptInput
      end
      item
        Name = 'POBRAPROPRIA'
        ParamType = ptInput
      end
      item
        Name = 'PGPS13'
        ParamType = ptInput
      end
      item
        Name = 'PTIPORECOLHIMENTO'
        ParamType = ptInput
      end>
  end
  object qryFuncionarioSituacaoLinha32: TFDQuery
    Left = 224
    Top = 48
  end
  object qrySpDiasTrabalhados: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      
        'SELECT * FROM SP_PDIASTRAB(:pDataInicial,:pDataFinal,:pIdFuncion' +
        'ario)')
    Left = 220
    Top = 120
    ParamData = <
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDFUNCIONARIO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
