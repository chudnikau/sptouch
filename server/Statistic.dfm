object FStatistic: TFStatistic
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = #1054#1073#1097#1072#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1072
  ClientHeight = 386
  ClientWidth = 437
  Color = clBtnFace
  Constraints.MinHeight = 428
  Constraints.MinWidth = 453
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 386
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 5
      Top = 113
      Width = 423
      Height = 231
      Align = alClient
      Caption = '['#1040#1082#1090#1080#1074#1085#1099#1077' '#1093#1086#1089#1090#1099']'
      TabOrder = 0
      DesignSize = (
        423
        231)
      object dxDBGrid1: TdxDBGrid
        Left = 10
        Top = 20
        Width = 402
        Height = 170
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        SummaryGroups = <>
        SummarySeparator = ', '
        TabOrder = 0
        DataSource = dtsStatus
        Filter.Criteria = {00000000}
        HideFocusRect = True
        HideSelectionColor = 13033187
        HideSelectionTextColor = clNone
        HighlightColor = 13033187
        HighlightTextColor = clNone
        LookAndFeel = lfFlat
        OptionsCustomize = [edgoColumnSizing]
        OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
        Anchors = [akLeft, akTop, akRight, akBottom]
        object dxDBGrid1Id: TdxDBGridColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Id'
        end
        object dxDBGrid1User: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'User'
        end
        object dxDBGrid1Host: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Host'
        end
        object dxDBGrid1db: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'db'
        end
        object dxDBGrid1Command: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Command'
        end
        object dxDBGrid1Time: TdxDBGridColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Time'
        end
        object dxDBGrid1State: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'State'
        end
        object dxDBGrid1Info: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Info'
        end
      end
      object BtnRefresh: TBitBtn
        Left = 10
        Top = 197
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '&'#1054#1073#1085#1086#1074#1080#1090#1100
        TabOrder = 1
        OnClick = BtnRefreshClick
      end
    end
    object Panel2: TPanel
      Left = 5
      Top = 344
      Width = 423
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        423
        33)
      object BitBtn1: TBitBtn
        Left = 346
        Top = 7
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        ModalResult = 1
        TabOrder = 0
        NumGlyphs = 2
      end
    end
    object Panel3: TPanel
      Left = 5
      Top = 5
      Width = 423
      Height = 108
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object L1: TLabel
        Left = 6
        Top = 1
        Width = 116
        Height = 13
        Caption = #1058#1077#1082#1091#1097'. '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L2: TLabel
        Left = 6
        Top = 21
        Width = 65
        Height = 13
        Caption = #1056#1072#1079#1084#1077#1088' '#1041#1044':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L3: TLabel
        Left = 6
        Top = 40
        Width = 200
        Height = 13
        Caption = #1050#1086#1083#1083'. '#1086#1087#1088#1072#1096#1080#1074#1072#1077#1084#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L4: TLabel
        Left = 6
        Top = 61
        Width = 115
        Height = 13
        Caption = #1058#1077#1082#1091#1097'. lock '#1087#1072#1088#1086#1083#1100':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 6
        Top = 83
        Width = 90
        Height = 13
        Caption = #1042#1088#1077#1084#1103' '#1089#1077#1088#1074#1077#1088#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ServerTime: TLabel
        Left = 215
        Top = 83
        Width = 67
        Height = 13
        Caption = 'LockPassword'
      end
      object LockPassword: TLabel
        Left = 215
        Top = 61
        Width = 67
        Height = 13
        Caption = 'LockPassword'
      end
      object CountRequestParams: TLabel
        Left = 215
        Top = 40
        Width = 104
        Height = 13
        Caption = 'CountRequestParams'
      end
      object DBSize: TLabel
        Left = 215
        Top = 21
        Width = 32
        Height = 13
        Caption = 'DBSize'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Connection: TLabel
        Left = 215
        Top = 1
        Width = 54
        Height = 13
        Caption = 'Connection'
      end
    end
  end
  object dtsStatus: TDataSource
    DataSet = dtbStatus
    Left = 168
    Top = 200
  end
  object dtbStatus: TZQuery
    Connection = DM.MySQLConnection
    SQL.Strings = (
      'SHOW PROCESSLIST')
    Params = <>
    Left = 200
    Top = 200
    object dtbStatusId: TLargeintField
      FieldName = 'Id'
      ReadOnly = True
    end
    object dtbStatusUser: TStringField
      FieldName = 'User'
      ReadOnly = True
      Size = 10
    end
    object dtbStatusHost: TStringField
      FieldName = 'Host'
      ReadOnly = True
      Size = 21
    end
    object dtbStatusdb: TStringField
      FieldName = 'db'
      ReadOnly = True
      Size = 21
    end
    object dtbStatusCommand: TStringField
      FieldName = 'Command'
      ReadOnly = True
      Size = 5
    end
    object dtbStatusTime: TLargeintField
      FieldName = 'Time'
      ReadOnly = True
    end
    object dtbStatusState: TStringField
      FieldName = 'State'
      ReadOnly = True
      Size = 10
    end
    object dtbStatusInfo: TStringField
      FieldName = 'Info'
      ReadOnly = True
      Size = 33
    end
  end
end
