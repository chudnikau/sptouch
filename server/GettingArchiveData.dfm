object FGettingArchiveData: TFGettingArchiveData
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1088#1086#1089' '#1072#1088#1093#1080#1074#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
  ClientHeight = 309
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    305
    309)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfo: TLabel
    Left = 0
    Top = 281
    Width = 305
    Height = 28
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = #1054#1055#1056#1040#1064#1048#1042#1040#1070
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
    ExplicitLeft = -6
    ExplicitTop = 333
    ExplicitWidth = 308
  end
  object BtnGetData: TBitBtn
    Left = 222
    Top = 277
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&'#1055#1086#1083#1091#1095#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtnGetDataClick
  end
  object GroupBox2: TGroupBox
    Left = 7
    Top = 4
    Width = 292
    Height = 221
    Anchors = [akLeft, akTop, akRight]
    Caption = '['#1059#1089#1083#1086#1074#1080#1103' '#1079#1072#1087#1088#1086#1089#1072']'
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 18
      Width = 42
      Height = 13
      Caption = #1055#1088#1080#1073#1086#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SBChooserMeter: TSpeedButton
      Left = 261
      Top = 34
      Width = 23
      Height = 22
      Caption = '...'
      Flat = True
      OnClick = SBChooserMeterClick
    end
    object Label2: TLabel
      Left = 175
      Top = 90
      Width = 20
      Height = 13
      Caption = #1095#1072#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ChDate: TDateTimePicker
      Left = 31
      Top = 87
      Width = 137
      Height = 21
      Date = 40289.499105358790000000
      Time = 40289.499105358790000000
      TabOrder = 1
    end
    object RbTime: TRadioButton
      Left = 9
      Top = 64
      Width = 128
      Height = 17
      Caption = #1063#1072#1089#1086#1074#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = True
      OnClick = RbTimeClick
    end
    object RbDay: TRadioButton
      Left = 9
      Top = 117
      Width = 134
      Height = 17
      Caption = #1057#1091#1090#1086#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      TabStop = True
      OnClick = RbDayClick
    end
    object RbMonth: TRadioButton
      Left = 9
      Top = 167
      Width = 134
      Height = 17
      Caption = #1052#1077#1089#1103#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      TabStop = True
      OnClick = RbMonthClick
    end
    object ChTime: TDateTimePicker
      Left = 200
      Top = 87
      Width = 55
      Height = 21
      Date = 40289.499105358790000000
      Format = 'HH'
      Time = 40289.499105358790000000
      Kind = dtkTime
      TabOrder = 2
    end
    object ChDay: TDateTimePicker
      Left = 31
      Top = 140
      Width = 137
      Height = 21
      Date = 40289.499105358790000000
      Time = 40289.499105358790000000
      TabOrder = 3
    end
    object ChMonth: TComboBox
      Left = 32
      Top = 188
      Width = 136
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = #1071#1085#1074#1072#1088#1100
      Items.Strings = (
        #1071#1085#1074#1072#1088#1100
        #1060#1077#1074#1088#1072#1083#1100
        #1052#1072#1088#1090
        #1040#1087#1088#1077#1083#1100
        #1052#1072#1081
        #1048#1102#1085#1100
        #1048#1102#1083#1100
        #1040#1074#1075#1091#1089#1090
        #1057#1077#1085#1090#1103#1073#1088#1100
        #1054#1082#1090#1103#1073#1088#1100
        #1053#1086#1103#1073#1088#1100
        #1044#1077#1082#1072#1073#1088#1100)
    end
    object EditMeter: TEdit
      Left = 31
      Top = 35
      Width = 224
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object BitBtn7: TBitBtn
    Left = 11
    Top = 278
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1055#1086#1084#1086#1097#1100
    Enabled = False
    TabOrder = 2
    Kind = bkHelp
  end
  object Panel1: TPanel
    Left = 8
    Top = 231
    Width = 289
    Height = 41
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object BtnShowLog: TBitBtn
      Left = 16
      Top = 8
      Width = 257
      Height = 25
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1083#1086#1075
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1083#1086#1075
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnShowLogClick
    end
  end
  object dtbMeters: TZReadOnlyQuery
    Connection = DM.MySQLConnection
    SQL.Strings = (
      'SELECT meter_id, name, description'
      'FROM meters'
      'WHERE codegroup = :codegroup AND enabled > 0')
    Params = <
      item
        DataType = ftUnknown
        Name = 'codegroup'
        ParamType = ptUnknown
      end>
    Left = 48
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codegroup'
        ParamType = ptUnknown
      end>
    object dtbMetersmeter_id: TLargeintField
      FieldName = 'meter_id'
      Required = True
      Visible = False
    end
    object dtbMetersname: TStringField
      DisplayLabel = #1055#1088#1080#1073#1086#1088
      FieldName = 'name'
      Size = 120
    end
    object dtbMetersdescription: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'description'
      Size = 120
    end
  end
  object dtsMeters: TDataSource
    DataSet = dtbMeters
    Left = 80
    Top = 40
  end
end
