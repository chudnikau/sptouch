object RunSQL: TRunSQL
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' SQL'
  ClientHeight = 277
  ClientWidth = 415
  Color = clBtnFace
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
    Top = 236
    Width = 415
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 286
    ExplicitWidth = 498
    DesignSize = (
      415
      41)
    object BitBtn7: TBitBtn
      Left = 7
      Top = 9
      Width = 75
      Height = 25
      Caption = '&'#1055#1086#1084#1086#1097#1100
      Enabled = False
      TabOrder = 0
      Kind = bkHelp
    end
    object BtnCancel: TBitBtn
      Left = 331
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
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
      ExplicitLeft = 426
    end
  end
  object MemoSqlScript: TSynMemo
    Left = 0
    Top = 23
    Width = 415
    Height = 213
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 5
    Gutter.BorderStyle = gbsNone
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.LeftOffset = 0
    Gutter.ShowLineNumbers = True
    Gutter.Gradient = True
    Highlighter = SynSQLSyn
    Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    RightEdge = 40
    ExplicitWidth = 909
    ExplicitHeight = 450
  end
  object SynSQLSyn: TSynSQLSyn
    Left = 104
    Top = 64
  end
  object OpenDialog: TOpenDialog
    Filter = '*.sql|*.sql'
    Left = 136
    Top = 64
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Bars = <
      item
        AllowQuickCustomizing = False
        Caption = 'Main Menu'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 0
        FloatTop = 0
        FloatClientWidth = 0
        FloatClientHeight = 0
        IsMainMenu = True
        ItemLinks = <
          item
            Item = N1
            Visible = True
          end
          item
            Item = N4
            Visible = True
          end>
        MultiLine = True
        Name = 'Main Menu'
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end>
    Categories.Strings = (
      'Default'
      #1060#1072#1081#1083
      #1044#1077#1081#1089#1090#1074#1080#1103
      'Menus')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseSystemFont = True
    Left = 168
    Top = 64
    DockControlHeights = (
      0
      0
      23
      0)
    object N1: TdxBarSubItem
      Caption = '&'#1060#1072#1081#1083
      Category = 3
      Visible = ivAlways
      ItemLinks = <
        item
          Item = N2
          Visible = True
        end
        item
          Item = N3
          Visible = True
        end>
    end
    object N2: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100
      Category = 1
      Visible = ivAlways
      OnClick = N2Click
    end
    object N3: TdxBarButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      Category = 1
      Visible = ivAlways
      OnClick = N3Click
    end
    object N4: TdxBarSubItem
      Caption = '&'#1044#1077#1081#1089#1090#1074#1080#1103
      Category = 3
      Visible = ivAlways
      ItemLinks = <
        item
          Item = N5
          Visible = True
        end
        item
          Item = N6
          Visible = True
        end>
    end
    object N5: TdxBarButton
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      Category = 2
      Visible = ivAlways
      OnClick = N5Click
    end
    object N6: TdxBarButton
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Category = 2
      Visible = ivAlways
      OnClick = N6Click
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.sql'
    Filter = '*.sql|*.sql'
    Left = 104
    Top = 112
  end
end
