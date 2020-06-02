object dmImobilizado: TdmImobilizado
  OldCreateOrder = False
  Height = 334
  Width = 614
  object qryCadastraBem: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      ' ID                 INTEGER NOT NULL,'
      '    EMPRESA            INTEGER NOT NULL,'
      '    GRUPO              INTEGER NOT NULL,'
      '    CODIGO             INTEGER NOT NULL,'
      '    DESCRICAO          VARCHAR(70),'
      '    DATAAQ             TIMESTAMP,'
      '    VALORAQ            NUMERIC(18,2),'
      '    TIPO               VARCHAR(11),'
      
        '    CTDESTCM           CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTDESTDP           CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTPARTCM           CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTPARTDP           CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTDESTCM_LEI11638  CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTPARTCM_LEI11638  CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTDESTDP_LEI11638  CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */,'
      
        '    CTPARTDP_LEI11638  CONTA_CONTABIL /* CONTA_CONTABIL = VARCHA' +
        'R(30) */')
    Left = 384
    Top = 104
  end
end
