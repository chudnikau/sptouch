object ModDiagrams: TModDiagrams
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderWidth = 5
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1076#1080#1072#1075#1088#1072#1084#1084
  ClientHeight = 408
  ClientWidth = 626
  Color = clBtnFace
  Constraints.MinHeight = 388
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MdSplitter1: TMdSplitter
    Left = 310
    Top = 0
    Height = 367
    ExplicitLeft = 328
    ExplicitTop = 144
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 310
    Height = 367
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 0
    object Panel6: TPanel
      Left = 1
      Top = 326
      Width = 308
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object BtnAddDiagram: TSpeedButton
        Left = 3
        Top = 8
        Width = 25
        Height = 25
        Action = ActionAddDiagram
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          E6000000424DE60000000000000076000000280000000E0000000E0000000100
          0400000000007000000000000000000000001000000000000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3300333333333333330033333333333333003333300033333300333330F03333
          3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
          3300333330F033333300333330F0333333003333300033333300333333333333
          33003333333333333300}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object BtnDelDiagram: TSpeedButton
        Left = 33
        Top = 8
        Width = 25
        Height = 25
        Action = ActionDelDiagram
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          E6000000424DE60000000000000076000000280000000E0000000E0000000100
          0400000000007000000000000000000000001000000000000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3300333333333333330033333333333333003333333333333300333333333333
          330033333333333333003300000000003300330FFFFFFFF03300330000000000
          3300333333333333330033333333333333003333333333333300333333333333
          33003333333333333300}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object LabelCountDiagram: TLabel
        Left = 144
        Top = 13
        Width = 154
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'LabelCountDiagram'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BtnModDiagram: TSpeedButton
        Left = 64
        Top = 8
        Width = 25
        Height = 25
        Action = ActionModDiagram
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000000000
          0000000000000000000000000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF00000000000000
          0000000000000000FFFFFF000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF00000000000000
          0000000000000000FFFFFF000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF000000FFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          000000000000FFFFFFFFFFFFFFFFFF000000C0C0C0000000FFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFF000000C0C0C0000000FFFFFF000000C0
          C0C0000000C0C0C0000000000000000000FF00FF800000800000000000FFFFFF
          FFFFFF000000C0C0C0000000C0C0C0000000C0C0C0000000C0C0C0C0C0C0C0C0
          C0000000800000800000000000000000000000000000000000C0C0C0000000C0
          C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0800000800000FF00FFFF00FF
          FF00FFFF00FFFF00FF000000C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000800000800000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF0000000000000000000000000000000000
          00FF00FF800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
    end
    object cxGrid2: TcxGrid
      Left = 1
      Top = 1
      Width = 308
      Height = 325
      Align = alClient
      TabOrder = 1
      object cxGrid2DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dtsDiagrams
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        object cxGrid2DBTableView1diagram_id: TcxGridDBColumn
          DataBinding.FieldName = 'diagram_id'
          Visible = False
        end
        object cxGrid2DBTableView1name: TcxGridDBColumn
          DataBinding.FieldName = 'name'
        end
        object cxGrid2DBTableView1lvalue: TcxGridDBColumn
          DataBinding.FieldName = 'lvalue'
          Visible = False
        end
        object cxGrid2DBTableView1hvalue: TcxGridDBColumn
          DataBinding.FieldName = 'hvalue'
          Visible = False
        end
        object cxGrid2DBTableView1consumerism_id: TcxGridDBColumn
          DataBinding.FieldName = 'consumerism_id'
          Visible = False
        end
        object cxGrid2DBTableView1dimensionname: TcxGridDBColumn
          DataBinding.FieldName = 'dimensionname'
          Visible = False
        end
        object cxGrid2DBTableView1anglelable: TcxGridDBColumn
          DataBinding.FieldName = 'anglelable'
          Visible = False
        end
      end
      object cxGrid2Level1: TcxGridLevel
        GridView = cxGrid2DBTableView1
      end
    end
  end
  object Panel3: TPanel
    Left = 313
    Top = 0
    Width = 313
    Height = 367
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 1
    object Panel7: TPanel
      Left = 1
      Top = 326
      Width = 311
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        311
        40)
      object BtnAddParamDiagram: TSpeedButton
        Left = 4
        Top = 9
        Width = 25
        Height = 25
        Action = ActionAddParam
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          E6000000424DE60000000000000076000000280000000E0000000E0000000100
          0400000000007000000000000000000000001000000000000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3300333333333333330033333333333333003333300033333300333330F03333
          3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
          3300333330F033333300333330F0333333003333300033333300333333333333
          33003333333333333300}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object BtnDelParamDiagram: TSpeedButton
        Left = 33
        Top = 9
        Width = 25
        Height = 25
        Action = ActionDelParam
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          E6000000424DE60000000000000076000000280000000E0000000E0000000100
          0400000000007000000000000000000000001000000000000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3300333333333333330033333333333333003333333333333300333333333333
          330033333333333333003300000000003300330FFFFFFFF03300330000000000
          3300333333333333330033333333333333003333333333333300333333333333
          33003333333333333300}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object LabelCountParams: TLabel
        Left = 151
        Top = 13
        Width = 154
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'LabelCountParams'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 146
      end
      object BtnModParamDiagram: TSpeedButton
        Left = 63
        Top = 10
        Width = 25
        Height = 25
        Action = ActionModParam
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000000000
          0000000000000000000000000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF00000000000000
          0000000000000000FFFFFF000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF00000000000000
          0000000000000000FFFFFF000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF000000FFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FF000000FFFFFF
          000000000000FFFFFFFFFFFFFFFFFF000000C0C0C0000000FFFFFF000000FF00
          FFFF00FFFF00FFFF00FF000000FFFFFF000000C0C0C0000000FFFFFF000000C0
          C0C0000000C0C0C0000000000000000000FF00FF800000800000000000FFFFFF
          FFFFFF000000C0C0C0000000C0C0C0000000C0C0C0000000C0C0C0C0C0C0C0C0
          C0000000800000800000000000000000000000000000000000C0C0C0000000C0
          C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0800000800000FF00FFFF00FF
          FF00FFFF00FFFF00FF000000C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000800000800000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF0000000000000000000000000000000000
          00FF00FF800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
    end
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 311
      Height = 325
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dtsParams
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        object cxGrid1DBTableView1caption: TcxGridDBColumn
          DataBinding.FieldName = 'caption'
          Width = 131
        end
        object cxGrid1DBTableView1pq_name: TcxGridDBColumn
          DataBinding.FieldName = 'pq_name'
          Width = 117
        end
        object cxGrid1DBTableView1m_name: TcxGridDBColumn
          DataBinding.FieldName = 'm_name'
          Visible = False
        end
        object cxGrid1DBTableView1diagram_id: TcxGridDBColumn
          DataBinding.FieldName = 'diagram_id'
          Visible = False
        end
        object cxGrid1DBTableView1order: TcxGridDBColumn
          DataBinding.FieldName = 'order'
          Visible = False
        end
        object cxGrid1DBTableView1color: TcxGridDBColumn
          DataBinding.FieldName = 'color'
          Visible = False
        end
        object cxGrid1DBTableView1wvalue: TcxGridDBColumn
          DataBinding.FieldName = 'wvalue'
          Visible = False
        end
        object cxGrid1DBTableView1avalue: TcxGridDBColumn
          DataBinding.FieldName = 'avalue'
          Visible = False
        end
        object cxGrid1DBTableView1paramquery_id: TcxGridDBColumn
          DataBinding.FieldName = 'paramquery_id'
          Visible = False
        end
        object cxGrid1DBTableView1spparam: TcxGridDBColumn
          DataBinding.FieldName = 'spparam'
          Visible = False
        end
        object cxGrid1DBTableView1canal: TcxGridDBColumn
          DataBinding.FieldName = 'canal'
          Visible = False
        end
        object cxGrid1DBTableView1description: TcxGridDBColumn
          DataBinding.FieldName = 'description'
          Visible = False
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 367
    Width = 626
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 626
      Height = 7
      Align = alTop
      Shape = bsTopLine
      ExplicitLeft = 88
      ExplicitWidth = 1141
    end
    object HelpPic1: THelpPic
      Left = 5
      Top = 12
      Width = 24
      Height = 24
      AutoSize = True
      ParentShowHint = False
      Picture.Data = {
        07544269746D617076060000424D760600000000000036040000280000001800
        0000180000000100080000000000400200000000000000000000000100000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
        E00000400000004020000040400000406000004080000040A0000040C0000040
        E00000600000006020000060400000606000006080000060A0000060C0000060
        E00000800000008020000080400000806000008080000080A0000080C0000080
        E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
        E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
        E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
        E00040000000400020004000400040006000400080004000A0004000C0004000
        E00040200000402020004020400040206000402080004020A0004020C0004020
        E00040400000404020004040400040406000404080004040A0004040C0004040
        E00040600000406020004060400040606000406080004060A0004060C0004060
        E00040800000408020004080400040806000408080004080A0004080C0004080
        E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
        E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
        E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
        E00080000000800020008000400080006000800080008000A0008000C0008000
        E00080200000802020008020400080206000802080008020A0008020C0008020
        E00080400000804020008040400080406000804080008040A0008040C0008040
        E00080600000806020008060400080606000806080008060A0008060C0008060
        E00080800000808020008080400080806000808080008080A0008080C0008080
        E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
        E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
        E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
        E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
        E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
        E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
        E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
        E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
        E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
        E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
        A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF000000000000000000A4A4A4A4A4A4A4000000000000000000000000000000
        A4A407FFFFFFFF0707A4A40000000000000000000000A4A407FFFFFFFFFFFFFF
        FFFF07A4A40000000000000000A407FFFFFF070404040404FFFFFFFF07A40000
        00000000A407FFFFFF0404FCA4A4A4FC0404FFFFFF07A40000000000A4FFFF07
        04FC04A4FFFFFFA404FC04FFFFFFA400000000A407FF0704FC04FCA4FFFFFFA4
        FC04FC04FFFF07A4000000A4FFFF04FC04FC04FC070707FC04FC04FC04FFFFA4
        0000A407FF070404FCFCFCFCFCFCFCFCFC04FC040407FF07A400A4FFFF04FCFC
        FC04FC0407FF07FC04FCFCFCFC04FFFFA400A4FFFF04FC04FC04FCFC07FF07FC
        FCFC04FC0404FFFFA400A4FFFF04FCFC04FCFCFC07FFFFA4FCFCFC04FC04FFFF
        A400A4FFFF04FCFCFCFCFCFCFC07FFFFA4FCFCFCFC04FFFFA400A4FFFF04FCFC
        FCFCFCFCFCFC07FFFFA4FCFCFC04FFFFA400A407FF0704FCFCFCFCFCFCFCA4FF
        FF07FCFC0407FF07A40000A4FF0704FCFCA407A4FCFCFC07FF07FCFC0407FFA4
        000000A407FF0704FCA4FFFFA4FC07FFFF07FC04A4FF07A400000000A4FFFF07
        04A4FFFFFFFFFFFFFFA404A4FFFFA40000000000A407FFFF070404FFFFFFFFFF
        04040707FF07A4000000000000A407FFFFFF0704040404040707FFFF07A40000
        000000000000A4A407FFFFFFFFFFFFFFFFFF07A4A40000000000000000000000
        A4A407FFFFFFFFFF07A4A4000000000000000000000000000000A4A4A4A4A4A4
        A400000000000000000000000000000000000000000000000000000000000000
        0000}
      ShowHint = True
      Transparent = True
    end
    object MdBitBtn1: TMdBitBtn
      Left = 461
      Top = 11
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000001E8F1B91188E1491000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000065B566FF05E203FF04EA02FF52B854FF0000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000008BB78BFA00CA00FA00F904FA00F905FA00CB00FA96C4
        97FA000000000000000000000000000000000000000000000000000000000000
        000000000000E1E1E3FF16971BFF11CF16FF03C30BFF04C40DFF03CA07FF269A
        28FF000000000000000000000000000000000000000000000000000000000000
        0000000000005DA35FFF28B331FF30B738FF23B82CFF18B020FF15AE1EFF089A
        0CFF8EBC8EFF0000000000000000000000000000000000000000000000000000
        000089AE8AFF399D3FFF5DBE65FF4CBA54FF209024FF2BA432FF37AC3FFF21A9
        2AFF118214FFC9D5C7FF0000000000000000000000000000000000000000B5C8
        B3FF59915AFFA1D0A7FF86BD90FF4A8F4FFF8DAA8EFF3E8443FF50A259FF59A4
        61FF389640FF3F8143FFF0F3EFFF00000000000000000000000098B39CFF91B2
        96FFE3EEE8FFB5CBB9FF538654FFABC2AEFF00000000C2D1C2FF3E7641FF79A9
        82FF80AB89FF43824BFF648B62FF0000000000000000000000006F946BFFCBD8
        C8FF8EAD91FF5E8960FFD3DCD0FF000000000000000000000000B5C4B2FF4C7C
        4FFFA0BCA8FFAFC8B6FF638F6AFF7E9C7AFF00000000000000009EB399FF97AE
        93FF8CA78AFFDFE8E0FF0000000000000000000000000000000000000000C6D2
        C4FF82A685FF99B299FFFDFEFDFF7EA281FF8FAC8FFF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000E2EBE3FF658F6AFF779B7CFFD7E0D8FF92AF91FF9FBDA0FF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000B7CAB5FF8BA888FF98B298FF15561BFF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000F8FEF7FF2F642EFF578358FF}
    end
    object MdBitBtn2: TMdBitBtn
      Left = 542
      Top = 11
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000047476C2529296425000000000000000000000000000000000000
        0000000000002929642547476C25000000000000000000000000000000000000
        00006969838F1313BEFF0A0AD3FF57578EB80000000000000000000000000000
        000057578EB80A0AD3FF1313BEFF6969828F0000000000000000000000004343
        8B8F1010BFFF0000FFF90000FFFA0808D5FF666689AE00000000000000006666
        89AE0808D5FF0000FFFA0000FFF91010C0FF4444898C00000000535393FF1515
        C3FF0000FEFC0101FDFF0101FBFF0000FFF90505D8FF565690B2565690B20505
        D8FF0000FFF90101FBFF0101FEFF0000FFFC1414C2FF7C7C85AF40408DFF0505
        D4FD0202FFFC0101F7FE0000FAFE0101F9FF0000FFFC0505D6FF0505D6FF0000
        FFFC0000F9FF0000FAFE0101F4FF0202FFFB0505D6FF686883DCA4A4E1BE5252
        A7FB0202C8FF0000EEFC0202E8FF0202EAFE0303E8FF0202F1FB0202F1FB0303
        E8FF0101EAFE0303E7FF0000EFF90808CCFF4B4B90B100000000000000000000
        00005A5A8BB20707C0FF0000E0FC0101D7FF0000D9FF0000D6FF0000D6FF0000
        D9FF0101D7FF0000E0FC0606C1FF5C5C8CB20000000000000000000000000000
        000000000000575790AE0D0DB1FE0000CAFB0101C5FF0000C5FF0000C5FF0101
        C5FF0000CAFB0D0DB1FE575790AE000000000000000000000000000000000000
        000000000000565690AE0B0BA1FE0000B8FB0000B2FF0000B4FF0000B4FF0000
        B2FF0000B8FB0B0BA1FE555590AE000000000000000000000000000000000000
        00005D5D90B212129AFF0B0BABFC0D0DA5FF0E0EA7FF0D0DA6FF0D0DA6FF0E0E
        A7FF0D0DA5FF0B0BABFC12129AFF5D5D8FB200000000000000008383B4614343
        8FB41C1C95FF2222AAF92323A3FF2323A5FE2222A5FF2424A6FB2424A6FB2222
        A5FF2323A5FE2323A3FF2121AAF91F1F97FF4B4B8AB1000000005A5A9EFF4848
        A8FF4B4BB1FC4D4DAFFF4D4DB1FE4A4AAFFF5353B7FC3C3C9FFF3C3C9FFF5353
        B7FC4A4AAFFF4D4DB1FE4B4BAFFF4E4EB3FB4E4EA5FF43437ADC535388FF5D5D
        A1FF8D8DCDFF8080C2FF7D7DC1FF8B8BCCF96B6BB0FF5F5F90B25F5F90B26B6B
        B0FF8B8BCCF97D7DC1FF8080C2FF8D8DCCFF5A5AA2FF4D4D80AF000000004F4F
        908F6B6BA6FABEBEE5FBC2C2E6FC8F8FC1FF58588CAE00000000000000005858
        8CAE8F8FC1FFC2C2E6FCBEBEE5FB6C6CA7F94F4F908C00000000000000000000
        00008888ACDB9D9DC0FEBEBED8FE5F5F8FB50000000000000000000000000000
        00005F5F8FB5BEBED8FE9D9DC0FE8888ACDB0000000000000000000000000000
        0000000000006B6B98FF696998FF000000000000000000000000000000000000
        000000000000696998FF6B6B98FF000000000000000000000000}
    end
  end
  object dtbParams: TZReadOnlyQuery
    Connection = DM.MySQLConnection
    AfterOpen = dtbParamsAfterOpen
    AfterRefresh = dtbParamsAfterRefresh
    SQL.Strings = (
      'SELECT'
      '   pd.diagram_id,'
      '   pd.order,'
      '   pd.caption,'
      '   pd.color,'
      '   pd.wvalue,'
      '   pd.avalue,'
      '   pq.paramquery_id,'
      '   pq.name as pq_name,'
      '   m.name as m_name,'
      '   p.spparam,'
      '   p.canal,'
      '   p.description'
      'FROM paramsdiagrams pd'
      
        'INNER JOIN paramsqueries pq ON pq.paramquery_id = pd.paramquery_' +
        'id'
      'INNER JOIN meters m ON m.meter_id = pq.meter_id'
      'INNER JOIN params p ON p.param_id = pq.param_id'
      'WHERE pd.diagram_id = :diagram_id ORDER BY pd.order')
    Params = <
      item
        DataType = ftUnknown
        Name = 'diagram_id'
        ParamType = ptUnknown
      end>
    DataSource = dtsDiagrams
    Left = 128
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'diagram_id'
        ParamType = ptUnknown
      end>
    object dtbParamscaption: TStringField
      DisplayLabel = #1048#1084#1103
      FieldName = 'caption'
      Size = 45
    end
    object dtbParamspq_name: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'pq_name'
      Size = 255
    end
    object dtbParamsm_name: TStringField
      FieldName = 'm_name'
      Visible = False
      Size = 120
    end
    object dtbParamsdiagram_id: TLargeintField
      FieldName = 'diagram_id'
      Required = True
      Visible = False
    end
    object dtbParamsorder: TLargeintField
      FieldName = 'order'
      Visible = False
    end
    object dtbParamscolor: TLargeintField
      FieldName = 'color'
      Visible = False
    end
    object dtbParamswvalue: TFloatField
      FieldName = 'wvalue'
      Visible = False
    end
    object dtbParamsavalue: TFloatField
      FieldName = 'avalue'
      Visible = False
    end
    object dtbParamsparamquery_id: TLargeintField
      FieldName = 'paramquery_id'
      Required = True
      Visible = False
    end
    object dtbParamsspparam: TLargeintField
      DisplayLabel = #1060#1080#1079'. '#1085#1086#1084'. '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      FieldName = 'spparam'
      Visible = False
    end
    object dtbParamscanal: TLargeintField
      DisplayLabel = #1058#1088#1091#1073#1086#1087#1088#1086#1074#1086#1076
      FieldName = 'canal'
      Visible = False
    end
    object dtbParamsdescription: TStringField
      DisplayLabel = #1041#1072#1079#1086#1074#1086#1077' '#1086#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'description'
      Visible = False
      Size = 120
    end
  end
  object dtbDiagrams: TZReadOnlyQuery
    Connection = DM.MySQLConnection
    AfterOpen = dtbDiagramsAfterOpen
    AfterRefresh = dtbDiagramsAfterRefresh
    SQL.Strings = (
      'SELECT * FROM diagrams'
      
        'where consumerism_id = :consumerism_id ORDER BY diagrams.diagram' +
        '_id')
    Params = <
      item
        DataType = ftUnknown
        Name = 'consumerism_id'
        ParamType = ptUnknown
      end>
    Left = 96
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'consumerism_id'
        ParamType = ptUnknown
      end>
    object dtbDiagramsdiagram_id: TLargeintField
      FieldName = 'diagram_id'
      Required = True
      Visible = False
    end
    object dtbDiagramsname: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1080#1072#1075#1088#1072#1084#1084#1099
      FieldName = 'name'
      Size = 45
    end
    object dtbDiagramslvalue: TFloatField
      DisplayLabel = #1053#1080#1078#1085#1077#1077' '#1079#1085#1072#1095'.'
      FieldName = 'lvalue'
      Visible = False
    end
    object dtbDiagramshvalue: TFloatField
      DisplayLabel = #1042#1077#1088#1093'. '#1079#1085#1072#1095'.'
      FieldName = 'hvalue'
      Visible = False
    end
    object dtbDiagramsconsumerism_id: TLargeintField
      FieldName = 'consumerism_id'
      Required = True
      Visible = False
    end
    object dtbDiagramsdimensionname: TStringField
      DisplayLabel = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      FieldName = 'dimensionname'
      Visible = False
      Size = 45
    end
    object dtbDiagramsanglelable: TIntegerField
      FieldName = 'anglelable'
      Visible = False
    end
  end
  object dtsDiagrams: TDataSource
    DataSet = dtbDiagrams
    Left = 256
    Top = 136
  end
  object dtsParams: TDataSource
    DataSet = dtbParams
    Left = 224
    Top = 136
  end
  object ActionList: TActionList
    Left = 160
    Top = 136
    object ActionAddDiagram: TAction
      OnExecute = ActionAddDiagramExecute
    end
    object ActionDelDiagram: TAction
      OnExecute = ActionDelDiagramExecute
      OnUpdate = ActionDelDiagramUpdate
    end
    object ActionModDiagram: TAction
      OnExecute = ActionModDiagramExecute
      OnUpdate = ActionModDiagramUpdate
    end
    object ActionAddParam: TAction
      OnExecute = ActionAddParamExecute
      OnUpdate = ActionAddParamUpdate
    end
    object ActionDelParam: TAction
      OnExecute = ActionDelParamExecute
      OnUpdate = ActionDelParamUpdate
    end
    object ActionModParam: TAction
      OnExecute = ActionModParamExecute
      OnUpdate = ActionModParamUpdate
    end
  end
  object tdbAllParams: TZReadOnlyQuery
    Connection = DM.MySQLConnection
    SQL.Strings = (
      'SELECT'
      '   paramsqueries.paramquery_id,'
      '   paramsqueries.name paramsqueries_name,'
      '   meters.name meter_name,'
      '   params.spparam,'
      '   params.canal,'
      '   params.description'
      'FROM paramsqueries'
      'INNER JOIN meters ON meters.meter_id = paramsqueries.meter_id'
      'INNER JOIN params ON params.param_id = paramsqueries.param_id'
      'WHERE'
      'paramsqueries.paramquery_id'
      '    NOT IN (SELECT paramquery_id FROM paramsdiagrams'
      '          WHERE paramsdiagrams.diagram_id = :diagram_id)'
      'AND paramsqueries.enabled > 0 AND paramsqueries.array_id IS NULL')
    Params = <
      item
        DataType = ftUnknown
        Name = 'diagram_id'
        ParamType = ptUnknown
      end>
    DataSource = dtsDiagrams
    Left = 192
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'diagram_id'
        ParamType = ptUnknown
      end>
    object tdbAllParamsparamquery_id: TLargeintField
      FieldName = 'paramquery_id'
      Required = True
      Visible = False
    end
    object tdbAllParamsparamsqueries_name: TStringField
      DisplayLabel = #1053#1072#1079#1074'. '#1087#1072#1088#1072#1084#1077#1088#1072
      DisplayWidth = 30
      FieldName = 'paramsqueries_name'
      Size = 255
    end
    object tdbAllParamsDeviceName: TStringField
      DisplayLabel = #1055#1088#1080#1073#1086#1088
      DisplayWidth = 30
      FieldName = 'meter_name'
      Visible = False
      Size = 120
    end
    object tdbAllParamsspparam: TLargeintField
      DisplayLabel = #1060#1080#1079'. '#1085#1086#1084'. '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      FieldName = 'spparam'
      Visible = False
    end
    object tdbAllParamscanal: TLargeintField
      DisplayLabel = #1058#1088#1091#1073#1086#1087#1088#1086#1074#1086#1076
      FieldName = 'canal'
      Visible = False
    end
    object tdbAllParamsdescription: TStringField
      DisplayLabel = #1041#1072#1079#1086#1074#1086#1077' '#1086#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'description'
      Visible = False
      Size = 120
    end
  end
end
