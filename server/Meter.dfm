object FMeter: TFMeter
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1087#1088#1080#1073#1086#1088#1072
  ClientHeight = 637
  ClientWidth = 654
  Color = clBtnFace
  Constraints.MinHeight = 565
  Constraints.MinWidth = 662
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    654
    637)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 640
    Height = 161
    Anchors = [akLeft, akTop, akRight]
    Caption = '['#1055#1088#1080#1073#1086#1088']'
    TabOrder = 0
    DesignSize = (
      640
      161)
    object Label4: TLabel
      Left = 11
      Top = 44
      Width = 23
      Height = 13
      Caption = #1048#1084#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 20
      Width = 37
      Height = 13
      Caption = #1053#1086#1084#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 67
      Width = 20
      Height = 13
      Caption = #1058#1080#1087
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 10
      Top = 90
      Width = 54
      Height = 13
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelTest: TLabel
      Left = 468
      Top = 19
      Width = 83
      Height = 19
      Anchors = [akTop, akRight]
      Caption = #1058#1045#1057#1058#1048#1056#1059#1070
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object bsSkinDBEdit1: TbsSkinDBEdit
      Left = 74
      Top = 17
      Width = 250
      Height = 18
      Text = 'bsSkinDBEdit1'
      DefaultColor = 14737632
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clBlack
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      ButtonMode = False
      SkinDataName = 'edit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      AutoSize = False
      Color = 14737632
      DataField = 'device'
      DataSource = dtsMeters
    end
    object bsSkinDBEdit2: TbsSkinDBEdit
      Left = 74
      Top = 41
      Width = 250
      Height = 18
      Text = 'bsSkinDBEdit2'
      DefaultColor = clWindow
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clBlack
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      ButtonMode = False
      SkinDataName = 'edit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      AutoSize = False
      DataField = 'name'
      DataSource = dtsMeters
    end
    object DBMeterType: TbsSkinDBLookupComboBox
      Left = 74
      Top = 65
      Width = 250
      Height = 20
      TabOrder = 2
      SkinDataName = 'combobox'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 20
      UseSkinFont = True
      DataField = 'typemeter_id'
      DataSource = dtsMeters
      DefaultColor = clWindow
      ListBoxDefaultItemHeight = 20
      ListBoxUseSkinFont = True
      ListBoxUseSkinItemHeight = True
      KeyField = 'typemeter_id'
      ListField = 'name'
      ListSource = dtsTypesMeters
      OnCloseUp = DBMeterTypeCloseUp
    end
    object bsSkinDBMemo1: TbsSkinDBMemo
      Left = 74
      Top = 91
      Width = 558
      Height = 62
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'bsSkinDBMemo1')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 3
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clBlack
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      BitMapBG = True
      SkinDataName = 'memo'
      DataField = 'description'
      DataSource = dtsMeters
    end
    object BtnTestInfo: TBitBtn
      Left = 556
      Top = 15
      Width = 75
      Height = 25
      Action = ActionTest
      Anchors = [akTop, akRight]
      Caption = #1058#1077#1089#1090
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 175
    Width = 638
    Height = 421
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = '['#1055#1072#1088#1072#1084#1077#1090#1088#1099']'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 2
      Top = 210
      Width = 634
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Color = 13033443
      ParentColor = False
      ExplicitTop = 257
      ExplicitWidth = 759
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 634
      Height = 195
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 6
      Constraints.MinHeight = 80
      ParentColor = True
      TabOrder = 0
      object dxDBGrid2: TdxDBGrid
        Left = 6
        Top = 35
        Width = 622
        Height = 127
        Bands = <
          item
            DisableCustomizing = True
            DisableDragging = True
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        DataSource = dtsParams
        Filter.Criteria = {00000000}
        HideFocusRect = True
        HideSelectionColor = 13033187
        HideSelectionTextColor = clNone
        HighlightColor = 13033187
        HighlightTextColor = clNone
        LookAndFeel = lfUltraFlat
        OptionsBehavior = [edgoAutoSort, edgoDblClick, edgoTabThrough, edgoVertThrough]
        OptionsCustomize = [edgoColumnSizing]
        OptionsDB = [edgoCanNavigation, edgoUseBookmarks]
        OptionsView = [edgoAutoWidth, edgoHideFocusRect, edgoIndicator, edgoRowSelect, edgoUseBitmap]
        object dxDBGrid2param_id: TdxDBGridColumn
          Visible = False
          Width = 95
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_id'
        end
        object dxDBGrid2spparam: TdxDBGridColumn
          Width = 68
          BandIndex = 0
          RowIndex = 0
          FieldName = 'spparam'
        end
        object dxDBGrid2canal: TdxDBGridColumn
          Width = 80
          BandIndex = 0
          RowIndex = 0
          FieldName = 'canal'
        end
        object dxDBGrid2description: TdxDBGridMaskColumn
          Width = 447
          BandIndex = 0
          RowIndex = 0
          FieldName = 'description'
        end
        object dxDBGrid2unitSN: TdxDBGridMaskColumn
          Visible = False
          Width = 138
          BandIndex = 0
          RowIndex = 0
          FieldName = 'unitSN'
        end
      end
      object Panel3: TPanel
        Left = 6
        Top = 6
        Width = 622
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 5
          Top = 2
          Width = 40
          Height = 13
          Caption = #1057#1087#1080#1089#1086#1082
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 289
          Top = 2
          Width = 81
          Height = 13
          Caption = #8470' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditFilter: TbsSkinEdit
          Left = 376
          Top = 0
          Width = 185
          Height = 18
          DefaultColor = clWindow
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = False
          SkinDataName = 'edit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = EditFilterChange
        end
      end
      object DBListHeader: TbsSkinComboBox
        Left = 73
        Top = 5
        Width = 203
        Height = 20
        TabOrder = 2
        SkinDataName = 'combobox'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 14
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        UseSkinSize = True
        AlphaBlend = False
        AlphaBlendValue = 0
        AlphaBlendAnimation = False
        HideSelection = True
        AutoComplete = True
        ListBoxUseSkinFont = True
        ListBoxUseSkinItemHeight = True
        ListBoxWidth = 0
        ImageIndex = -1
        ListBoxCaptionMode = False
        ListBoxDefaultFont.Charset = DEFAULT_CHARSET
        ListBoxDefaultFont.Color = clWindowText
        ListBoxDefaultFont.Height = 14
        ListBoxDefaultFont.Name = 'Arial'
        ListBoxDefaultFont.Style = []
        ListBoxDefaultCaptionFont.Charset = DEFAULT_CHARSET
        ListBoxDefaultCaptionFont.Color = clWindowText
        ListBoxDefaultCaptionFont.Height = 14
        ListBoxDefaultCaptionFont.Name = 'Arial'
        ListBoxDefaultCaptionFont.Style = []
        ListBoxDefaultItemHeight = 20
        ListBoxCaptionAlignment = taLeftJustify
        CharCase = ecNormal
        DefaultColor = clWindow
        ItemIndex = -1
        DropDownCount = 8
        HorizontalExtent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        Sorted = False
        Style = bscbFixedStyle
        OnCloseUp = DBListHeaderCloseUp
      end
      object Panel6: TPanel
        Left = 6
        Top = 162
        Width = 622
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        object LabelCountListHeaders: TLabel
          Left = 3
          Top = 9
          Width = 130
          Height = 13
          Caption = 'LabelCountListHeaders'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 215
      Width = 634
      Height = 204
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 6
      Constraints.MinHeight = 80
      TabOrder = 1
      object DBGridChoosedParams: TdxDBGrid
        Left = 6
        Top = 39
        Width = 622
        Height = 132
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'paramquery_id'
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        TabOrder = 0
        DataSource = dtsParamsQueries
        Filter.Criteria = {00000000}
        HideFocusRect = True
        HideSelectionColor = 13033187
        HideSelectionTextColor = clNone
        HighlightColor = 13033187
        HighlightTextColor = clNone
        LookAndFeel = lfUltraFlat
        OptionsBehavior = [edgoAutoSort, edgoDblClick, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
        OptionsCustomize = [edgoColumnSizing]
        OptionsDB = [edgoCanNavigation, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoAutoWidth, edgoHideFocusRect, edgoIndicator, edgoInvertSelect, edgoShowButtonAlways, edgoUseBitmap]
        object DBGridChoosedParamsparamquery_id: TdxDBGridColumn
          Visible = False
          BandIndex = 0
          RowIndex = 0
          FieldName = 'paramquery_id'
        end
        object DBGridChoosedParamsparamquery_name: TdxDBGridButtonColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'paramquery_name'
          Buttons = <
            item
              Default = True
            end>
          OnButtonClick = DBGridChoosedParamsparamquery_nameButtonClick
        end
        object DBGridChoosedParamsspparam: TdxDBGridColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'spparam'
        end
        object DBGridChoosedParamscanal: TdxDBGridColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'canal'
        end
        object DBGridChoosedParamsdescription: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'description'
        end
        object DBGridChoosedParamsarray_name: TPdxDBGridComboColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'array_name'
          ImmediateDropDown = False
          OnCloseUp = DBGridChoosedParamsArray_nameCloseUp
        end
        object DBGridChoosedParamsunitSN: TPdxDBGridComboColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'unitSN'
          OnCloseUp = DBGridChoosedParamsunitSNCloseUp
        end
      end
      object Panel4: TPanel
        Left = 6
        Top = 6
        Width = 622
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object SpeedButton8: TSpeedButton
          Left = 3
          Top = 1
          Width = 26
          Height = 26
          Action = ActionAddParam
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            C6050000424DC605000000000000360400002800000014000000140000000100
            080000000000900100000000000000000000000100000000000000000000C0C0
            C000FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000010101010101
            0101010101010101010101010101010101010101010101010101010101010101
            0101010101010101010101000001010101010101010101010101010101010000
            0000010101010101010101010101010101000000000000010101010101010101
            0101010100000000000000000101010101010101010101000000000000000000
            0001010101010101010100000000000000000000000001010101010101000000
            0000000000000000000000010101010100000000000000000000000000000000
            0101010101010101010000000000000101010101010101010101010101000000
            0000000101010101010101010101010101000000000000010101010101010101
            0101010101000000000000010101010101010101010101010100000000000001
            0101010101010101010101010100000000000001010101010101010101010101
            0100000000000001010101010101010101010101010101010101010101010101
            0101010101010101010101010101010101010101010101010101010101010101
            01010101010101010101}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object SpeedButton7: TSpeedButton
          Left = 33
          Top = 1
          Width = 26
          Height = 26
          Action = ActionDeleteParam
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            C6050000424DC605000000000000360400002800000014000000140000000100
            080000000000900100000000000000000000000100000000000000000000C0C0
            C000FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000010101010101
            0101010101010101010101010101010101010101010101010101010101010101
            0101010101010101010101010101010101010101010101010101010101000000
            0000000101010101010101010101010101000000000000010101010101010101
            0101010101000000000000010101010101010101010101010100000000000001
            0101010101010101010101010100000000000001010101010101010101010101
            0100000000000001010101010101010101010101010000000000000101010101
            0101010100000000000000000000000000000000010101010100000000000000
            0000000000000001010101010101000000000000000000000000010101010101
            0101010000000000000000000001010101010101010101010000000000000000
            0101010101010101010101010100000000000001010101010101010101010101
            0101000000000101010101010101010101010101010101000001010101010101
            0101010101010101010101010101010101010101010101010101010101010101
            01010101010101010101}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object Label5: TLabel
          Left = 68
          Top = 5
          Width = 252
          Height = 16
          Caption = #1042#1099' '#1084#1086#1078#1077#1090#1077' '#1076#1086#1073#1072#1074#1083#1103#1090#1100'/'#1091#1076#1072#1083#1103#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel5: TPanel
        Left = 6
        Top = 171
        Width = 622
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object LabelCountListParamq: TLabel
          Left = 3
          Top = 9
          Width = 130
          Height = 13
          Caption = 'LabelCountListHeaders'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object CBActiveMeter: TDBCheckBox
    Left = 16
    Top = 608
    Width = 169
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1047#1072#1076#1077#1081#1089#1090#1074#1086#1074#1072#1090#1100' '#1087#1088#1080#1073#1086#1088
    DataField = 'enabled'
    DataSource = dtsMeters
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ValueChecked = '1'
    ValueUnchecked = '0'
  end
  object BtnOK: TBitBtn
    Left = 485
    Top = 604
    Width = 75
    Height = 25
    Action = ActionOk
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
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
  object BtnCancel: TBitBtn
    Left = 566
    Top = 604
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = BtnCancelClick
    Kind = bkCancel
  end
  object ActionList: TActionList
    Left = 455
    Top = 278
    object ActionOk: TAction
      Caption = 'OK'
      OnExecute = ActionOkExecute
      OnUpdate = ActionOkUpdate
    end
    object ActionAddParam: TAction
      OnExecute = ActionAddParamExecute
      OnUpdate = ActionAddParamUpdate
    end
    object ActionDeleteParam: TAction
      OnExecute = ActionDeleteParamExecute
      OnUpdate = ActionDeleteParamUpdate
    end
    object ActionTest: TAction
      Caption = #1058#1077#1089#1090
      Hint = #1058#1077#1089#1090
      OnExecute = ActionTestExecute
      OnUpdate = ActionTestUpdate
    end
  end
  object dtsTypesMeters: TDataSource
    DataSet = dtbTypesMeters
    Left = 359
    Top = 277
  end
  object dtbTypesMeters: TZReadOnlyQuery
    SQL.Strings = (
      'select * from typesmeters')
    Params = <>
    Properties.Strings = (
      'select name from typemeters where typemeter_id = :typemeter_id')
    DataSource = dtsMeters
    Left = 389
    Top = 318
    object dtbTypesMeterstypemeter_id: TLargeintField
      FieldName = 'typemeter_id'
      Required = True
    end
    object dtbTypesMetersname: TStringField
      FieldName = 'name'
      Size = 45
    end
  end
  object dtbMeters: TZQuery
    AfterEdit = dtbMetersAfterEdit
    SQL.Strings = (
      'SELECT meters.* FROM meters WHERE meter_id = :meter_id')
    Params = <
      item
        DataType = ftUnknown
        Name = 'meter_id'
        ParamType = ptUnknown
      end>
    Left = 293
    Top = 318
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'meter_id'
        ParamType = ptUnknown
      end>
    object dtbMetersmeter_id: TLargeintField
      FieldName = 'meter_id'
      Required = True
    end
    object dtbMetersenabled: TLargeintField
      FieldName = 'enabled'
    end
    object dtbMetersdescription: TStringField
      FieldName = 'description'
      Size = 120
    end
    object dtbMetersname: TStringField
      FieldName = 'name'
      Size = 120
    end
    object dtbMetersuser_id: TLargeintField
      FieldName = 'user_id'
      Required = True
    end
    object dtbMeterstypemeter_id: TLargeintField
      FieldName = 'typemeter_id'
      Required = True
    end
    object dtbMetersdevice: TLargeintField
      FieldName = 'device'
    end
  end
  object dtsMeters: TDataSource
    DataSet = dtbMeters
    Left = 295
    Top = 277
  end
  object dtbParamsQueries: TZQuery
    AfterRefresh = dtbParamsQueriesAfterRefresh
    SQL.Strings = (
      'SELECT'
      '  paramsqueries.paramquery_id,'
      '  paramsqueries.name paramquery_name,'
      '  params.spparam,'
      '  params.canal,'
      '  params.description,'
      '  arraies.name array_name,'
      '  unitsparams.unitSN'
      'FROM paramsqueries'
      'INNER JOIN params ON params.param_id = paramsqueries.param_id'
      
        'LEFT JOIN unitsparams ON unitsparams.unitparam_id = paramsquerie' +
        's.unitparam_id'
      'LEFT JOIN arraies ON arraies.array_id = paramsqueries.array_id'
      
        'WHERE paramsqueries.meter_id = :meter_id AND paramsqueries.enabl' +
        'ed = 1'
      'ORDER BY params.spparam, params.canal')
    Params = <
      item
        DataType = ftUnknown
        Name = 'meter_id'
        ParamType = ptUnknown
      end>
    DataSource = dtsMeters
    Left = 325
    Top = 318
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'meter_id'
        ParamType = ptUnknown
      end>
    object dtbParamsQueriesparamquery_id: TLargeintField
      FieldName = 'paramquery_id'
      Required = True
      Visible = False
    end
    object dtbParamsQueriesparamquery_name: TStringField
      DisplayLabel = #1053#1072#1079#1074'. '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      DisplayWidth = 45
      FieldName = 'paramquery_name'
      ReadOnly = True
      Required = True
      Size = 255
    end
    object dtbParamsQueriesspparam: TLargeintField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'spparam'
      ReadOnly = True
    end
    object dtbParamsQueriescanal: TLargeintField
      DisplayLabel = #1058#1088#1091#1073#1086#1087#1088#1086#1074#1086#1076
      FieldName = 'canal'
      ReadOnly = True
    end
    object dtbParamsQueriesdescription: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'description'
      ReadOnly = True
      Size = 120
    end
    object dtbParamsQueriesarray_name: TStringField
      DisplayLabel = #1058#1080#1087' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      FieldName = 'array_name'
      ReadOnly = True
      Size = 45
    end
    object dtbParamsQueriesunitSN: TStringField
      DisplayLabel = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      FieldName = 'unitSN'
      ReadOnly = True
      Size = 45
    end
  end
  object dtsParamsQueries: TDataSource
    DataSet = dtbParamsQueries
    Left = 327
    Top = 277
  end
  object dtbParams: TZReadOnlyQuery
    AfterRefresh = dtbParamsAfterRefresh
    Filtered = True
    SQL.Strings = (
      
        'SELECT p.param_id, p.spparam, p.canal, p.description, unitsparam' +
        's.unitSN FROM params p'
      
        'LEFT JOIN unitsparams ON unitsparams.unitparam_id = p.unitparam_' +
        'id'
      'WHERE p.param_id NOT IN'
      '  (SELECT p.param_id FROM params p'
      '   INNER JOIN'
      '      (SELECT p.* FROM params p'
      
        '       INNER JOIN paramsqueries pq ON pq.param_id = p.param_id A' +
        'ND pq.meter_id = :meter_id AND pq.enabled > 0'
      '      ) rp ON rp.canal = p.canal AND rp.spparam = p.spparam'
      '  ) AND p.groupparams_id = :groupparams_id'
      'ORDER BY p.spparam, p.canal')
    Params = <
      item
        DataType = ftUnknown
        Name = 'meter_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'groupparams_id'
        ParamType = ptUnknown
      end>
    DataSource = dtsMeters
    Left = 483
    Top = 319
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'meter_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'groupparams_id'
        ParamType = ptUnknown
      end>
    object dtbParamsparam_id: TLargeintField
      FieldName = 'param_id'
      Required = True
      Visible = False
    end
    object dtbParamsspparam: TLargeintField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'spparam'
    end
    object dtbParamscanal: TLargeintField
      DisplayLabel = #1058#1088#1091#1073#1086#1087#1088#1086#1074#1086#1076
      FieldName = 'canal'
    end
    object dtbParamsdescription: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'description'
      Size = 120
    end
    object dtbParamsunitSN: TStringField
      DisplayLabel = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      FieldName = 'unitSN'
      Visible = False
      Size = 45
    end
  end
  object dtbGroupsParams: TZReadOnlyQuery
    SQL.Strings = (
      'select * from groupsparams where typemeter_id = :typemeter_id')
    Params = <
      item
        DataType = ftUnknown
        Name = 'typemeter_id'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      'select name from typemeters where typemeter_id = :typemeter_id')
    DataSource = dtsMeters
    MasterFields = 'typemeter_id'
    MasterSource = dtsMeters
    Left = 358
    Top = 318
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'typemeter_id'
        ParamType = ptUnknown
      end>
    object dtbGroupsParamsgroupparams_id: TLargeintField
      FieldName = 'groupparams_id'
      Required = True
    end
    object dtbGroupsParamsname: TStringField
      FieldName = 'name'
      Size = 45
    end
    object dtbGroupsParamsuser_id: TLargeintField
      FieldName = 'user_id'
      Required = True
    end
    object dtbGroupsParamstypemeter_id: TLargeintField
      FieldName = 'typemeter_id'
      Required = True
    end
  end
  object dtsGroupsParams: TDataSource
    DataSet = dtbGroupsParams
    Left = 389
    Top = 277
  end
  object dtsParams: TDataSource
    DataSet = dtbParams
    Left = 421
    Top = 277
  end
  object dtbArraies: TZReadOnlyQuery
    SQL.Strings = (
      'SELECT * FROM arraies')
    Params = <>
    Left = 420
    Top = 319
  end
  object dtbUnitsparams: TZReadOnlyQuery
    SQL.Strings = (
      'SELECT * FROM unitsparams')
    Params = <>
    Left = 451
    Top = 319
    object dtbUnitsparamsunitparam_id: TLargeintField
      FieldName = 'unitparam_id'
      Required = True
    end
    object dtbUnitsparamsunitSN: TStringField
      FieldName = 'unitSN'
      Size = 45
    end
    object dtbUnitsparamsunitPR: TStringField
      FieldName = 'unitPR'
      Size = 45
    end
  end
end
