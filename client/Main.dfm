object Main: TMain
  Left = 0
  Top = 0
  Caption = 'SpTouch Client'
  ClientHeight = 518
  ClientWidth = 794
  Color = clBtnFace
  Constraints.MinHeight = 422
  Constraints.MinWidth = 680
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 26
    Width = 794
    Height = 492
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = 'Panel5'
    TabOrder = 0
    object Panel: TPanel
      Left = 3
      Top = 468
      Width = 788
      Height = 21
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object LabelConnection: TLabel
        Left = 0
        Top = 0
        Width = 64
        Height = 21
        Align = alLeft
        Caption = #1057#1074#1103#1079#1100' '#1077#1089#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
      object PlanLastUpdateLabel: TLabel
        Left = 64
        Top = 0
        Width = 724
        Height = 21
        Hint = #1042#1088#1077#1084#1103' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1089' '#1089#1077#1088#1074#1077#1088#1086#1084
        Align = alClient
        Alignment = taRightJustify
        Caption = 'PlanLastUpdateLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
        ExplicitLeft = 588
        ExplicitWidth = 200
        ExplicitHeight = 23
      end
    end
    object PageControl: TcxPageControl
      Left = 3
      Top = 3
      Width = 788
      Height = 465
      ActivePage = cxTabSheet_2
      Align = alClient
      Images = ImgPageControl
      Options = [pcoAlwaysShowGoDialogButton, pcoGoDialog, pcoGradient, pcoGradientClientArea, pcoRedrawOnResize]
      ShowFrame = True
      TabOrder = 1
      ClientRectBottom = 464
      ClientRectLeft = 1
      ClientRectRight = 787
      ClientRectTop = 33
      object cxTabSheet_1: TcxTabSheet
        Caption = #1069#1082#1088#1072#1085#1099
        ImageIndex = 0
        object MdSplitter1: TMdSplitter
          Left = 217
          Top = 0
          Height = 431
          ExplicitHeight = 433
        end
        object PanelAnalogTree: TPanel
          Left = 0
          Top = 0
          Width = 217
          Height = 431
          Align = alLeft
          BevelOuter = bvNone
          Color = clGray
          TabOrder = 0
          object ToolBarAnalogTree: TToolBar
            Left = 0
            Top = 0
            Width = 217
            Height = 22
            AutoSize = True
            ButtonWidth = 50
            Caption = 'ToolBarAnalogTree'
            Color = clGray
            DrawingStyle = dsGradient
            GradientEndColor = 11319229
            Images = TreeManage
            List = True
            ParentColor = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Transparent = False
            object AnalogTreeToolBtnAdd: TToolButton
              Left = 0
              Top = 0
              Action = PlanAddNode
            end
            object AnalogTreeToolBtnDel: TToolButton
              Left = 50
              Top = 0
              Action = AnalogDeleteNode
            end
            object AnalogTreeToolBtnMod: TToolButton
              Left = 100
              Top = 0
              Action = AnalogModNode
            end
            object ToolButton6: TToolButton
              Left = 150
              Top = 0
              Action = AnalogSearch
            end
          end
          object PlanTree: TcxTreeList
            Left = 0
            Top = 22
            Width = 217
            Height = 409
            BorderStyle = cxcbsNone
            Align = alClient
            Bands = <
              item
              end>
            Images = ImgPlanTree
            OptionsBehavior.DragDropText = True
            OptionsData.CancelOnExit = False
            OptionsData.Editing = False
            OptionsData.Deleting = False
            OptionsSelection.HideFocusRect = False
            OptionsView.ColumnAutoWidth = True
            PopupMenu = PlanMenu
            TabOrder = 1
            OnColumnHeaderClick = PlanTreeColumnHeaderClick
            OnDragDrop = PlanTreeDragDrop
            OnDragOver = PlanTreeDragOver
            OnFocusedNodeChanged = PlanTreeFocusedNodeChanged
            OnGetDragDropText = PlanTreeGetDragDropText
            OnMouseMove = PlanTreeMouseMove
            object AnalogTreeColumn1: TcxTreeListColumn
              Caption.Text = '-'
              DataBinding.ValueType = 'String'
              Options.VertSizing = False
              Options.Moving = False
              Width = 100
              Position.ColIndex = 0
              Position.RowIndex = 0
              Position.BandIndex = 0
              Summary.FooterSummaryItems = <>
              Summary.GroupFooterSummaryItems = <>
            end
            object AnalogTreeColumn2: TcxTreeListColumn
              Visible = False
              DataBinding.ValueType = 'String'
              Width = 100
              Position.ColIndex = 1
              Position.RowIndex = 0
              Position.BandIndex = 0
              Summary.FooterSummaryItems = <>
              Summary.GroupFooterSummaryItems = <>
            end
          end
        end
        object Panel3: TPanel
          Left = 220
          Top = 0
          Width = 566
          Height = 431
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          OnDockDrop = Panel3DockDrop
          object MdSplitter2: TMdSplitter
            Left = 0
            Top = 293
            Width = 566
            Height = 3
            Cursor = crVSplit
            Align = alBottom
            ExplicitTop = -30
            ExplicitWidth = 988
          end
          object ProductInfo: TLabel
            Left = 0
            Top = 19
            Width = 566
            Height = 43
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'ProductInfo'
            Color = clWhite
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clBlue
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            Layout = tlCenter
            ExplicitLeft = 3
            ExplicitTop = 13
          end
          object BarDiagrams: TToolBar
            Left = 0
            Top = 0
            Width = 566
            Height = 19
            AutoSize = True
            ButtonHeight = 19
            ButtonWidth = 91
            Caption = 'ToolBar3'
            Color = clGray
            DrawingStyle = dsGradient
            GradientEndColor = 11319229
            List = True
            ParentColor = False
            ParentShowHint = False
            ShowCaptions = True
            ShowHint = True
            TabOrder = 0
            Transparent = False
            object ToolButton29: TToolButton
              Left = 0
              Top = 0
              Action = AnalogModDiagrams
            end
            object ToolButton20: TToolButton
              Left = 91
              Top = 0
              Action = FullForm
              Style = tbsCheck
            end
            object SaveAllBtn: TToolButton
              Left = 182
              Top = 0
              Action = PlanSaveAll
            end
            object DesignAreaBtn: TToolButton
              Left = 273
              Top = 0
              Action = DesignArea
              Style = tbsCheck
            end
            object ToolButton1: TToolButton
              Left = 364
              Top = 0
              Action = LoadPlan
            end
          end
          object RollPanel: TbsSkinPaintPanel
            Left = 0
            Top = 296
            Width = 566
            Height = 135
            TabOrder = 1
            SkinDataName = 'panel'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            RealHeight = -1
            AutoEnabledControls = True
            CheckedMode = False
            Checked = False
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = True
            RollUpMode = True
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = #1044#1072#1085#1085#1099#1077
            Align = alBottom
            object cxPageControl: TcxPageControl
              Left = 1
              Top = 23
              Width = 564
              Height = 111
              ActivePage = cxTabSheet1
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = cxPageControlChange
              ClientRectBottom = 111
              ClientRectRight = 564
              ClientRectTop = 24
              object cxTabSheet1: TcxTabSheet
                Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103
                ImageIndex = 0
                object CurrentBarInfoValueLabel: TLabel
                  Left = 3
                  Top = 3
                  Width = 159
                  Height = 16
                  Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlue
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object CurrentBarInfoValue: TLabel
                  Left = 222
                  Top = 3
                  Width = 155
                  Height = 16
                  Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlue
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object MinBarInfoValue: TLabel
                  Left = 222
                  Top = 19
                  Width = 181
                  Height = 16
                  Caption = #1053#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1090#1077#1093'. '#1082#1086#1085#1090#1088#1086#1083#1103
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object MaxBarInfoValue: TLabel
                  Left = 222
                  Top = 35
                  Width = 186
                  Height = 16
                  Caption = #1042#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1090#1077#1093'. '#1082#1086#1085#1090#1088#1086#1083#1103
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object BarInfoDeviceName: TLabel
                  Left = 222
                  Top = 51
                  Width = 67
                  Height = 16
                  Caption = #8470' '#1087#1088#1080#1073#1086#1088#1072
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object CanalBarInfo: TLabel
                  Left = 222
                  Top = 67
                  Width = 87
                  Height = 16
                  Caption = #8470' '#1090#1086#1095#1082#1080' '#1091#1095#1077#1090#1072
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object MinBarInfoValueLabel: TLabel
                  Left = 4
                  Top = 19
                  Width = 207
                  Height = 16
                  Caption = #1053#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1090#1077#1093'. '#1082#1086#1085#1090#1088#1086#1083#1103':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object MaxBarInfoValueLabel: TLabel
                  Left = 4
                  Top = 35
                  Width = 213
                  Height = 16
                  Caption = #1042#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1090#1077#1093'. '#1082#1086#1085#1090#1088#1086#1083#1103':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object BarInfoDeviceNameLabel: TLabel
                  Left = 4
                  Top = 51
                  Width = 53
                  Height = 16
                  Caption = #1055#1088#1080#1073#1086#1088':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object CanalBarInfoLabel: TLabel
                  Left = 3
                  Top = 67
                  Width = 84
                  Height = 16
                  Caption = #1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
              end
              object cxTabSheet2: TcxTabSheet
                Caption = #1040#1088#1093#1080#1074' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
                ImageIndex = 1
                object ToolBar1: TToolBar
                  Left = 0
                  Top = 0
                  Width = 564
                  Height = 22
                  Caption = 'ToolBar1'
                  EdgeBorders = [ebBottom]
                  Images = ImageList
                  TabOrder = 0
                  object ToolButton9: TToolButton
                    Left = 0
                    Top = 0
                    Caption = 'ToolButton9'
                    ImageIndex = 1
                    OnClick = ToolButton9Click
                  end
                end
                object ChartInfoBarArchive: TChart
                  Left = 0
                  Top = 22
                  Width = 564
                  Height = 65
                  BackWall.Color = clWhite
                  BackWall.Gradient.EndColor = 11118482
                  BackWall.Transparent = False
                  BottomWall.Gradient.EndColor = 16580349
                  BottomWall.Gradient.StartColor = 3114493
                  LeftWall.Color = clWhite
                  LeftWall.Gradient.EndColor = 2413052
                  LeftWall.Gradient.StartColor = 900220
                  Legend.Color = clInfoBk
                  Legend.DividingLines.Color = clSilver
                  Legend.Font.Color = 6553600
                  Legend.Font.Height = -12
                  Legend.Font.Name = 'Lucida Console'
                  Legend.Frame.Color = clGray
                  Legend.Gradient.Direction = gdTopBottom
                  Legend.Gradient.EndColor = clYellow
                  Legend.Gradient.StartColor = clWhite
                  Legend.Shadow.Color = clGray
                  Legend.Symbol.Pen.Visible = False
                  Legend.Symbol.Squared = True
                  Legend.Visible = False
                  RightWall.Color = clWhite
                  Title.Alignment = taLeftJustify
                  Title.Color = clInfoBk
                  Title.Font.Color = clBlack
                  Title.Font.Height = -13
                  Title.Font.Name = 'Lucida Console'
                  Title.Font.Style = [fsBold]
                  Title.Frame.Color = clGray
                  Title.Gradient.Balance = 40
                  Title.Gradient.Direction = gdRightLeft
                  Title.Gradient.EndColor = clBlack
                  Title.Gradient.MidColor = 8388672
                  Title.Gradient.StartColor = clGray
                  Title.Shadow.HorizSize = 0
                  Title.Shadow.Transparency = 70
                  Title.Shadow.VertSize = 0
                  Title.Text.Strings = (
                    'TChart')
                  Title.Transparent = False
                  BottomAxis.Grid.Color = 12895428
                  BottomAxis.Grid.Style = psSolid
                  BottomAxis.Grid.Visible = False
                  BottomAxis.LabelsFont.Name = 'Lucida Console'
                  BottomAxis.MinorGrid.Color = 15066597
                  BottomAxis.MinorTickLength = -3
                  BottomAxis.MinorTicks.Color = clBlack
                  BottomAxis.TickInnerLength = 6
                  BottomAxis.TickLength = 0
                  BottomAxis.TicksInner.Color = clBlack
                  DepthAxis.Grid.Color = 12895428
                  DepthAxis.Grid.Style = psSolid
                  DepthAxis.LabelsFont.Name = 'Lucida Console'
                  DepthAxis.MinorTickLength = -3
                  DepthAxis.MinorTicks.Color = clBlack
                  DepthAxis.TickInnerLength = 6
                  DepthAxis.TickLength = 0
                  DepthAxis.TicksInner.Color = clBlack
                  DepthAxis.Title.Font.Height = -13
                  DepthTopAxis.Grid.Color = 12895428
                  DepthTopAxis.Grid.Style = psSolid
                  DepthTopAxis.LabelsFont.Name = 'Lucida Console'
                  DepthTopAxis.MinorTickLength = -3
                  DepthTopAxis.MinorTicks.Color = clBlack
                  DepthTopAxis.TickInnerLength = 6
                  DepthTopAxis.TickLength = 0
                  DepthTopAxis.TicksInner.Color = clBlack
                  LeftAxis.AxisValuesFormat = '#,##0.#'
                  LeftAxis.Grid.Color = 12895428
                  LeftAxis.Grid.Style = psSolid
                  LeftAxis.Grid.SmallSpace = 5
                  LeftAxis.LabelsFont.Name = 'Lucida Console'
                  LeftAxis.MinorTickLength = -3
                  LeftAxis.MinorTicks.Color = clBlack
                  LeftAxis.TickInnerLength = 6
                  LeftAxis.TickLength = 0
                  LeftAxis.TicksInner.Color = clBlack
                  RightAxis.Grid.Color = 12895428
                  RightAxis.Grid.Style = psSolid
                  RightAxis.LabelsFont.Name = 'Lucida Console'
                  RightAxis.MinorTickLength = -3
                  RightAxis.MinorTicks.Color = clBlack
                  RightAxis.TickInnerLength = 6
                  RightAxis.TickLength = 0
                  RightAxis.TicksInner.Color = clBlack
                  Shadow.Color = clBlack
                  TopAxis.Grid.Color = 12895428
                  TopAxis.Grid.Style = psSolid
                  TopAxis.Grid.Visible = False
                  TopAxis.LabelsFont.Name = 'Lucida Console'
                  TopAxis.MinorTickLength = -3
                  TopAxis.MinorTicks.Color = clBlack
                  TopAxis.TickInnerLength = 6
                  TopAxis.TickLength = 0
                  TopAxis.TicksInner.Color = clBlack
                  View3D = False
                  Zoom.Allow = False
                  Align = alClient
                  BevelOuter = bvNone
                  TabOrder = 1
                  PrintMargins = (
                    15
                    42
                    15
                    42)
                  ColorPaletteIndex = 6
                end
              end
            end
          end
          object ScrollBox3: TScrollBox
            Left = 0
            Top = 62
            Width = 566
            Height = 231
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            TabOrder = 2
            object SpDesignArea: TSpDesignPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 231
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              OnSave = SpDesignAreaSave
            end
          end
        end
      end
      object cxTabSheet_2: TcxTabSheet
        Caption = #1040#1088#1093#1080#1074
        ImageIndex = 1
        object MdSplitter5: TMdSplitter
          Left = 623
          Top = 65
          Height = 196
          Align = alRight
          ExplicitLeft = 658
          ExplicitHeight = 222
        end
        object MdSplitter3: TMdSplitter
          Left = 0
          Top = 261
          Width = 786
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ExplicitLeft = -3
          ExplicitTop = 171
          ExplicitWidth = 743
        end
        object ToolBar2: TToolBar
          Left = 0
          Top = 0
          Width = 786
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 35
          Caption = 'ToolBar3'
          Color = clGray
          DrawingStyle = dsGradient
          GradientEndColor = 11319229
          Images = ImgSutArchMod
          List = True
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Transparent = False
          object ToolBtnOpenArchive: TToolButton
            Left = 0
            Top = 0
            Action = ActionOpenArchive
          end
          object ToolBtnPrintArchive: TToolButton
            Left = 35
            Top = 0
            Action = PrintArchive
          end
          object ToolBtnResetArchive: TToolButton
            Left = 70
            Top = 0
            Action = ResetArchiveView
          end
          object ToolBtnShowMarksArchive: TToolButton
            Left = 105
            Top = 0
            Action = ShowScaleMarksArchive
            AllowAllUp = True
            Style = tbsCheck
          end
          object ToolBtnDragPointArchive: TToolButton
            Left = 140
            Top = 0
            Action = DragScalePointArchive
            Style = tbsCheck
          end
          object ToolBtnPrintScaleArchive: TToolButton
            Left = 175
            Top = 0
            Action = PrintIncludeScaleArchive
            Style = tbsCheck
          end
          object ToolBtnExportDataArchive: TToolButton
            Left = 210
            Top = 0
            Action = ExportArchiveData
          end
        end
        object PanelCrossValue: TPanel
          Left = 0
          Top = 30
          Width = 786
          Height = 35
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          BorderWidth = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          object TagCrossTime: TLabel
            Left = 5
            Top = 5
            Width = 138
            Height = 25
            Align = alLeft
            Caption = 'TagCrossTime'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clBlack
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitHeight = 22
          end
        end
        object ScrollBox2: TScrollBox
          Left = 626
          Top = 65
          Width = 160
          Height = 196
          VertScrollBar.Tracking = True
          Align = alRight
          BorderStyle = bsNone
          TabOrder = 2
          object PanelCrossValues: TPanel
            Left = 0
            Top = 0
            Width = 160
            Height = 81
            Align = alTop
            BevelOuter = bvNone
            Constraints.MinWidth = 137
            ParentColor = True
            TabOrder = 0
          end
        end
        object PanelChart: TPanel
          Left = 0
          Top = 65
          Width = 623
          Height = 196
          Align = alClient
          ParentColor = True
          TabOrder = 3
          object ArchiveChart: TChart
            Left = 1
            Top = 1
            Width = 600
            Height = 173
            AllowPanning = pmNone
            BackImage.Inside = True
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            BackWall.Color = clBackground
            BorderRound = 1
            Foot.AdjustFrame = False
            Foot.Visible = False
            Gradient.Direction = gdBottomTop
            Gradient.EndColor = clWhite
            Gradient.StartColor = clSilver
            LeftWall.Color = clBlack
            Legend.Alignment = laLeft
            Legend.Visible = False
            MarginBottom = 0
            MarginLeft = 20
            MarginRight = 20
            MarginTop = 15
            MarginUnits = muPixels
            SubTitle.Visible = False
            Title.AdjustFrame = False
            Title.Alignment = taLeftJustify
            Title.CustomPosition = True
            Title.Font.Color = clBlack
            Title.Frame.Style = psDash
            Title.Left = 5
            Title.Text.Strings = (
              'TChart')
            Title.Top = 10
            Title.Visible = False
            AxisVisible = False
            BottomAxis.Automatic = False
            BottomAxis.AutomaticMaximum = False
            BottomAxis.AutomaticMinimum = False
            BottomAxis.Axis.Width = 1
            BottomAxis.AxisValuesFormat = 'dd.MM.yyyy'
            BottomAxis.DateTimeFormat = 'h:mm'
            BottomAxis.ExactDateTime = False
            BottomAxis.Grid.ZPosition = 100.000000000000000000
            BottomAxis.Increment = 0.083333333333333310
            BottomAxis.LabelsSize = 12
            BottomAxis.Maximum = 0.999988425925926000
            BottomAxis.MinorTickCount = 1
            BottomAxis.MinorTickLength = 4
            BottomAxis.TickLength = 10
            BottomAxis.Title.Caption = #1042#1088#1077#1084#1103
            BottomAxis.Title.Font.Height = -15
            BottomAxis.Title.Font.Style = [fsBold]
            BottomAxis.ZPosition = 100.000000000000000000
            Chart3DPercent = 20
            DepthAxis.Automatic = False
            DepthAxis.AutomaticMaximum = False
            DepthAxis.AutomaticMinimum = False
            DepthAxis.Maximum = 1.010000000000000000
            DepthAxis.Minimum = 0.010000000000000220
            DepthTopAxis.Automatic = False
            DepthTopAxis.AutomaticMaximum = False
            DepthTopAxis.AutomaticMinimum = False
            DepthTopAxis.Maximum = 1.130000000000001000
            DepthTopAxis.Minimum = 0.130000000000000300
            LeftAxis.Automatic = False
            LeftAxis.AutomaticMaximum = False
            LeftAxis.AutomaticMinimum = False
            LeftAxis.Axis.Width = 1
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 50.000000000000000000
            LeftAxis.LabelsSize = 20
            LeftAxis.Maximum = 100.000000000000000000
            LeftAxis.MinorTickCount = 1
            LeftAxis.MinorTickLength = 4
            LeftAxis.RoundFirstLabel = False
            LeftAxis.TickLength = 10
            LeftAxis.Title.Caption = '%'
            LeftAxis.Title.Font.Height = -15
            LeftAxis.Title.Font.Style = [fsBold]
            LeftAxis.TitleSize = 1
            LeftAxis.ZPosition = 100.000000000000000000
            RightAxis.Automatic = False
            RightAxis.AutomaticMaximum = False
            RightAxis.AutomaticMinimum = False
            RightAxis.ExactDateTime = False
            RightAxis.Increment = 1.000000000000000000
            RightAxis.LabelsSize = 20
            RightAxis.Maximum = 151.000000000000000000
            RightAxis.Minimum = 51.000000000000000000
            RightAxis.Title.Angle = 90
            RightAxis.Title.Caption = '333333'
            RightAxis.Title.Font.Height = -15
            RightAxis.Title.Font.Style = [fsBold]
            RightAxis.TitleSize = 1
            TopAxis.Automatic = False
            TopAxis.AutomaticMaximum = False
            TopAxis.AutomaticMinimum = False
            TopAxis.Axis.Color = clSilver
            TopAxis.Axis.Width = 1
            TopAxis.Grid.Visible = False
            TopAxis.LabelsSize = 5
            TopAxis.MinorTickCount = 0
            TopAxis.Title.Visible = False
            TopAxis.ZPosition = 0.010000000000000000
            View3D = False
            View3DOptions.Zoom = 56
            View3DWalls = False
            Zoom.Allow = False
            Zoom.Animated = True
            OnAfterDraw = ArchiveChartAfterDraw
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            OnClick = ArchiveChartClick
            OnKeyDown = ArchiveChartKeyDown
            OnMouseMove = ArchiveChartMouseMove
            OnMouseWheel = ArchiveChartMouseWheel
            PrintMargins = (
              15
              31
              15
              31)
            object ChartDragPointTool: TDragPointTool
              DragStyle = dsY
            end
          end
          object PanelBottomAnalogScroll: TPanel
            Left = 1
            Top = 174
            Width = 621
            Height = 21
            Align = alBottom
            AutoSize = True
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object BtnSRight: TSpeedButton
              Left = 576
              Top = 0
              Width = 23
              Height = 21
              Action = StretchRight
              Align = alRight
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888088888888800088800888888880008880008888888000888000088888
                8000888000008888800088800000088880008880000088888000888000088888
                8000888000888888800088800888888880008880888888888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 583
              ExplicitTop = -1
              ExplicitHeight = 20
            end
            object BtnNRight: TSpeedButton
              Left = 553
              Top = 0
              Width = 23
              Height = 21
              Action = NarrowRight
              Align = alRight
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888888888088800088888888008880008888888000888000888888000088
                8000888880000088800088880000008880008888800000888000888888000088
                8000888888800088800088888888008880008888888880888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 554
              ExplicitTop = -3
              ExplicitHeight = 22
            end
            object BtnSLeft: TSpeedButton
              Left = 0
              Top = 0
              Width = 23
              Height = 21
              Action = StretchLeft
              Align = alLeft
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888888888088800088888888008880008888888000888000888888000088
                8000888880000088800088880000008880008888800000888000888888000088
                8000888888800088800088888888008880008888888880888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitHeight = 20
            end
            object BtnNLeft: TSpeedButton
              Left = 23
              Top = 0
              Width = 23
              Height = 21
              Action = NarrowLeft
              Align = alLeft
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888088888888800088800888888880008880008888888000888000088888
                8000888000008888800088800000088880008880000088888000888000088888
                8000888000888888800088800888888880008880888888888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitHeight = 20
            end
            object BottomScroll: TScrollBar
              AlignWithMargins = True
              Left = 48
              Top = 2
              Width = 503
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BiDiMode = bdLeftToRight
              Ctl3D = True
              Max = 0
              PageSize = 0
              ParentBiDiMode = False
              ParentCtl3D = False
              TabOrder = 0
              TabStop = False
              OnChange = BottomScrollChange
            end
            object Panel1: TPanel
              Left = 599
              Top = 0
              Width = 22
              Height = 21
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
            end
          end
          object PanelRightAnalogScroll: TPanel
            Left = 601
            Top = 1
            Width = 21
            Height = 173
            Align = alRight
            AutoSize = True
            BevelOuter = bvNone
            TabOrder = 2
            object BtnSBottom: TSpeedButton
              Left = 0
              Top = 150
              Width = 21
              Height = 23
              Action = StretchBottom
              Align = alBottom
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888888888888800088888888888880008888888888888000888888088888
                8000888880008888800088880000088880008880000000888000880000000008
                8000800000000000800088888888888880008888888888888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitTop = 227
              ExplicitWidth = 20
            end
            object BtnNBottom: TSpeedButton
              Left = 0
              Top = 127
              Width = 21
              Height = 23
              Action = NarrowBottom
              Align = alBottom
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888888888888800088888888888880008000000000008000880000000008
                8000888000000088800088880000088880008888800088888000888888088888
                8000888888888888800088888888888880008888888888888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitTop = 205
              ExplicitWidth = 20
            end
            object BtnSTop: TSpeedButton
              Left = 0
              Top = 0
              Width = 21
              Height = 23
              Action = StretchTop
              Align = alTop
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888888888888800088888888888880008000000000008000880000000008
                8000888000000088800088880000088880008888800088888000888888088888
                8000888888888888800088888888888880008888888888888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitWidth = 20
            end
            object BtnNTop: TSpeedButton
              Left = 0
              Top = 23
              Width = 21
              Height = 23
              Action = NarrowTop
              Align = alTop
              Flat = True
              Glyph.Data = {
                DE000000424DDE0000000000000076000000280000000D0000000D0000000100
                0400000000006800000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8000888888888888800088888888888880008888888888888000888888088888
                8000888880008888800088880000088880008880000000888000880000000008
                8000800000000000800088888888888880008888888888888000888888888888
                8000}
              ParentShowHint = False
              ShowHint = True
              ExplicitTop = 22
              ExplicitWidth = 20
            end
            object RightScroll: TScrollBar
              AlignWithMargins = True
              Left = 2
              Top = 48
              Width = 17
              Height = 77
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BiDiMode = bdLeftToRight
              Ctl3D = True
              Kind = sbVertical
              Max = 0
              PageSize = 0
              ParentBiDiMode = False
              ParentCtl3D = False
              TabOrder = 0
              TabStop = False
              OnChange = RightScrollChange
            end
          end
        end
        object bsSkinPaintPanel1: TbsSkinPaintPanel
          Left = 0
          Top = 264
          Width = 786
          Height = 167
          TabOrder = 4
          SkinDataName = 'panel'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          RealHeight = -1
          AutoEnabledControls = True
          CheckedMode = False
          Checked = False
          DefaultAlignment = taLeftJustify
          DefaultCaptionHeight = 22
          BorderStyle = bvFrame
          CaptionMode = True
          RollUpMode = True
          RollUpState = False
          NumGlyphs = 1
          Spacing = 2
          Caption = #1044#1072#1085#1085#1099#1077
          Align = alBottom
          object Panel2: TPanel
            Left = 1
            Top = 23
            Width = 784
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object SelectAllBtn: TMdBitBtn
              Left = 2
              Top = 2
              Width = 99
              Height = 20
              Action = ActionCheckedArchiveParams
              Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
              TabOrder = 0
            end
          end
          object GridDisplayParams: TcxGrid
            Left = 1
            Top = 48
            Width = 784
            Height = 118
            Align = alClient
            TabOrder = 1
            object GridDisplayParamsDBTableView: TcxGridDBTableView
              NavigatorButtons.ConfirmDelete = False
              OnFocusedRecordChanged = GridDisplayParamsDBTableViewFocusedRecordChanged
              DataController.DataSource = dtsRxDisplayParams
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              object GridDisplayParamsDBTableViewparamquery_id: TcxGridDBColumn
                DataBinding.FieldName = 'paramquery_id'
                Visible = False
              end
              object GridDisplayParamsDBTableViewBooShowSeries: TcxGridDBColumn
                DataBinding.FieldName = 'BooShowSeries'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.OnChange = GridDisplayParamsDBTableView1BooShowSeriesPropertiesChange
                Options.HorzSizing = False
                Width = 20
                IsCaptionAssigned = True
              end
              object GridDisplayParamsDBTableViewOrderNumber: TcxGridDBColumn
                DataBinding.FieldName = 'OrderNumber'
                Visible = False
              end
              object GridDisplayParamsDBTableViewcolor: TcxGridDBColumn
                Caption = #1062#1074#1077#1090
                DataBinding.FieldName = 'color'
                OnCustomDrawCell = GridDisplayParamsDBTableViewcolorCustomDrawCell
                MinWidth = 35
                Options.Editing = False
                Options.HorzSizing = False
                Width = 35
              end
              object GridDisplayParamsDBTableViewparamquery_name: TcxGridDBColumn
                DataBinding.FieldName = 'paramquery_name'
                Options.Editing = False
                Width = 317
              end
              object GridDisplayParamsDBTableViewMeterName: TcxGridDBColumn
                DataBinding.FieldName = 'MeterName'
                Visible = False
              end
              object GridDisplayParamsDBTableViewSPParam: TcxGridDBColumn
                DataBinding.FieldName = 'SPParam'
                Visible = False
              end
              object GridDisplayParamsDBTableViewCanal: TcxGridDBColumn
                DataBinding.FieldName = 'Canal'
                Visible = False
              end
              object GridDisplayParamsDBTableViewDescription: TcxGridDBColumn
                DataBinding.FieldName = 'Description'
                Options.Editing = False
                Width = 143
              end
              object GridDisplayParamsDBTableViewlvalue: TcxGridDBColumn
                DataBinding.FieldName = 'lvalue'
                Options.Editing = False
                Width = 135
              end
              object GridDisplayParamsDBTableViewhvalue: TcxGridDBColumn
                DataBinding.FieldName = 'hvalue'
                Options.Editing = False
                Width = 132
              end
              object GridDisplayParamsDBTableViewunitSN: TcxGridDBColumn
                DataBinding.FieldName = 'unitSN'
                Visible = False
              end
            end
            object GridDisplayParamsLevel: TcxGridLevel
              GridView = GridDisplayParamsDBTableView
            end
          end
        end
      end
      object cxTabSheet_3: TcxTabSheet
        Caption = #1054#1090#1095#1077#1090#1099
        ImageIndex = 2
        object MdSplitter4: TMdSplitter
          Left = 217
          Top = 0
          Height = 431
          ExplicitHeight = 433
        end
        object PanelTreeReport: TPanel
          Left = 0
          Top = 0
          Width = 217
          Height = 431
          Align = alLeft
          BevelOuter = bvNone
          Color = clGray
          TabOrder = 0
          object ToolBarReportTree: TToolBar
            Left = 0
            Top = 0
            Width = 217
            Height = 22
            AutoSize = True
            ButtonWidth = 50
            Caption = 'ToolBar3'
            Color = clGray
            DrawingStyle = dsGradient
            GradientEndColor = 11319229
            Images = TreeManage
            List = True
            ParentColor = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Transparent = False
            object ReportTreeToolBtnAdd: TToolButton
              Left = 0
              Top = 0
              Action = ReportAddNode
            end
            object ReportTreeToolBtnDel: TToolButton
              Left = 50
              Top = 0
              Action = ReportDeleteNode
            end
            object ReportTreeToolBtnMod: TToolButton
              Left = 100
              Top = 0
              Action = ReportModNode
            end
            object ToolButton7: TToolButton
              Left = 150
              Top = 0
              Action = ReportSearch
            end
          end
          object PanelFromArchive: TPanel
            Left = 0
            Top = 303
            Width = 217
            Height = 128
            Align = alBottom
            BevelOuter = bvLowered
            TabOrder = 1
            object bsSkinMonthCalendar: TbsSkinMonthCalendar
              Left = 1
              Top = 1
              Width = 215
              Height = 126
              TabOrder = 0
              SkinDataName = 'panel'
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              DefaultWidth = 0
              DefaultHeight = 0
              UseSkinFont = True
              RealHeight = -1
              AutoEnabledControls = True
              CheckedMode = False
              Checked = False
              DefaultAlignment = taLeftJustify
              DefaultCaptionHeight = 22
              BorderStyle = bvNone
              CaptionMode = False
              RollUpMode = False
              RollUpState = False
              NumGlyphs = 1
              Spacing = 2
              Caption = 'bsSkinMonthCalendar'
              Align = alClient
              Date = 40596.963921435180000000
              TodayDefault = True
              FirstDayOfWeek = Sun
              OnNumberClick = bsSkinMonthCalendarNumberClick
              BoldDays = False
            end
          end
          object ReportTree: TcxTreeList
            Left = 0
            Top = 22
            Width = 217
            Height = 281
            BorderStyle = cxcbsNone
            Align = alClient
            Bands = <
              item
                Options.VertSizing = False
              end>
            DragMode = dmAutomatic
            Images = ImgReportTree
            OptionsBehavior.DragDropText = True
            OptionsData.CancelOnExit = False
            OptionsData.Editing = False
            OptionsData.Deleting = False
            OptionsSelection.HideFocusRect = False
            OptionsView.ColumnAutoWidth = True
            PopupMenu = ReportMenu
            TabOrder = 2
            OnColumnHeaderClick = ReportTreeColumnHeaderClick
            OnDragDrop = ReportTreeDragDrop
            OnDragOver = ReportTreeDragOver
            OnFocusedNodeChanged = ReportTreeFocusedNodeChanged
            OnGetDragDropText = ReportTreeGetDragDropText
            OnMouseMove = ReportTreeMouseMove
            object dxTLReportColumn1: TcxTreeListColumn
              Caption.Text = '-'
              DataBinding.ValueType = 'String'
              Options.VertSizing = False
              Options.Moving = False
              Position.ColIndex = 0
              Position.RowIndex = 0
              Position.BandIndex = 0
              Summary.FooterSummaryItems = <>
              Summary.GroupFooterSummaryItems = <>
            end
            object dxTLReportColumn2: TcxTreeListColumn
              Visible = False
              DataBinding.ValueType = 'String'
              Options.VertSizing = False
              Options.Moving = False
              Position.ColIndex = 1
              Position.RowIndex = 0
              Position.BandIndex = 0
              Summary.FooterSummaryItems = <>
              Summary.GroupFooterSummaryItems = <>
            end
          end
        end
        object ScrollBox1: TScrollBox
          Left = 220
          Top = 0
          Width = 566
          Height = 431
          VertScrollBar.Tracking = True
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 1
          object FRPreview: TfrxPreview
            Left = 0
            Top = 64
            Width = 566
            Height = 367
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            OutlineColor = clWhite
            OutlineVisible = False
            OutlineWidth = 120
            ThumbnailVisible = False
            UseReportHints = True
          end
          object PanelReportInfo: TPanel
            Left = 0
            Top = 38
            Width = 566
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            Color = 16744448
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object Label1: TLabel
              Left = 6
              Top = 4
              Width = 152
              Height = 19
              Caption = #1054#1058#1063#1045#1058' '#1048#1047' '#1040#1056#1061#1048#1042#1040
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWhite
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object ToolBar6: TToolBar
            Left = 0
            Top = 0
            Width = 566
            Height = 38
            AutoSize = True
            ButtonHeight = 19
            ButtonWidth = 131
            Caption = 'ToolBar3'
            Color = clGray
            DrawingStyle = dsGradient
            GradientEndColor = 11319229
            List = True
            ParentColor = False
            ParentShowHint = False
            ShowCaptions = True
            ShowHint = True
            TabOrder = 2
            Transparent = False
            object ToolButton38: TToolButton
              Left = 0
              Top = 0
              Action = ReportPrint
            end
            object ToolButton39: TToolButton
              Left = 131
              Top = 0
              Action = ReportDesignAction
            end
            object ToolButton40: TToolButton
              Left = 262
              Top = 0
              Action = ReportFullForm
              Wrap = True
              Style = tbsCheck
            end
            object ToolButton13: TToolButton
              Left = 0
              Top = 19
              Action = ReportSQL
            end
            object ToolButton5: TToolButton
              Left = 131
              Top = 19
              Action = ReportExport
              DropdownMenu = ExportMenu
              Style = tbsDropDown
            end
            object ToolButton8: TToolButton
              Left = 275
              Top = 19
              Action = ReportlFromArchive
              Style = tbsCheck
            end
          end
        end
      end
    end
  end
  object PlanTimer: TTimer
    Enabled = False
    Interval = 0
    OnTimer = PlanTimerTimer
    Left = 296
    Top = 104
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 320
    Top = 168
  end
  object Actions: TActionList
    Left = 168
    Top = 216
    object PrintArchive: TAction
      Category = 'Archive'
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100' '#1072#1088#1093#1080#1074#1072
      ImageIndex = 1
      OnExecute = PrintArchiveExecute
      OnUpdate = PrintArchiveUpdate
    end
    object StretchTop: TAction
      Category = 'Archive'
      Hint = #1056#1072#1089#1090#1103#1085#1091#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = StretchTopExecute
      OnUpdate = StretchTopUpdate
    end
    object NarrowTop: TAction
      Category = 'Archive'
      Hint = #1057#1078#1072#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = NarrowTopExecute
      OnUpdate = NarrowTopUpdate
    end
    object StretchBottom: TAction
      Category = 'Archive'
      Hint = #1056#1072#1089#1090#1103#1085#1091#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = StretchBottomExecute
      OnUpdate = StretchBottomUpdate
    end
    object NarrowBottom: TAction
      Category = 'Archive'
      Hint = #1057#1078#1072#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = NarrowBottomExecute
      OnUpdate = NarrowBottomUpdate
    end
    object StretchRight: TAction
      Category = 'Archive'
      Hint = #1056#1072#1089#1090#1103#1085#1091#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = StretchRightExecute
      OnUpdate = StretchRightUpdate
    end
    object NarrowRight: TAction
      Category = 'Archive'
      Hint = #1057#1078#1072#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = NarrowRightExecute
      OnUpdate = NarrowRightUpdate
    end
    object StretchLeft: TAction
      Category = 'Archive'
      Hint = #1056#1072#1089#1090#1103#1085#1103#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = StretchLeftExecute
      OnUpdate = StretchLeftUpdate
    end
    object NarrowLeft: TAction
      Category = 'Archive'
      Hint = #1057#1078#1072#1090#1100' '#1075#1088#1072#1092#1080#1082
      OnExecute = NarrowLeftExecute
      OnUpdate = NarrowLeftUpdate
    end
    object ReportPrint: TAction
      Category = 'ReportEdit'
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 0
      ShortCut = 16464
      OnExecute = ReportPrintExecute
      OnUpdate = ReportPrintUpdate
    end
    object ResetArchiveView: TAction
      Category = 'Archive'
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1079#1084#1077#1088' '#1075#1088#1072#1092#1080#1082#1072
      ImageIndex = 2
      OnExecute = ResetArchiveViewExecute
      OnUpdate = ResetArchiveViewUpdate
    end
    object ReportDesignAction: TAction
      Category = 'ReportEdit'
      Caption = '&'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090
      Hint = #1054#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090
      ImageIndex = 1
      OnExecute = ReportDesignActionExecute
      OnUpdate = ReportDesignActionUpdate
    end
    object ActionOpenArchive: TAction
      Category = 'Archive'
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1072#1088#1093#1080#1074
      ImageIndex = 0
      OnExecute = ActionOpenArchiveExecute
    end
    object PlanAddNode: TAction
      Category = 'PlanTree'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091'/'#1101#1083#1077#1084#1077#1085#1090
      ImageIndex = 0
      OnExecute = PlanAddNodeExecute
      OnUpdate = PlanAddNodeUpdate
    end
    object AnalogDeleteNode: TAction
      Category = 'PlanTree'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091'/'#1101#1083#1077#1084#1077#1085#1090
      ImageIndex = 1
      OnExecute = AnalogDeleteNodeExecute
      OnUpdate = AnalogDeleteNodeUpdate
    end
    object AnalogModNode: TAction
      Category = 'PlanTree'
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1054#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091'/'#1101#1083#1077#1084#1077#1085#1090
      ImageIndex = 2
      OnExecute = AnalogModNodeExecute
      OnUpdate = AnalogModNodeUpdate
    end
    object AnalogModDiagrams: TAction
      Category = 'PlanEdit'
      Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1080#1072#1075#1088#1072#1084#1084
      OnExecute = AnalogModDiagramsExecute
      OnUpdate = AnalogModDiagramsUpdate
    end
    object ReportAddNode: TAction
      Category = 'ReportTree'
      Caption = #1044#1072#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091'/'#1101#1083#1077#1084#1077#1085#1090
      ImageIndex = 0
      OnExecute = ReportAddNodeExecute
      OnUpdate = ReportAddNodeUpdate
    end
    object ReportDeleteNode: TAction
      Category = 'ReportTree'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091'/'#1101#1083#1077#1084#1077#1085#1090
      ImageIndex = 1
      OnExecute = ReportDeleteNodeExecute
      OnUpdate = ReportDeleteNodeUpdate
    end
    object ReportModNode: TAction
      Category = 'ReportTree'
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1054#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091'/'#1101#1083#1077#1084#1077#1085#1090
      ImageIndex = 2
      OnExecute = ReportModNodeExecute
      OnUpdate = ReportModNodeUpdate
    end
    object FullForm: TAction
      Category = 'PlanEdit'
      Caption = #1053#1072' '#1074#1089#1102' '#1092#1086#1088#1084#1091
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1085#1072' '#1074#1089#1102' '#1092#1086#1088#1084#1091
      OnExecute = FullFormExecute
    end
    object ReportFullForm: TAction
      Category = 'ReportEdit'
      Caption = #1053#1072' '#1074#1089#1102' '#1092#1086#1088#1084#1091
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1085#1072' '#1074#1089#1102' '#1092#1086#1088#1084#1091
      OnExecute = ReportFullFormExecute
    end
    object AnalogCollapse: TAction
      Category = 'PlanTree'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1091#1079#1077#1083
      OnExecute = AnalogCollapseExecute
    end
    object AnalogExpand: TAction
      Category = 'PlanTree'
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1091#1079#1077#1083
      OnExecute = AnalogExpandExecute
    end
    object ReportCollapse: TAction
      Category = 'ReportEdit'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1091#1079#1077#1083
      OnExecute = ReportCollapseExecute
    end
    object ReportExpand: TAction
      Category = 'ReportEdit'
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1091#1079#1077#1083
      OnExecute = ReportExpandExecute
    end
    object ReportSQL: TAction
      Category = 'ReportEdit'
      Caption = 'SQL'
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' SQL '#1076#1083#1103' '#1086#1090#1095#1077#1090#1072
      OnExecute = ReportSQLExecute
      OnUpdate = ReportSQLUpdate
    end
    object ShowScaleMarksArchive: TAction
      Category = 'Archive'
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1084#1077#1090#1082#1080'-'#1079#1085#1072#1095#1077#1085#1080#1103' '#1085#1072' '#1075#1088#1072#1092#1080#1082#1077
      ImageIndex = 3
      OnExecute = ShowScaleMarksArchiveExecute
      OnUpdate = ShowScaleMarksArchiveUpdate
    end
    object ActionSettings: TAction
      Category = 'Menu'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      OnExecute = ActionSettingsExecute
    end
    object ReportExport: TAction
      Category = 'ReportEdit'
      Caption = #1069#1082#1089#1087#1086#1088#1090
      Hint = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090' '#1074' '#1092#1072#1081#1083
      OnUpdate = ReportExportUpdate
    end
    object AnalogSearch: TAction
      Category = 'PlanTree'
      Hint = #1053#1072#1081#1090#1080
      ImageIndex = 3
      OnExecute = AnalogSearchExecute
      OnUpdate = AnalogSearchUpdate
    end
    object ReportSearch: TAction
      Category = 'ReportTree'
      Hint = #1053#1072#1081#1090#1080
      ImageIndex = 3
      OnExecute = ReportSearchExecute
      OnUpdate = ReportSearchUpdate
    end
    object DragScalePointArchive: TAction
      Category = 'Archive'
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1082#1072#1079#1072#1085#1080#1103' '#1085#1072' '#1075#1088#1072#1092#1080#1082#1077
      ImageIndex = 4
      OnExecute = DragScalePointArchiveExecute
      OnUpdate = DragScalePointArchiveUpdate
    end
    object ReportlFromArchive: TAction
      Category = 'ReportEdit'
      Caption = #1048#1079' '#1072#1088#1093#1080#1074#1072
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1072#1088#1093#1080#1074#1072
      OnExecute = ReportlFromArchiveExecute
      OnUpdate = ReportlFromArchiveUpdate
    end
    object PrintIncludeScaleArchive: TAction
      Category = 'Archive'
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1096#1082#1072#1083#1091' '#1089#1087#1088#1072#1074#1072' '#1087#1088#1080' '#1087#1077#1095#1072#1090#1080
      ImageIndex = 5
      OnUpdate = PrintIncludeScaleArchiveUpdate
    end
    object ExportArchiveData: TAction
      Category = 'Archive'
      Hint = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1092#1072#1081#1083
      ImageIndex = 6
      OnExecute = ExportArchiveDataExecute
      OnUpdate = ExportArchiveDataUpdate
    end
    object AlertArchive: TAction
      Category = 'Menu'
      Caption = #1040#1088#1093#1080#1074' ('#1087#1088#1077#1076'-)'#1072#1074#1072#1088#1080#1081#1085#1099#1093' '#1089#1080#1090#1091#1072#1094#1080#1081
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1072#1088#1093#1080#1074' '#1072#1074#1072#1088#1080#1081#1085#1099#1093' '#1089#1080#1090#1091#1072#1094#1080#1081
      OnExecute = AlertArchiveExecute
    end
    object ActionCheckedArchiveParams: TAction
      Category = 'Archive'
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      OnExecute = ActionCheckedArchiveParamsExecute
      OnUpdate = ActionCheckedArchiveParamsUpdate
    end
    object PlanSaveAll: TAction
      Category = 'PlanEdit'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnExecute = PlanSaveAllExecute
      OnUpdate = PlanSaveAllUpdate
    end
    object DesignArea: TAction
      Category = 'PlanEdit'
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnExecute = DesignAreaExecute
      OnUpdate = DesignAreaUpdate
    end
    object LoadPlan: TAction
      Category = 'PlanEdit'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1083#1072#1085
      OnExecute = LoadPlanExecute
      OnUpdate = LoadPlanUpdate
    end
  end
  object ImgPlanTree: TImageList
    Left = 568
    Top = 120
    Bitmap = {
      494C010109000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
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
      000000000000000000000000000000000000000000000000000000000000CDDE
      D400A3C7A700A7C3AA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C2E4CE006FC587003EAA
      54001D8C2C0026993C00B2E6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6E3C30042C96B001EB14600189F
      3400048015000D92270053DB8000C0E1CD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000076E29C004FD87C003BC262002AAD
      490018932D00158F2A002CB9540059D68200C9D4D800D8D0E400C3C9DD00ABB1
      DD00ADB4E100AAB1E000A6AEE200CCCFE1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000064EF950051D67A0040BA5B0030B0
      4C0041BB5F0043AF5D00118C270032C34E001D5295000F0FB7000718BF001527
      CD00162CDC00162BE700162DEF005067F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000028A6450004871D00089025001AA1
      390026B24D0042C76A0036A94D0009851E00072698000004B100000EB700000B
      C5000012D5000011E2000018ED002748F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008DB9670073B25C0062AA55004EAC
      51004DB65D004BC1670073E19800409C5F0000088D000007A8000006AD000009
      B900000EC8000010D3000924E7004F6CFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7DBC200FEDFAB00F3CE8E00DFC0
      8200D6B57B00CAAC7200BAA76C00B2A174005460CB004E62DC004B60DD004459
      E3003F54E9003D53ED004961F200677CF6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E6D6AF00DDC2
      8600D1AC6E00CB9F6000BF915000BE8A4200A5A0BF0088A1FF007D95FB006F88
      FC006079FB004963FF00455EFF007E8EF1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E5D3
      B000DFC59300D3AF7000C59D5B00B27F3200B48E63007687E900687EEF005D72
      EE005267EE004259F0007986EF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DAC8B000DDC5A400A2A1D100818AE200868E
      E1009B9EE0000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A6FFFF0082FFFF006DFFFF0062FF
      FF0055FFFF004BFFFF0041FFFF003BFFFF002FFFFF002AFFFF001CFFFF0019FF
      FF00AFF4F4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A6A6FF008282FF006D6DFF006262
      FF005555FF004B4BFF004141FF003B3BFF002F2FFF002A2AFF001C1CFF001919
      FF00BABAFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000079FEFE0044FEFE002CFEFE0015FE
      FE0006FEFE0001F4F40001E3E30001D8D80001C5C50001BBBB0001ABAB0002A1
      A10000BBBB00A0F4F4000000000000000000000000000000000000000000ABFF
      FF0062FFFF0064FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007A7AFF004545FF002D2DFF001616
      FF000707FF000202F5000202E4000202D9000202C6000202BC000202AC000404
      A3000000BB00ABABFF000000000000000000000000000000000000000000ABAB
      FF006262FF006464FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082FFFF0057FFFF0044FFFF002EFF
      FF001FFFFF0010FFFF0002FFFF0000F3F30000E6E60000D8D80001C4C40000C9
      C90004A6A60000CBCB00A4F4F4000000000000000000A4FFFF0029FFFF0000D3
      D300008E8E0000A8A80095FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000008282FF005757FF004444FF002E2E
      FF001F1FFF001010FF000202FF000000F3000000E6000000D8000101C4000000
      C9000606A8000000CB00AFAFFF000000000000000000A4A4FF002929FF000000
      D30000008E000000A8009595FF00000000000000000000000000000000000000
      0000000000000000000000000000000000008FFFFF005BFFFF0045FFFF0037FF
      FF0025FFFF0018FFFF0008FFFF0000F9F90000EAEA0000DEDE0000CBCB0001D2
      D20000C0C00002BFBF0000ECEC00BDFAFA0094FFFF0000FAFA0000B9B900009D
      9D00006666000084840020FFFF00A0FFFF000000000000000000000000000000
      0000000000000000000000000000000000008F8FFF005B5BFF004545FF003737
      FF002525FF001818FF000808FF000000F9000000EA000000DE000000CB000101
      D2000000C0000303C0000000EC00C2C2FF009494FF000000FA000000B9000000
      9D0000006600000084002020FF00A0A0FF000000000000000000000000000000
      00000000000000000000000000000000000093FFFF006DFFFF005AFFFF003BFF
      FF0031FFFF0021FFFF0009FFFF0000F2F20000F0F00000E2E20000D1D10000DC
      DC0001C4C40000CCCC0002E9E900A6FFFF004FFFFF0019FFFF0000EAEA0000C0
      C00000909000008A8A0000D1D10022FFFF00A4FFFF00B4FFFF009CFFFF007DFF
      FF0082FFFF007EFFFF007BFFFF00A9FFFF009393FF006D6DFF005A5AFF003B3B
      FF003131FF002121FF000909FF000000F2000000F0000000E2000000D1000000
      DC000101C4000000CC000303EA00A6A6FF004F4FFF001919FF000000EA000000
      C0000000900000008A000000D1002222FF00A4A4FF00B4B4FF009C9CFF007D7D
      FF008282FF007E7EFF007B7BFF00A9A9FF008EFFFF006BFFFF0061FFFF0044FF
      FF0036FFFF0027FFFF0014FFFF000DFFFF0000FEFE0000EEEE0000D9D90000F2
      F20000DADA0001D7D70000F8F800B2FFFF0047FFFF0017FFFF0000E4E40000C8
      C80000E8E80000E0E0000083830000D8D80000AEAE00008E8E000094940000B1
      B10000BFBF0000C6C60000CCCC001CFFFF008E8EFF006B6BFF006161FF004444
      FF003636FF002727FF001414FF000D0DFF000000FE000000EE000000D9000000
      F2000000DA000101D7000000F800B2B2FF004747FF001717FF000000E4000000
      C8000000E8000000E000000083000000D8000000AE0000008E00000094000000
      B1000000BF000000C6000000CC001C1CFF008FFFFF0067FFFF0054FFFF0048FF
      FF0033FFFF0029FFFF001DFFFF0011FFFF0002FFFF0000F4F40000E2E20001FF
      FF0000ECEC0000E4E40007FFFF00B4FFFF0000B8B80000707000007E7E0000A3
      A30000C4C40000F8F80000C8C80000737300008484000079790000848400008B
      8B00009A9A0000A2A20000AEAE0000F0F0008F8FFF006767FF005454FF004848
      FF003333FF002929FF001D1DFF001111FF000202FF000000F4000000E2000101
      FF000000EC000000E4000707FF00B4B4FF000000B8000000700000007E000000
      A3000000C4000000F8000000C800000073000000840000007900000084000000
      8B0000009A000000A2000000AE000000F0008FFFFF0068FFFF0058FFFF004BFF
      FF0039FFFF002DFFFF0021FFFF0010FFFF0005FFFF0000F8F80000E0E00007FF
      FF0000F1F10000ECEC000EFFFF00B4FFFF001FFFFF0002FFFF0000ECEC0000DD
      DD0000EBEB0000F8F80049FFFF0000D2D2000063630000757500007777000082
      8200008F8F000098980000B8B80025FFFF008F8FFF006868FF005858FF004B4B
      FF003939FF002D2DFF002121FF001010FF000505FF000000F8000000E0000707
      FF000000F1000000EC000E0EFF00B4B4FF001F1FFF000202FF000000EC000000
      DD000000EB000000F8004949FF000000D2000000630000007500000077000000
      820000008F00000098000000B8002525FF008EFFFF0067FFFF0056FFFF004FFF
      FF0041FFFF0031FFFF0021FFFF0010FFFF0009FFFF0000FFFF0000E0E0001BFF
      FF0000FAFA0000F0F00019FFFF00B4FFFF00B9FFFF00B1FFFF008BFFFF006DFF
      FF005BFFFF0047FFFF0035FFFF0031FFFF0001FFFF0009FFFF0007FFFF0001FF
      FF0000FEFE0000FEFE0014FFFF003DFFFF008E8EFF006767FF005656FF004F4F
      FF004141FF003131FF002121FF001010FF000909FF000000FF000000E0001B1B
      FF000000FA000000F0001919FF00B4B4FF00B9B9FF00B1B1FF008B8BFF006D6D
      FF005B5BFF004747FF003535FF003131FF000101FF000909FF000707FF000101
      FF000000FE000000FE001414FF003D3DFF0090FEFE006FFFFF0061FFFF0051FF
      FF003DFFFF0030FFFF0024FFFF0019FFFF0007FFFF0000FCFC0000DADA0014FF
      FF0001FFFF0000F9F9001DFFFF00B8FFFF0000000000000000009EFFFF006FFF
      FF0049FFFF0033FFFF0017FFFF0008FFFF0059FFFF0071FFFF005FFFFF004EFF
      FF0039FFFF001EFFFF0018FFFF0055FFFF009191FF006F6FFF006161FF005151
      FF003D3DFF003030FF002424FF001919FF000707FF000000FC000000DA001414
      FF000101FF000000F9001D1DFF00B8B8FF0000000000000000009E9EFF006F6F
      FF004949FF003333FF001717FF000808FF005959FF007171FF005F5FFF004E4E
      FF003939FF001E1EFF001818FF005555FF008DFFFF0071FEFE006FFEFE005BFF
      FF004DFFFF0043FFFF003AFFFF0030FFFF001DFFFF0019FFFF0012FFFF0081FF
      FF001CFFFF0000F2F20021FFFF00BAFFFF000000000000000000000000009CFF
      FF007BFFFF004DFFFF002AFFFF0000EDED001AFFFF0045FFFF003AFFFF002AFF
      FF001BFFFF0009FFFF004BFFFF00000000008D8DFF007272FF007070FF005B5B
      FF004D4DFF004343FF003A3AFF003030FF001D1DFF001919FF001212FF008181
      FF001C1CFF000000F2002121FF00BABAFF000000000000000000000000009C9C
      FF007B7BFF004D4DFF002A2AFF000000ED001A1AFF004545FF003A3AFF002A2A
      FF001B1BFF000909FF004B4BFF0000000000B5F6F60062FFFF0035FFFF003AFE
      FE0038FFFF0039FFFF003DFFFF0036FFFF0033FFFF0035FFFF0041FFFF0070FF
      FF004DFFFF000CFFFF001FFFFF00BCFFFF000000000000000000000000000000
      00000000000000000000000000008DFFFF0085FFFF0064FFFF004AFFFF004FFF
      FF0067FFFF00000000000000000000000000BEBEFF006262FF003535FF003B3B
      FF003838FF003939FF003D3DFF003636FF003333FF003535FF004141FF007070
      FF004D4DFF000C0CFF001F1FFF00BCBCFF000000000000000000000000000000
      00000000000000000000000000008D8DFF008585FF006464FF004A4AFF004F4F
      FF006767FF0000000000000000000000000000000000CFEDED007EF8F80047FF
      FF003DFFFF0039FFFF0031FFFF0027FFFF0017FFFF0009FFFF0000F4F40000E6
      E60010FFFF0036FFFF0021FFFF00B6FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1E1FF008585FF004747
      FF003D3DFF003939FF003131FF002727FF001717FF000909FF000000F4000000
      E6001010FF003636FF002121FF00B6B6FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C4F4
      F4009DFEFE009DFEFE009CFFFF0095FFFF0089FFFF007BFFFF0073FFFF006CFF
      FF005DFFFF0067FFFF006CFFFF00C6FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CFCF
      FF009E9EFF009E9EFF009C9CFF009595FF008989FF007B7BFF007373FF006C6C
      FF005D5DFF006767FF006C6CFF00C6C6FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EBEFEF00E6EFEF00E9EFEF00E8EFEF00EAEFEF00E1EFEF00E3EFEF00DFEF
      EF00E1EFEF00DAEFEF00D0EEEE00E7EFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFF00F6F6FF00F9F9FF00F8F8FF00FAFAFF00F1F1FF00F3F3FF00EFEF
      FF00F1F1FF00EAEAFF00E1E1FF00F7F7FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4B4B400B0B0B000ADADAD00ACAC
      AC00AAAAAA00A9A9A900A7A7A700A7A7A700A5A5A500A5A5A500A3A3A300A3A3
      A300C1C1C1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECD7B500DFCA9800DAC08800D7B9
      8100D4B27800D1AD7100CBA96B00CBA36800C79F5F00C8995C00C3915400BD93
      5400D9DDCD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AEAEAE00A8A8A800A5A5A500A2A2
      A200A0A0A0009E9E9E009C9C9C009B9B9B009898980097979700959595009595
      950097979700C0C0C0000000000000000000000000000000000000000000B5B5
      B500ACACAC00ACACAC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DFC68D00D1AF6400C9A25400C397
      4300BF8F3800B9882D00B3802300B0791C00AA6E1100A7670A00A25D01009958
      03008F642500D3D6C0000000000000000000000000000000000000000000CDDE
      D400A3C7A700A7C3AA0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0B0B000AAAAAA00A8A8A800A5A5
      A500A3A3A300A1A1A100A0A0A0009E9E9E009C9C9C009A9A9A00989898009999
      99009696960099999900C0C0C0000000000000000000B4B4B400A4A4A4009A9A
      9A009191910094949400B2B2B200000000000000000000000000000000000000
      000000000000000000000000000000000000E1CA9700D8B67200D1AE6500CBA3
      5500C69B4B00C4943E00C08C3500B9862D00B77C2500B1751D00AA6B0F00A56C
      1C00845A1B009F6E2300D9DABD000000000000000000C2E4CE006FC587003EAA
      54001D8C2C0026993C00B2E6C600000000000000000000000000000000000000
      000000000000000000000000000000000000B1B1B100ABABAB00A8A8A800A6A6
      A600A4A4A400A2A2A200A0A0A0009F9F9F009D9D9D009B9B9B00999999009A9A
      9A0098989800989898009D9D9D00BCBCBC00B2B2B2009F9F9F00979797009393
      93008C8C8C0090909000A3A3A300B3B3B3000000000000000000000000000000
      000000000000000000000000000000000000E7D09E00DABA7300D4AE6300CFA7
      5A00C99F4E00C7964500C1913800BE892E00B9812500B77B1B00AF6F1200A973
      1E00946725009E681800BA7E2900EDE3CD00B6E3C30042C96B001EB14600189F
      3400048015000D92270053DB8000C0E1CD000000000000000000000000000000
      000000000000000000000000000000000000B2B2B200ADADAD00ABABAB00A7A7
      A700A6A6A600A3A3A300A1A1A1009E9E9E009D9D9D009C9C9C009A9A9A009B9B
      9B0098989800999999009E9E9E00B4B4B400A9A9A900A2A2A2009D9D9D009898
      980092929200919191009A9A9A00A4A4A400B4B4B400B6B6B600B3B3B300AFAF
      AF00B0B0B000AFAFAF00AFAFAF00B5B5B500E6D2A300DEC28100DCB97000D3AA
      5A00CEA75300C99D4900C4913700BF862500BD852500B67E1E00B2780F00AD78
      2400956B2500A5701D00BA7E2700EED5B50076E29C004FD87C003BC262002AAD
      490018932D00158F2A002CB9540059D68200FFA4A400FFB4B400FF9C9C00FF7D
      7D00FF828200FF7E7E00FF7B7B00FFA9A900B1B1B100ADADAD00ACACAC00A8A8
      A800A6A6A600A4A4A400A2A2A200A1A1A1009F9F9F009D9D9D009B9B9B009E9E
      9E009B9B9B009A9A9A009F9F9F00B6B6B600A8A8A800A2A2A2009C9C9C009999
      99009C9C9C009B9B9B00909090009A9A9A009595950091919100929292009696
      9600979797009898980099999900A3A3A300E5CEA000E0C17E00DDBB7800D6AD
      6100D0A95600CEA24900C7973E00C7933800C48C2C00BD872100B87D1000BA85
      2B00A2762F00AA742300BF882D00F3DCBB0064EF950051D67A0040BA5B0030B0
      4C0041BB5F0043AF5D00118C270032C34E00AE0000008E00000094000000B100
      0000BF000000C6000000CC000000FF1C1C00B1B1B100ACACAC00AAAAAA00A8A8
      A800A6A6A600A4A4A400A3A3A300A2A2A200A0A0A0009E9E9E009C9C9C009F9F
      9F009D9D9D009C9C9C00A0A0A000B6B6B600969696008E8E8E008F8F8F009494
      9400989898009E9E9E00999999008E8E8E00909090008F8F8F00909090009191
      91009393930094949400959595009E9E9E00E6CEA100DFBF7B00D8B76D00D7B1
      6200CFA75500CFA24A00CB9B4300C7973A00C5902C00C08B2200BC831300BF8F
      3100AA803700B17D2800C68E3400F4DDBB0028A6450004871D00089025001AA1
      390026B24D0042C76A0036A94D0009851E008400000079000000840000008B00
      00009A000000A2000000AE000000F0000000B1B1B100ACACAC00AAAAAA00A9A9
      A900A7A7A700A5A5A500A3A3A300A1A1A100A0A0A0009E9E9E009C9C9C00A0A0
      A0009E9E9E009D9D9D00A1A1A100B6B6B600A3A3A300A0A0A0009D9D9D009B9B
      9B009D9D9D009E9E9E00A9A9A9009A9A9A008C8C8C008E8E8E008E8E8E009090
      9000919191009292920097979700A4A4A400E5CFA100DFC07B00D9B97000D7B3
      6500D1A95A00CFA44F00CD9D4500C7963900C7912E00C28C2500BA811500C192
      3600AB823C00B3832B00C6953800F3DDBD008DB9670073B25C0062AA55004EAC
      51004DB65D004BC1670073E19800409C5F006300000075000000770000008200
      00008F00000098000000B8000000FF252500B1B1B100ACACAC00AAAAAA00A9A9
      A900A8A8A800A5A5A500A4A4A400A1A1A100A1A1A1009F9F9F009B9B9B00A3A3
      A3009F9F9F009D9D9D00A2A2A200B6B6B600B7B7B700B6B6B600B1B1B100ADAD
      AD00ABABAB00A8A8A800A6A6A600A5A5A5009F9F9F00A1A1A100A0A0A000A0A0
      A0009F9F9F009F9F9F00A2A2A200A7A7A700E5CEA000E0BF7A00D8B86F00D7B2
      6B00D5AD5E00CEA75200CC9F4500C6993700C8943000C2902C00BB811300C69C
      4500AF874000B4842F00CD993D00F3DDBC00F7DBC200FEDFAB00F3CE8E00DFC0
      8200D6B57B00CAAC7200BAA76C00B2A17400FF010100FF090900FF070700FF01
      0100FE000000FE000000FF141400FF3D3D00B2B2B200ADADAD00ABABAB00AAAA
      AA00A7A7A700A5A5A500A4A4A400A3A3A300A0A0A0009F9F9F009B9B9B00A2A2
      A200A0A0A0009F9F9F00A3A3A300B6B6B6000000000000000000B3B3B300ADAD
      AD00A8A8A800A6A6A600A2A2A200A0A0A000ABABAB00AEAEAE00ABABAB00A9A9
      A900A7A7A700A3A3A300A2A2A200AAAAAA00E5D1A100DFC38300DBBC7800D9B3
      6C00D4AB5B00CEA65200CDA14600C99D3E00C7922F00C38D2A00B8800F00C397
      4200B48D3F00BA8A3100CD9C4000F5E0BE000000000000000000E6D6AF00DDC2
      8600D1AC6E00CB9F6000BF915000BE8A4200FF595900FF717100FF5F5F00FF4E
      4E00FF393900FF1E1E00FF181800FF555500B1B1B100AEAEAE00ADADAD00ABAB
      AB00A9A9A900A8A8A800A7A7A700A5A5A500A3A3A300A3A3A300A2A2A200B0B0
      B000A3A3A3009E9E9E00A3A3A300B7B7B700000000000000000000000000B3B3
      B300AFAFAF00A9A9A900A5A5A5009D9D9D00A3A3A300A8A8A800A7A7A700A5A5
      A500A3A3A300A0A0A000A9A9A90000000000E2D29E00DDC48600DFC28300D8BA
      7400D7B26800D4AE6100D4AA5700D0A65000CB9E4100CD993E00C9973900E1CA
      9500BB985500B9872B00CF9E4200F4DFC300000000000000000000000000E5D3
      B000DFC59300D3AF7000C59D5B00B27F3200B48E6300FF454500FF3A3A00FF2A
      2A00FF1B1B00FF090900FF4B4B0000000000C0C0C000ACACAC00A6A6A600A8A8
      A800A6A6A600A6A6A600A7A7A700A6A6A600A6A6A600A6A6A600A8A8A800ADAD
      AD00A9A9A900A1A1A100A3A3A300B7B7B7000000000000000000000000000000
      0000000000000000000000000000B1B1B100B0B0B000ACACAC00A9A9A900A9A9
      A900ACACAC00000000000000000000000000E2E1CB00D5B88400C8A36200C4A8
      6800C6A46800C5A66700C8A96800C6A56400C6A36200C6A36500C6A97100D4BF
      9300CBAC7A00BF923F00D09D4000F3E0C6000000000000000000000000000000
      0000000000000000000000000000DAC8B000DDC5A400FF646400FF4A4A00FF4F
      4F00FF67670000000000000000000000000000000000D7D7D700B6B6B600A8A8
      A800A7A7A700A6A6A600A5A5A500A4A4A400A2A2A200A0A0A0009E9E9E009C9C
      9C00A1A1A100A6A6A600A3A3A300B6B6B6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1E9E100D1C7A000D1AD
      6A00C9A86800CAA66300C8A45B00C79D5500C1974800BF903C00B8892D00B582
      2200C1954000CDA65C00CE9F4200F3DDBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600B3B3B300B3B3B300B3B3B300B2B2B200B1B1B100AFAFAF00AEAEAE00ADAD
      AD00ABABAB00ACACAC00ADADAD00B8B8B8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E8EB
      D100EBD6AA00EBD3AB00ECD4A800ECD1A100E7CC9900E4C68D00E3C48400E0C1
      7F00DEB87400DFBD7C00E2C07E00F4E8CB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D6D6D600D6D6D600D6D6
      D600D6D6D600D5D5D500D4D4D400D7D7D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F600F5F4EE00F6F5F400F6F7F000F7F7F200EFF4EC00F2F6EB00F2F1
      E900F3F2EB00F0EFE300EAEADA00F1F7F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF000000000000FFFF000000000000
      E3FF00000000000081FF00000000000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      C000000000000000E001000000000000FE07000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FFFFFFFFFFFFFFFF0007FFFF0007FFFF
      0003E3FF0003E3FF000181FF000181FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0000000C0000000E0010000E0010000FE070000FE078000FFFF8000FFFF
      E000FFFFE000FFFFF000FFFFF000FFFFFFFFFFFFFFFFFFFF0007FFFF0007FFFF
      0003E3FF0003E3FF000181FF000181FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0000000C0000000E0010000E0010000FE070000FE078000FFFF8000FFFF
      E000FFFFE000FFFFF000FFFFF000FFFF00000000000000000000000000000000
      000000000000}
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      #1055#1086#1082#1072#1079#1072#1090#1100
      'Menus'
      'Default')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    LookAndFeel.Kind = lfUltraFlat
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseSystemFont = True
    Left = 496
    Top = 160
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      AllowQuickCustomizing = False
      Caption = 'Main Menu'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 0
      FloatTop = 0
      FloatClientWidth = 87
      FloatClientHeight = 41
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarSettings'
        end
        item
          Visible = True
          ItemName = 'N1'
        end>
      MultiLine = True
      OldName = 'Main Menu'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarBtnAnalog: TdxBarButton
      Caption = #1052#1085#1077#1084#1086#1089#1093#1077#1084#1099
      Category = 0
      Hint = #1052#1085#1077#1084#1086#1089#1093#1077#1084#1099
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = dxBarBtnAnalogClick
    end
    object dxBarBtnArchive: TdxBarButton
      Caption = #1040#1088#1093#1080#1074' '#1074#1099#1073#1088#1072#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      Category = 0
      Hint = #1040#1088#1093#1080#1074' '#1074#1099#1073#1088#1072#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = dxBarBtnArchiveClick
    end
    object dxBarBtnReports: TdxBarButton
      Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1080
      Category = 0
      Hint = #1042#1077#1076#1086#1084#1086#1089#1090#1080
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = dxBarBtnReportsClick
    end
    object dxBarShowAlertArchive: TdxBarButton
      Action = AlertArchive
      Category = 0
    end
    object N1: TdxBarButton
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' ...'
      Category = 1
      Visible = ivAlways
      OnClick = N1Click
    end
    object dxBarSettings: TdxBarButton
      Action = ActionSettings
      Category = 1
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnAnalog'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnArchive'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnReports'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarShowAlertArchive'
        end>
    end
  end
  object ImgPageControl: TImageList
    Height = 24
    Width = 24
    Left = 368
    Top = 248
    Bitmap = {
      494C010105000900040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000480000000100200000000000006C
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
      0000000000000000000000000000000000000000000000000000000000000000
      00006161FF000000A000000080000000A0000000A6000000A00000009B000000
      80000000700000006000000050000000400000002000000050000000A0006161
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000B0000000E6001111FF000707FF000000F0000000A000000090000000
      9000000090000000900000006000000060000000500000004000000060000000
      B000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D1D1FF000000E0000000C0000000F0000000D6000000C6000000C6000000
      D0000000C6000000E0000000700000004B00000060000000A0000000E000D1D1
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E1E1FF003131FF001111FF000000A000000080000000
      8B000000800000008B00000070007171FF00B1B1FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B9B9FF00B1B1FF00B1B1FF00B1B1
      FF00B1B1FF00B1B1FF00B9B9FF00C9C9FF00E1E1FF000000800000004B000000
      5000000050000000500000006000C1C1FF00C1C1FF00B9B9FF00B9B9FF00B9B9
      FF00B9B9FF00B9B9FF00B9B9FF00D1D1FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E0000000E0000000E0000000
      E0000000E0000000E0000000E0000000E0000000E0000000E0000000E0000000
      E0000000E0000000E0000000E0000000E0000000E0000000E0000000E0000000
      E0000000E0000000E0000000E0009191FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF00C1C1FF00C1C1
      FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1
      FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1
      FF00C1C1FF00C1C1FF000000E0007171FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6000000
      C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000
      C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000
      C6000000C600C1C1FF000000E0007979FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6004141
      FF003737FF003131FF002C2CFF002C2CFF002C2CFF002C2CFF002727FF002727
      FF005151FF007777FF007777FF007777FF007777FF007777FF007777FF007777
      FF000000C600C1C1FF000000E0007979FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002C2C
      FF002727FF002121FF001C1CFF001C1CFF001C1CFF001C1CFF002121FF005151
      FF006161FF005C5CFF005C5CFF005C5CFF005C5CFF005C5CFF006161FF006161
      FF000000C600C1C1FF000000E0007F7FFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6001C1C
      FF001717FF001111FF001111FF001111FF000C0CFF002121FF004747FF004C4C
      FF004C4CFF004C4CFF004C4CFF004C4CFF004C4CFF004C4CFF004C4CFF005757
      FF000000C600C1C1FF000000E0007979FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6001111
      FF001111FF001111FF000C0CFF000101FF001111FF003737FF003C3CFF003737
      FF003C3CFF003C3CFF003C3CFF003C3CFF003C3CFF004141FF004141FF004C4C
      FF000000C600C1C1FF000000E0007777FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6001111
      FF000101FF000101FF000101FF000101FF002727FF002929FF002727FF002929
      FF002929FF002929FF002929FF002C2CFF002C2CFF003434FF003434FF003C3C
      FF000000C600C1C1FF000000E0007171FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002929
      FF001717FF000101FF000000F6000C0CFF001717FF001717FF001717FF001717
      FF002121FF002121FF002121FF002121FF002121FF002121FF002727FF001717
      FF000000C600C1C1FF000000E0007777FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002929
      FF002C2CFF002C2CFF002727FF001717FF000707FF000707FF000101FF000707
      FF000707FF000C0CFF001717FF001717FF001717FF001717FF001717FF000000
      FB000000C600C1C1FF000000E0007171FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002929
      FF002C2CFF003737FF004141FF004747FF005151FF005F5FFF005F5FFF005F5F
      FF005757FF004C4CFF004444FF003C3CFF003434FF002C2CFF002121FF001717
      FF000000C600C1C1FF000000E0007171FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002929
      FF002C2CFF003737FF004141FF004747FF005151FF005F5FFF005F5FFF005F5F
      FF005757FF004C4CFF004444FF003C3CFF003434FF002C2CFF002121FF001717
      FF000000C600C1C1FF000000E0007979FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002929
      FF002C2CFF003F3FFF004444FF004C4CFF005151FF005757FF005F5FFF006767
      FF006F6FFF007777FF007F7FFF008989FF008989FF009191FF009999FF009E9E
      FF000000C600C1C1FF000000E0008181FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6002C2C
      FF003131FF003F3FFF004444FF004C4CFF005151FF005757FF005F5FFF006161
      FF006969FF007171FF007777FF007C7CFF008181FF008686FF009191FF009999
      FF000000C600C1C1FF000000E0008181FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6003434
      FF003C3CFF004747FF005151FF005757FF005F5FFF006161FF006969FF007171
      FF007777FF007F7FFF008686FF008989FF009191FF009999FF00A1A1FF00A9A9
      FF000000C600C1C1FF000000E0008181FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF000000C6000000
      C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000
      C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000
      C6000000C600C1C1FF000000E0007979FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E000C1C1FF00C1C1FF00C1C1
      FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1
      FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1FF00C1C1
      FF00C1C1FF00C1C1FF000000E0007171FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E0000000E0000000E0000000
      E0000000E0000000E0000000E0000000E0000000E0000000E0000000E0000000
      E0000000E0000000E0000000E0000000E0000000E0000000E0000000E0000000
      E0000000E0000000E0000000E0008181FF000000000000000000000000000000
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
      0000FCFCFC00F4F4F400F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F4F4F400FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B0B0B0005050500040404000505050005850500050505000504850004040
      400038383800303030002828280020202000101010002828280050505000B0B0
      B000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0D8C800E0C8C000C8B0A000C8988800C8988800C898
      8800C8988800C8988800C8988800C8988800D8C0B800F8E8E000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F4F4F400E2E2E200D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800E2E2E200F4F4F40000000000000000000000000000000000000000000000
      000061FFFF0000A0A0000080800000A0A00000A6A60000A0A000009B9B000080
      800000707000006060000050500000404000002020000050500000A0A00061FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000585858007870700088888800888080007878780050505000484848004848
      4800484848004848480030303000303030002828280020202000303030005858
      580000000000000000000000000000000000000000000000000000000000F0E0
      D800C0A0A000C0806000C0806000C0684000C8683800C8683800D0784000D078
      4800D8784800D0784800D0784000C8784800B8684000C0684000C8784800C8B0
      A000F0E0D8000000000000000000000000000000000000000000000000000000
      0000BE801000BE801000BE801000BE801000BE801000BE801000BE801000BE80
      1000BE801000BE801000BE801000BE801000BE801000BE801000BE801000BE80
      1000D8D8D800F2F2F20000000000000000000000000000000000000000000000
      000000B0B00000E6E60011FFFF0007FFFF0000F0F00000A0A000009090000090
      90000090900000909000006060000060600000505000004040000060600000B0
      B000000000000000000000000000000000000000000000000000000000000000
      0000E8E8E8007070700060606000787878007068680068606000686060006868
      680068606000707070003838380028202800303030005050500070707000E8E8
      E800000000000000000000000000000000000000000000000000E8E0E000A068
      40008840280098402000B0502800C0583000D0683800D0703800D8784800E088
      5000E8905800E8905800E8885000E0885000D8804800D8784800C8683800B858
      2800C0806000F0E0D80000000000000000000000000000000000000000000000
      0000D6AA6000F8D09000F8D09000F8D09000F0CC8C00F0CC8C00F8D09000F8D0
      9000F8D09000F8D09000F8D09000F8D09000F8D09000F8D09000F8D09000BE80
      1000D8D8D800F2F2F20000000000000000000000000000000000000000000000
      0000D1FFFF0000E0E00000C0C00000F0F00000D6D60000C6C60000C6C60000D0
      D00000C6C60000E0E00000707000004B4B000060600000A0A00000E0E000D1FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0F0F000989898008888880050505000404040004840
      4800404040004840480038383800B8B8B800D8D8D80000000000000000000000
      0000000000000000000000000000000000000000000000000000703820007030
      180088402000A8502800B0583000C0583000C8683800D8703800E0784000E080
      4800E8884800E8885000E8885000E8885000F0986000E8905800E0804800D078
      4000C8683800A858300000000000000000000000000000000000000000000000
      0000D6AA6000ECC88C00FCE0B400F8DCAC00ECCC9C00ECCC9C00F8DCAC00FCE0
      B000F8DCAC00F8D8A800F8D8A800F8D8A800F8D8A800F8DCAC00ECC48800BE80
      1000D8D8D800F2F2F20000000000000000000000000000000000000000000000
      00000000000000000000E1FFFF0031FFFF0011FFFF0000A0A00000808000008B
      8B0000808000008B8B000070700071FFFF00B1FFFF0000000000000000000000
      000000000000000000000000000000000000DCDCDC00D8D8D800D8D8D800D8D8
      D800D8D8D800D8D8D800DCDCDC00E4E4E400F0F0F00040404000282028002828
      2800282828002828280030303000E0E0E000E0E0E000DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00E8E8E8000000000000000000602818007838
      20008838200098402000A8482000C0583000D8784800E8906000F0A07800F8B0
      8000F8B88800F8B88000F8B07800F8986000F0985800F8985800F0885000E080
      4800E0804800A850280000000000000000000000000000000000000000000000
      0000D6AA6000ECC88C00FCE0B4000C0C0C000C0C0C00ECCC9C00F8DCAC00F8DC
      B000F0D4A400ECD0A000ECD0A000ECD0A000ECD0A000F0D4A400E8C48800BE80
      1000D8D8D800F2F2F2000000000000000000B9FFFF00B1FFFF00B1FFFF00B1FF
      FF00B1FFFF00B1FFFF00B9FFFF00C9FFFF00E1FFFF0000808000004B4B000050
      5000005050000050500000606000C1FFFF00C1FFFF00B9FFFF00B9FFFF00B9FF
      FF00B9FFFF00B9FFFF00B9FFFF00D1FFFF007070700070707000707070007070
      7000707070007070700070707000707070007070700070707000707070007070
      7000707070007070700070707000707070007070700070707000707070007070
      7000707070007070700070707000C8C8C8000000000000000000582810007030
      1800A0482800D8805000E8A88000F8D0B000F8E0D000E8E0E000F0E8E800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8E8E000FFE0C000FFC08800F090
      5800E0804800A850280000000000000000000000000000000000000000000000
      0000D6AA6000ECC88C00FCE4B800FCE0B400F8DCB000F8DCB000FCE0B400FCE4
      B800FCE4B800FCE4B800FCE4B800FCE4B800FCE4B800FCE4B800ECC88C00BE80
      1000D8D8D800F2F2F200000000000000000000E0E00000E0E00000E0E00000E0
      E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0
      E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0
      E00000E0E00000E0E00000E0E00091FFFF0070707000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E00070707000B8B8B800000000000000000060281800D078
      4800F0986000E0986000C0806000B0684000B0684000B0684000B8684000C068
      4000C8784800C8784800C0806000C0806000C0806000C8B0A000E0C0A000F8C0
      8800F8A06000B050280000000000000000000000000000000000000000000000
      0000D6AA6000ECC88C00FCE4B800FCE0B400F8DCB000F8DCB000FCE0B400FCE4
      B800FCE4B800FCE4B800FCE4B800FCE4B800FCE4B800FCE4B800ECC88C00BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF00C1FFFF00C1FF
      FF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FF
      FF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FF
      FF00C1FFFF00C1FFFF0000E0E00071FFFF0070707000E0E0E000986828009868
      2800986828009868280098682800986828009868280098682800986828009868
      2800986828009868280098682800986828009868280098682800986828009868
      280098682800E0E0E00070707000BCBCBC000000000000000000783820007830
      180098402000A8502800B8583000C8683800D8704000E0804800E8905800F098
      6000F8A86800F8A87000F8A87000F8A06800F8A06000F0885000F0885000E888
      5000D8784800B058300000000000000000000000000000000000000000000000
      0000D6AA6000ECC88C00FCE4B800F8DCB000ECD0A000ECD0A000F8DCB000FCE0
      B800F8DCB000F4DCB000F4DCB000F4DCB000F4DCB000F8DCB000ECC88C00BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60000C6
      C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6
      C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6
      C60000C6C600C1FFFF0000E0E00079FFFF0070707000E0E0E00098682800D0B0
      6000C8A86000C8A85800C8A05800C8A05800C8A05800C8A05800C0A05800C0A0
      5800D0B07800E0C09000E0C09000E0C09000E0C09000E0C09000E0C09000E0C0
      900098682800E0E0E00070707000BCBCBC000000000000000000783820007830
      180098402000A8502800B8583000C8683800D8704000E0804800E8905800F098
      6000F8A86800F8A87000F8A87000F8A06800F8A06000F0885000F0885000E888
      5000D8784800B058300000000000000000000000000000000000000000000000
      0000D6AA6000ECC89000FCE4BC000C0C0C000C0C0C00ECD0A000F8DCB400FCE0
      B400F0D4A800ECD0A000ECD0A000ECD0A000ECD0A000F0D4A800E8C88C00BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60041FF
      FF0037FFFF0031FFFF002CFFFF002CFFFF002CFFFF002CFFFF0027FFFF0027FF
      FF0051FFFF0077FFFF0077FFFF0077FFFF0077FFFF0077FFFF0077FFFF0077FF
      FF0000C6C600C1FFFF0000E0E00079FFFF0070707000E0E0E00098682800C8A0
      5800C0A05800C0985800C0985000C0985000C0985000C0985000C0985800D0B0
      7800D8B88000D8B08000D8B08000D8B08000D8B08000D8B08000D8B08800D8B0
      880098682800E0E0E00070707000C0C0BC000000000000000000602810009048
      280098482800A8502800B8583000C0583000D0683800E0784000E8884800F098
      5800F8A06000F8A06800F8A06000F8A06000F0985800E8885000E0804000E888
      5000E8885000A850280000000000000000000000000000000000000000000000
      0000D6AA6000ECD09800FCE4BC000C0C0C000C0C0C00F8DCB400FCE4BC007474
      74007474740074747400747474007474740074747400F8DCB400ECC88C00BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C6002CFF
      FF0027FFFF0021FFFF001CFFFF001CFFFF001CFFFF001CFFFF0021FFFF0051FF
      FF0061FFFF005CFFFF005CFFFF005CFFFF005CFFFF005CFFFF0061FFFF0061FF
      FF0000C6C600C1FFFF0000E0E0007FFFFF0070707000E0E0E00098682800C098
      5000B8985000B8905000B8905000B8905000B8904800C0985800D0A87000D0A8
      7800D0A87800D0A87800D0A87800D0A87800D0A87800D0A87800D0A87800D0B0
      800098682800E0E0E00070707000BCBCBC000000000000000000683018008840
      280098402000A8482800B8583000D0704800E0885800E8A07800F8B88800FFC8
      9000FFC89800FFC89800FFC08800FFB88000F8A86800F0885000E0703800D870
      3800E8885000A850280000000000000000000000000000000000000000000000
      0000D6AA6000F0D8AC00FCE8C400FCE4BC00F8E0B800F8E0B800FCE4BC00FCE8
      C000FCE8C000FCE8C000FCE8C000FCE8C000FCE8C000FCE8C000ECC89000BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C6001CFF
      FF0017FFFF0011FFFF0011FFFF0011FFFF000CFFFF0021FFFF0047FFFF004CFF
      FF004CFFFF004CFFFF004CFFFF004CFFFF004CFFFF004CFFFF004CFFFF0057FF
      FF0000C6C600C1FFFF0000E0E00079FFFF0070707000E0E0E00098682800B890
      5000B8905000B8905000B8904800B0884800B8905000C8A06800C8A07000C8A0
      6800C8A07000C8A07000C8A07000C8A07000C8A07000C8A87000C8A47400D0A8
      780098682800E0E0E00070707000BCBCB800000000000000000068301800A858
      3800D0784800E8A06800F8C08800F8D09800E8D0C000E8D0C000F0E8E800F8F0
      F000F8F0F000F8F0F000F8F8F800E8E0E000F0E8E800F8E0D000F8D0B000F0A0
      6800E8885000A850280000000000000000000000000000000000000000000000
      0000D6AA6000F4DCB400FEECCE00F8E0B800E8D0A400E8D0A400F8E0B800FCE4
      C000F8E0B800F4DCB400F4DCB400F4DCB400F4DCB400F8E0B800ECC89000BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60011FF
      FF0011FFFF0011FFFF000CFFFF0001FFFF0011FFFF0037FFFF003CFFFF0037FF
      FF003CFFFF003CFFFF003CFFFF003CFFFF003CFFFF0041FFFF0041FFFF004CFF
      FF0000C6C600C1FFFF0000E0E00077FFFF0070707000E0E0E00098682800B890
      5000B0884800B0884800B0884800B0884800C0986000C0986400C0986000C098
      6400C0986400C0986400C0986400C0986800C0986800C49C6C00C49C6C00C8A0
      700098682800E0E0E00070707000B8B8B800000000000000000078382000F090
      5800D0784800B0684000A0684000A0604000A0604000A8603800B0603800B068
      4000B0684000B0684000B0684000B0684000B0684000C0806000C8988800E0A0
      8000F8B07000A850280000000000000000000000000000000000000000000000
      0000D6AA6000F4DCB800FCF0D8003C3C3C0014141400ECD0A800F8E0B800FCE4
      BC00F0D8B000ECD0A800ECD0A800ECD0A800ECD0A800F0D8B000ECC89000BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60011FF
      FF0001FFFF0001FFFF0001FFFF0001FFFF0027FFFF0029FFFF0027FFFF0029FF
      FF0029FFFF0029FFFF0029FFFF002CFFFF002CFFFF0034FFFF0034FFFF003CFF
      FF0000C6C600C1FFFF0000E0E00071FFFF0070707000E0E0E00098682800C098
      6400B8905800B0884800B0804000B8885000B8905800B8905800B8905800B890
      5800BC946000BC946000BC946000BC946000BC946000BC946000C0986000B890
      580098682800E0E0E00070707000BCBCB8000000000000000000884028008840
      200088402000A8583000C0684000D8805000F0986000F8A87000F8A87000FFB0
      7800FFB88000FFB88000F8B88000F8B07000F0986000E0804800C8603000B050
      2800B0603800A848200000000000000000000000000000000000000000000000
      0000D6AA6000F4E0C000FEF2DE00FEF0DC00FCECD400F8E8D000FCECCC00FEEA
      CA00FEEACA00FEEACA00FEEACA00FEEACA00FEEACA00FEEACA00ECCA9400BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60029FF
      FF0017FFFF0001FFFF0000F6F6000CFFFF0017FFFF0017FFFF0017FFFF0017FF
      FF0021FFFF0021FFFF0021FFFF0021FFFF0021FFFF0021FFFF0027FFFF0017FF
      FF0000C6C600C1FFFF0000E0E00077FFFF0070707000E0E0E00098682800C098
      6400C0986800C0986800C0986000B8905800B0885000B0885000B0884800B088
      5000B0885000B8885000B8905800B8905800B8905800B8905800B8905800B080
      480098682800E0E0E00070707000B8B8B8000000000000000000F0B898008840
      2000B8684000C8704000D8784800E0885800F0986000F8B07800F8B88800F8B8
      8000F8B88000F8B88000FFB88000FFB87800FFA87000F8A06000F0885000E880
      4800C8603000F0B8980000000000000000000000000000000000000000000000
      0000D6AA6000F4E0C000FEF2DE00FEF0DC00FCECD400F8E8D000FCECCC00FEEA
      CA00FEEACA00FEEACA00FEEACA00FEEACA00FEEACA00FEEACA00ECCA9400BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60029FF
      FF002CFFFF002CFFFF0027FFFF0017FFFF0007FFFF0007FFFF0001FFFF0007FF
      FF0007FFFF000CFFFF0017FFFF0017FFFF0017FFFF0017FFFF0017FFFF0000FB
      FB0000C6C600C1FFFF0000E0E00071FFFF0070707000E0E0E00098682800C098
      6400C0986800C49C7000C8A47400CCA47800D0A88000D4B08800D4B08800D4B0
      8800D0AC8400CCA87C00C8A47800C8A07000C49C6C00C0986800BC946000B890
      580098682800E0E0E00070707000B8B8B800000000000000000070301800A858
      3800B0583800C0603800D0704800E0885000F0986000F8A87000F8B88800FFC8
      9800FFD8A000FFC89000F8C08800F8B07800F8A86800F8905000E8804800E070
      3800D0683800A048200000000000000000000000000000000000000000000000
      0000D6AA6000F4E0C000FEF4E000FCECD800F4E4CC00F4E4C800FCECD400FCEC
      D400F8E4C400F4E0BC00F4E0BC00F4E0BC00F4E0BC00F8E0BC00ECCA9400BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60029FF
      FF002CFFFF0037FFFF0041FFFF0047FFFF0051FFFF005FFFFF005FFFFF005FFF
      FF0057FFFF004CFFFF0044FFFF003CFFFF0034FFFF002CFFFF0021FFFF0017FF
      FF0000C6C600C1FFFF0000E0E00071FFFF0070707000E0E0E00098682800C098
      6400C0986800C49C7000C8A47400CCA47800D0A88000D4B08800D4B08800D4B0
      8800D0AC8400CCA87C00C8A47800C8A07000C49C6C00C0986800BC946000B890
      580098682800E0E0E00070707000BCBCBC00000000000000000070301800A858
      3800B0583800C0603800D0704800E0885000F0986000F8A87000F8B88800FFC8
      9800FFD8A000FFC89000F8C08800F8B07800F8A86800F8905000E8804800E070
      3800D0683800A048200000000000000000000000000000000000000000000000
      0000D6AA6000F4E4C400FEF4E2007272720070707000F4E4CC00FCECD800FCF0
      DC00F4E8D000F4E0C400F0DCBC00F0D8B400F0D8B400F2DCB600ECCA9400BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60029FF
      FF002CFFFF0037FFFF0041FFFF0047FFFF0051FFFF005FFFFF005FFFFF005FFF
      FF0057FFFF004CFFFF0044FFFF003CFFFF0034FFFF002CFFFF0021FFFF0017FF
      FF0000C6C600C1FFFF0000E0E00079FFFF0070707000E0E0E00098682800C098
      6400C0986800C8A07400C8A47800CCA87C00D0A88000D0AC8400D4B08800D8B4
      8C00DCB89000DCBC9800E0C09C00E4C4A400E4C4A400E8C8A800ECCCAC00ECD0
      B00098682800E0E0E00070707000C0C0C000000000000000000070301800B868
      4000C8784800E0986000F8B07800F8D09800FFE0C000FFE8D000FFF8F000FFF8
      F800FFF8F800FFF8F800FFF8F800FFF8F000FFE8D000F8D0B000F8C08800E898
      6800D8784800A048200000000000000000000000000000000000000000000000
      0000D6AA6000F4E4C800FEF4E4007878780074747400FCF0DC00FEF2E000A8A8
      A800A8A8A800A4A4A400A4A4A400A0A0A0009C9C9C00F8ECD400F0D8B000BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C60029FF
      FF002CFFFF003FFFFF0044FFFF004CFFFF0051FFFF0057FFFF005FFFFF0067FF
      FF006FFFFF0077FFFF007FFFFF0089FFFF0089FFFF0091FFFF0099FFFF009EFF
      FF0000C6C600C1FFFF0000E0E00081FFFF0070707000E0E0E00098682800C098
      6800C09C6C00C8A07400C8A47800CCA87C00D0A88000D0AC8400D4B08800D4B0
      8C00D8B49000DCB89400DCBC9800E0BC9C00E0C0A000E4C4A000E8C8A800ECCC
      AC0098682800E0E0E00070707000C0C0C000000000000000000078382000F090
      5800F0985800F0A06800F0A06800E8A07800E8A88000E8A07800E8A07800E8A0
      7800E8A07800E8A07800E8A88000E8A88800F0B89800E0C0A000F8D09800F8D0
      9800F8C08800A050280000000000000000000000000000000000000000000000
      0000D6AA6000F4E6CA00FEF6E600FEF6E600FEF6E600FEF4E400FEF4E400FEF4
      E400FEF4E200FEF4E200FEF4E000FEF2E000FEF2DE00FEF2DE00F2DAB400BE80
      1000D8D8D800F2F2F200000000000000000000E0E000C1FFFF0000C6C6002CFF
      FF0031FFFF003FFFFF0044FFFF004CFFFF0051FFFF0057FFFF005FFFFF0061FF
      FF0069FFFF0071FFFF0077FFFF007CFFFF0081FFFF0086FFFF0091FFFF0099FF
      FF0000C6C600C1FFFF0000E0E00081FFFF0070707000E0E0E00098682800C49C
      6C00C8A07000CCA47800D0A88000D0AC8400D4B08800D4B08C00D8B49000DCB8
      9400DCBC9800E0C09C00E4C4A000E4C4A400E8C8A800ECCCAC00F0D0B000F0D4
      B80098682800E0E0E00070707000C0C0C000000000000000000088402000D868
      3800D8703800D8683800D8703800E0703800E0703800E0703800E0703800E070
      3800E0703800D8683000D8683000D8683000D8602800D8602800D8602800D068
      3000D8703800B050280000000000000000000000000000000000000000000000
      0000D6AA6000F6E6CA00FEFAF400FEFAF400FEFAF400FEFAF200FEFAF200FEFA
      F200FEFAF200FEFAF200FEF8F000FEF8F000FEF8F000FEF8F000F2DCB800BE80
      1000E2E2E200F4F4F400000000000000000000E0E000C1FFFF0000C6C60034FF
      FF003CFFFF0047FFFF0051FFFF0057FFFF005FFFFF0061FFFF0069FFFF0071FF
      FF0077FFFF007FFFFF0086FFFF0089FFFF0091FFFF0099FFFF00A1FFFF00A9FF
      FF0000C6C600C1FFFF0000E0E00081FFFF0070707000E0E0E000986828009868
      2800986828009868280098682800986828009868280098682800986828009868
      2800986828009868280098682800986828009868280098682800986828009868
      280098682800E0E0E00070707000BCBCBC000000000000000000F8E0D000E098
      6800E0804800E8804800E8804800E8804800E8804800E8804800E0804800E078
      4000E0784000D8703800D8703800D8703800D8683800D0683000D0683000D068
      3800D8784800F8D8C80000000000000000000000000000000000000000000000
      0000D6AA6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA
      6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA6000D6AA
      6000F4F4F400FCFCFC00000000000000000000E0E000C1FFFF0000C6C60000C6
      C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6
      C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6C60000C6
      C60000C6C600C1FFFF0000E0E00079FFFF0070707000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E00070707000B8B8B800000000000000000000000000FFF8
      F800F8E0D000E8D0C000F8D0B000F0B89800F0B89800E8A88800E8A88800E8A8
      8000E8A88000E8A88000E8A88000E8A88800E8A88800E0C0A000E8D0C000F8E0
      D000F8F0F0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000E0E000C1FFFF00C1FFFF00C1FF
      FF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FF
      FF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FF
      FF00C1FFFF00C1FFFF0000E0E00071FFFF007070700070707000707070007070
      7000707070007070700070707000707070007070700070707000707070007070
      7000707070007070700070707000707070007070700070707000707070007070
      7000707070007070700070707000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000E0E00000E0E00000E0E00000E0
      E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0
      E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0E00000E0
      E00000E0E00000E0E00000E0E00081FFFF00424D3E000000000000003E000000
      2800000060000000480000000100010000000000600300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFF000000000000000000F0000F00
      0000000000000000F0000F000000000000000000F0000F000000000000000000
      FC007F0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFF00003FFFFFFF0000FFC
      003FF00003F0000FF0000FE00007F00003F0000FF0000FC00003F00003F0000F
      FC007FC00003F00003FC007F000000C00003F00003000000000000C00003F000
      03000000000000C00003F00003000000000000C00003F00003000000000000C0
      0003F00003000000000000C00003F00003000000000000C00003F00003000000
      000000C00003F00003000000000000C00003F00003000000000000C00003F000
      03000000000000C00003F00003000000000000C00003F00003000000000000C0
      0003F00003000000000000C00003F00003000000000000C00003F00003000000
      000000C00003F00003000000000000C00003F00003000000000000E00007FFFF
      FF000000000000FFFFFFFFFFFF00000000000000000000000000000000000000
      000000000000}
  end
  object ImgSutArchMod: TImageList
    Height = 24
    Width = 24
    Left = 408
    Top = 120
    Bitmap = {
      494C010107000900040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000480000000100200000000000006C
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
      0000000000000000000000000000000000000000000018189800181898001818
      9800181898000000000000000000000000000000000000000000000000000000
      0000000000001818980018189800181898001818980000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D8D8D80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0983800E098
      3800E0983800E0983800E0983800E0983800E0983800E0983800E0983800E098
      3800E0983800E0983800E0983800E0983800E0983800E0983800E0983800E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006060B000181898000000C8000000
      D000080898007878C00000000000000000000000000000000000000000000000
      00007070B800080898000000D0000000C800202098008888C800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004058000078787000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCE0
      A000FCE4A400FCE0A000F8E09800F8E09800FCE0A000FCE0A000FCE4A400FCE4
      A800FCE8B000FCECB400FCF0BC00E8800000E8B07000FCF4D400FCF8E400E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000088000000B0000000C8000808
      C8000000B8000808900000000000000000000000000000000000000000000000
      0000080890000000B8000808C8000808C8000000A80010109000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000889800008088000050582800E8E8E80000000000000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCE0
      A000FCE4A400FCE0A000F8E09800F8E09800F8E09800F8E09800F8E09800F8E0
      9800FCE4A400FCE4A400FCE4A800E8800000E8800000E8B87800FCF0C800E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000008C0008089800101098001010
      9800000098000808900000000000000000000000000000000000000000000000
      0000080890000000980010109800101098000000900010109000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000088900000D8C0080098A0000038500000C8C8C800000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCE4
      A400FCE4A800D8881800D0881800D0881800D0801800D0801800C8782000C878
      2000C8782000C8782000C8782000E8800000FCA00000E8800000E8C08000E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004444A800141494004444A8004848
      B800101098007070C00000000000000000000000000000000000000000000000
      00006060B800101098005050B0003838B0001C1C98008888D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080880000D0B80000D0B80800B8B0000048600000A0A098000000
      0000000000000000000000000000000000000000000000000000E0983800FCE4
      A400FCE8B000FCE4A400FCE4A400FCE0A000FCE0A000F0D08000F0C07000F0C0
      7000F0C07000F0C07000F0C07000E8800000FCA00000FCA00000E8800000D888
      2800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007878C000101090000808
      8800605898000000000000000000000000000000000000000000000000000000
      0000F0E8E8004020600008089000080888006050800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000384800005058100050581000505810005058100050581000505810005058
      100050680000A0A80000C8B00000C0A80000D0B80000C8B80800687000007070
      6800000000000000000000000000000000000000000000000000E0983800FCE4
      A400FCE8B000FCE4A800FCE4A400FCE4A400FCE4A400E8800000E8800000E880
      0000E8800000E8800000E8800000E8800000FCA00000FCA00000FCA00000E880
      0000F0D8C8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B078
      4800C08860000000000000000000000000000000000000000000000000000000
      0000D8C0A800A058180000000000D0B09000A860280000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080880000C0B80800B8B00000B8B00000B8B00000B8B00000B8B00000B8B0
      0000B8B00000D0B80000C8B00000C0A80000C0A80000C8B00000D0B808008088
      0000505828000000000000000000000000000000000000000000E0983800FCE4
      A800FCE8B000E0981800E0981800D8901800D8901800E8800000FCA00000FCA0
      0000FCA00000FCA00000FCA00000FCA00000FCA00000FCA00000FCA00000FCA0
      0000E8800000F8E8D80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D8B8
      A00098501800F0E8E00000000000000000000000000000000000000000000000
      0000B8805800B078480000000000E8E0D00098501000E0D0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000088900000D0B80000C8B00000C8B00000C8B00000C8B00000C0A80000C0A8
      0000C0A80000C0A80000C0A80000C0A80000C0A80000C0A80000C8B00000E0C8
      4000A0A800004860000000000000000000000000000000000000E0983800FCE8
      B000FCECB400FCE8B000F8E8A800FCE4A800FCE4A400E8800000FC980000FCA0
      0000FCA00000FCA00000FCA00000FCA00000FCA00000FCA00000FCA00000FCA0
      0000FCA00000E8800000F8E8E000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E0C8B800E0C8B80000000000000000000000000000000000000000000000
      0000E0C8B800B88058000000000000000000E8D0C00098501000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000088900000D0B80000D0B80000D0B80000D0B80000D0B80000D0B80000D0B8
      0000D0B80000C0A80000C0A80000C0A80000C0A80000C8B00000E8D87800A0A8
      0000E0E0C0000000000000000000000000000000000000000000E0983800FCEC
      B400FCECB400FCECB400FCECB400FCECB400FCECB400E8800000F8C04000F8C0
      4000F8C04000F8C04000F8C04000F8C04000F8C04000F8C04000F8C04000F8C0
      4000F8C04000F8C04000E8800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B0785000B88058000000000000000000000000000000000000000000D8B8
      A000A0581800F0E8E0000000000000000000C8A08000A0582000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A0802000B8B05000B8B05000B8B05000B8B05000B8B05000B8B05000B8B0
      5800B8B05800E8D88800D8C02000C0A80000D8C02000E8D87800D8C03800B8B0
      5800000000000000000000000000000000000000000000000000E0983800FCEC
      B400FCF0BC00E8A81800E8A81800E8A41800E4A01800E8800000F8C04000F8C0
      4000F8C04000F8C04000F8C04000F8C04000F8C04000F8C04000F8C04000F8C0
      4000F8C04000F8B84000E8800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D0B09800A0581800F8F8F00000000000000000000000000000000000B880
      5000B0704000000000000000000000000000E8D8C80098501000E0D0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B8B05000D8C03800D8C03800E8D87000A0A02000C0C0A0000000
      0000000000000000000000000000000000000000000000000000E0983800FCF0
      BC00FCF0C000FCF0BC00FCECB400FCECB400FCE8B000E8800000F8B83000F8B8
      3000F8B83000F8B83000F8B83000F8B83000F8B83000F8B83000F8B83000F8B8
      3000F8B83000E880000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0E0D80098501800D8C0A800000000000000000000000000F0E8E800A058
      2000D0B0900000000000000000000000000000000000A8603000C09870000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A0A02000E8D89000E0C85000A0A02000E0E0C000000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCF0
      C000FCF0C800FCF0BC00FCF0BC00FCECB400FCECB400E8800000F8B01800F8B0
      2000F8B02000F8B01800F8B02000F8B02000F8B01800F8B01800F8B02000F8B0
      1800E88000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B0784800B8805000000000000000000000000000E0C0B0009850
      1000E8E0E00000000000000000000000000000000000C8987800A86030000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A0A02000D8C84000A0A020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCF0
      C400FCF4CC00F4B81400F0B41800F0B01800ECB01800E8800000E8800000E880
      0000E8800000E8800000E8800000E8800000F8A81000F8A81000F8A81000E880
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D0B09000A0582000F8F0E8000000000000000000B8886000B078
      48000000000000000000000000000000000000000000E8D8D00098501000E8D0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000088980000A0885000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCF4
      CC00FCF4D400FCF0CC00FCF0C400FCF0C400FCF0BC00FCECB400FCE4AC00FCE4
      A800FCE0A000FCE0A000F8E09800E8800000F8A80800F8A80800E8800000E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F0E0D80098501000D8C0A80000000000F8F0E800A0582000D0B0
      9800000000000000000000000000000000000000000000000000A8683000C898
      7800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E8E8E800A0A0A000606060004040
      200040381800505810004040200070706800A8A8A800E8E8E800000000000000
      0000000000000000000000000000000000000000000000000000E0983800FCF8
      D400FCF8DC00FCF4D000FCF4CC00FCF0CC00FCF0C400FCF0C000FCF0BC00FCEC
      B400FCE8B000FCE4AC00FCE4A400E8800000FCA00000E8800000F0D08000E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B0704000B888600000000000E0C0B00098501800F0E0
      D800000000000000000000000000000000000000000000000000C8A07800A868
      3000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E8E8E800707068005058280088888800A8988000A058
      2000A0480000A0480000A0582000A8988000888888004040200060606000E8E8
      E800000000000000000000000000000000000000000000000000E0983800FCF8
      DC00FCF8E000FCC41400F8C01400F8C01400F8BC1400F4BC1400F4B81400F0B4
      1800F0B41800F0B01800ECAC1800E8800000E8800000F0D08000F8E09800E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B0704000E0C8B8000000000098501800985018000000
      000000000000000000000000000000000000000000000000000000000000E0C8
      B800000000000000000000000000000000000000000000000000000000000000
      000000000000E8E8E8007070680050582800FFFFFF00F8F0E800A0582000A058
      2000E8D8B800F0D8B800A0582000A0582000F8F0F000FFFFFF00606060009088
      7000E8E8E8000000000000000000000000000000000000000000E0983800FCFC
      F400FCFCEC00FCFCEC00FCFCEC00FCF8E000FCF8E000FCF8E000FCF0BC00FCF0
      BC00FCF0BC00FCF0BC00FCF0BC00E8800000FCECB400FCECB400FCECB400E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0E0D800A8581800E0C8B000B0683000D0A888000000
      000000000000000000000000000000000000000000000000000000000000B068
      3000C8A078000000000000000000000000000000000000000000000000000000
      0000B8B8B800A8A8A800FFFFFF00FFFFFF00FFF8F800B0682800B0680000D090
      4800E8B07800A0886000B0682800B8600000B0682800FFF8F800FFFFFF00E0C8
      B00090887000C8C0C00000000000000000000000000000000000E0983800FCFC
      E400FCFCEC00FCFCE800FCFCE400FCF8E000FCF8DC00FCF8D800FCF8D400FCF4
      D000FCF4CC00FCF0C400FCF0BC00FCECB400FCECB400FCE8B000FCE4A800E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004030700008088800080888008078B0000000
      0000000000000000000000000000000000000000000000000000000000005848
      800008088800080890007870B80000000000000000000000000000000000D8D8
      D80090887000E8D8C000FFFFFF00FFFFFF00F0D8D000A8500000C0781000F0C8
      9800808078000000000018181800A0804000B8600000F0D8D000FFFFFF00E8D0
      B000A0804000A0886000E0E0E000000000000000000000000000E0983800FCFC
      E800FCFCF000FCC81400FCC81400FCC81400FCC81400FCC81400FCC41400FCC4
      1400F8C01400F8C01400F4BC1400F4B81400F0B41800FCECB400FCE8B000E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005050B0000000A8000000E8000000D0002C2CA0009090
      D0000000000000000000000000000000000000000000000000006868C0000808
      A0000000E0000000D000080898008080D000000000000000000000000000C8C8
      C8001810000090784000E0C8B000FFF8F000F0D8D000A8500000C0781000F0C8
      98002828280040402000C8C8C800E8D8D000C8883800E8D8D000FFFFF800C8B0
      88008068100010080000C8C8C800000000000000000000000000E0983800FCFC
      EC00FCFCF400FCFCF000FCFCEC00FCFCE800FCFCE800FCFCE400FCFCE000FCF8
      DC00FCF8D800FCF8D400FCF4D000FCF4CC00FCF0C400FCF0BC00FCF0C000E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000004048C000000B8000808B8000808C0000808A0001818
      9400000000000000000000000000000000000000000000000000080890000000
      B0000808B8000808B8000000B00004048C000000000000000000000000000000
      0000989898001810000088703000B8A07800D8B8A000A0582000B8680000E0A0
      6000A8988000B8B8B800FFFFFF00FFFFF800D0904800F0D8C000C8B088008870
      2000181000009898980000000000000000000000000000000000E0983800FCFC
      EC00FCFCF800FCFCF400FCFCF000FCFCEC00FCFCEC00FCFCE800FCFCE400FCFC
      E000FCF8DC00FCF8DC00FCF8D400FCF4D400FCF4D000FCF4CC00FCF4D000E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000004048C00080898001818980010109800101098001818
      9400000000000000000000000000000000000000000000000000080890000808
      9000181898001818980008089000080890000000000000000000000000000000
      000000000000A8A8A8003038200050582800907838009078400088382000A858
      0000D0986000E8D0B000E8D0B000C0806000C0806000A8907000505810001008
      0000B8B8B8000000000000000000000000000000000000000000E0983800FCFC
      F400FFFFFF00FCFCF800FCFCF400FCFCF400FCFCF000FCFCF000FCFCEC00FCFC
      E800FCFCE400FCFCE400FCF8E000FCF8DC00FCF8D800FCF8D400FCF8D800E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005050B000181894006060B8003434A4003C3CA8009090
      CC000000000000000000000000000000000000000000000000007878C0002020
      98005858B0004848A800242498009090CC000000000000000000000000000000
      00000000000000000000F8F0F000808080002020000040300800403818004020
      200040202000602820006028200060282000404020002020000070706800E8E8
      E800000000000000000000000000000000000000000000000000E0983800FCFC
      EC00FCFCFC00FCFCF800FCFCF400FCFCF000FCFCF000FCFCEC00FCFCEC00FCFC
      E800FCFCE400FCFCE400FCFCE000FCFCE800FCFCE400FCF8E000FCFCE400E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000028289C000808900004048C008888C8000000
      0000000000000000000000000000000000000000000000000000000000005050
      AC000808900004048C006868B800000000000000000000000000000000000000
      000000000000000000000000000000000000E8E8E800A0A0A000606060001818
      180008080800080808001818180060606000A0A0A000E8E8E800000000000000
      0000000000000000000000000000000000000000000000000000E0983800E098
      3800E0983800E0983800E0983800E0983800E0983800E0983800E0983800E098
      3800E0983800E0983800E0983800E0983800E0983800E0983800E0983800E098
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000068A0C8000060A0000068
      A8000068B0000070A8001070A800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B0706800B0706800B070
      6800B0706800B0706800B0706800B0706800B0706800B0706800B0706800B070
      6800B0706800B0706800B0706800B0706800B0706800B0706800B07068000000
      0000000000000000000000000000000000008838080088380800883808008838
      08008838080088380800883808008838080088380800D0C8C800000000000000
      0000000000000000000000000000905028009050280090502800905028009050
      2800905028009050280090502800905028000000000000000000000000000000
      0000000000000000000000000000000000007860300078603000786030007860
      3000786030007860300078603000786030000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000060A0C8000060A0000468A8000080D0000080
      D8000870B00008E8F0000078B0004888B8000000000000000000000000000000
      000000000000000000000000000000000000B0706800D8B09800F0D0B800E8C0
      A800A8686000A0606000B0706800B0706800B0706800A8686000A8686000A868
      6000A8686000A868600098585000D0988800E8C8B000E8C8B000C8908000B880
      80000000000000000000000000000000000088380800943C0400A0440000A044
      0000A4440000A4440000B04C00009840000094481800E4D0C400000000000000
      0000000000000000000000000000C49C800090380000C0580800D0600800C858
      0000C8580000D0600800B0480000905028000000000000000000000000000000
      00000000000000000000A0907000786030007058280070582800705828007058
      28007058280070582800705828007058280078582800A0907000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000068A0C0000060A0000468A8000080D0000890E8000890F0000060
      B00000C0D80008F8F80008E8F0000064A400A0C0D80000000000000000000000
      000000000000000000000000000000000000B8807000FFE8D000FFF0D800F8E8
      D000C0988800A0402800C0604000D0684800C8604000C0584000B8503800B048
      3000A84828009828180098403800F8D8C000FFE8D000FFE8D000F0C8B000C090
      8800B8909000000000000000000000000000883808009C400000B0500000B050
      0000B8500000C0580800B850000098502000E4D0C40000000000000000000000
      000000000000000000000000000000000000C0907800B0500800F0700000F870
      0000F8700000F8800000C8580000905838000000000000000000000000000000
      0000C8C0B0007860380070582800705828007058280070582800705828007058
      280070582800705828007058280070582800705828007058280078603000C8B8
      A000000000000000000000000000000000000000000000000000000000005898
      C0000060A0000068A8000080D0000090EC000890E8000890F0000070C0000090
      B80000F8F80000F8F80008F8F80000C0D8000064A400E8F0F800000000000000
      000000000000000000000000000000000000B8807000FFE8D000FFF0D800F8E8
      D000C0908800C0583800B8503800983020009830200090281800882018008018
      1000780808006000000088303000F8D8C000FFE0C800FFE8D000E0B8A000D8B0
      A000F0E0D800B888880000000000000000008838080098400000A8480000A848
      0000B04C0000AC48000090400C00E0D0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000090583800B8500000F070
      0000E0680000F8780000C058000090503000000000000000000000000000C0B0
      9800705828007058280070582800785828007858280070582800705828007058
      2800705828007058280070582800705828007058280070582800705828007058
      2800B8A89000000000000000000000000000000000005898C0000060A0000068
      B0000080D0000890E8000890F0000090E8000090EC000080D8000070A80000E8
      F00000F8F80000F0F80000F8F80008F8F8000088B8002878B000000000000000
      000000000000000000000000000000000000B0686000E8C0A800E8C8B000E0C8
      B000A870680098302000C8604000982818005800000058000000480000004800
      0000480000004800000070181800F8D0B800FFE8C800FFE0C800E8B8A000C8A0
      9000FFF8E800F0C8B800C0989000000000008838080098400000A4440000A848
      0000AC480000B050080098400800B89070000000000000000000000000000000
      000000000000000000000000000000000000B8887000A8480000E0680000E868
      0000F0700000F8780000C0500000985830000000000000000000D0C8B0007058
      2800786028007860280078602800786030007860280078602800786028007858
      2800785828007058280070582800705828007058280070582800705828007058
      280070582800D0C0A80000000000000000001068A8000068A8000088D8000898
      E8000898E8000090E8000090E8000090E8000090F0000068B00000B8D80000F0
      F80000E8F80000E8F80000E8F80000F0F80008F8F8000068A80078B0D0000000
      000000000000000000000000000000000000B8787000E0B8A000E0B09800E0B0
      9800D8A89800D8A89800D8A89800E0B8A000E0B09800E8B8A000E8B8A000E8B8
      A000E8B8A000E8C0A800C8908000C8888000FFF0D800FFE8D000E8B8A000C898
      8800FFE8D800FFF0D800C08878000000000088380800943C0400A4440000A848
      0800A8480800AC480000B0500800943C0000B888680000000000000000000000
      0000000000000000000000000000B8887000A0400000E0680000E0680000E870
      0000C8580000F0700000C8580000905030000000000000000000806838008060
      3000806830008068300080683000806030008060300080603000786030007860
      3000786028007860280078582800705828007058280070582800705828007058
      2800705828007860300000000000000000004888B8000060A0000098E00000A0
      F00000A0E80000A0F0000098E80000A0F0000078C0000088B80000E0F80000D8
      F80000E0F80000E0F80000E0F80000E0F80000F0F80000D0E8000060A000C0D8
      E80000000000000000000000000000000000D0988800FFF0D800FFE8D000FFE8
      D000FFE8D000FFE8D000FFE8D000FFE8D000FFF0D800FFF0D800FFF8D800FFF0
      D800FFF0D800FFF8E800F8D0B800C0807800FFF0D800FFE8C800E8C0A000B870
      6000F0C8B800FFE8D000C88880000000000088380800943C04009C4000008C34
      0000983C0000A8480800AC480000B0500800943C0000B0806800000000000000
      00000000000000000000B89070009C400000D8600800D8600800E0680000B850
      000088401800B0500800B85000009858380000000000A8987800806030008868
      3800887040009070380088703800886838008868300088683000806830008068
      3000806030007860300078602800785828007058280070582800705828007058
      28007058280070582800A088680000000000000000003880B0000060A00000A8
      E80000B0F00000B0F00000B0F0000078C0000098D00000C8F80000C8F80000C0
      F00000D0F00000D0F00000D0F00000D0F80000D0F00008E0F8000078B0004888
      B80000000000000000000000000000000000C8A09000FFF8E000FFE8D000FFE8
      D000FFE8D000FFE8D000FFE8D000FFE8D000FFE8D000FFE0C800FFE8C800FFE0
      C800FFE0C800FFF0D800E8C8B000C8888000FFF8E800FFF0D800F0D0B800D098
      8800F0C8B000F8D0B800C8887800000000009044100090380000903C0800C8A4
      8C00A8684000983C0000B0500800AC480000B0500800943C0000B08060000000
      000000000000B888680098400000D0600800D0600800D8600800B04C0000A060
      3800E8E0D800C8A48C008C340000A05828000000000080683800887038009078
      4800988048009880480098784000907038009070380090703800887038008868
      3000886830008068300080603000786030007860280078582800705828007058
      28007058280070582800705828000000000000000000000000003880B0000060
      A00000A8E80000B0F00000B0F0000078B8000098D00000C8F80000C0F00000C8
      F00000C8F00000D0F00000D0F00000D0F00000D0F80000D0F00008E0F8000078
      B0004888B800000000000000000000000000A8787000FFF8E000FFF8E000FFF8
      E000FFF8E000FFF8E000FFF8E000FFF8E000FFF8E000FFF8E000FFF8E000FFF8
      E000FFF8E000FFF8E000FFF8E000A8707000FFF8E800FFF8E800F0D0B800D098
      8800F0C8B000F8D0B800C8887800000000009044100090441000C8A48C000000
      000000000000A8684000983C0000B0500800AC480000B0500800943C0000B080
      6000B080600098400000D0600800D0600800D8600800B04C0000A06038000000
      000000000000C8A48C008C340000A05828000000000088703800907848009880
      4800B8986800B0946000A8885000A0804000A0804000A0784000A07840009878
      3800907038009070380088683800886830008060300078603000786028007858
      2800705828007058280070582800B8A890000000000000000000E0E8F0001870
      A8000070B00000C0F80000B8F0000068A8000090D00000C0F80000B8F00000B8
      F00000C0F00000C0F00000C0F00000C8F00000C8F00000C8F00000D0F80000D0
      F0000064A40098C0D8000000000000000000A8787000B8888000C8A8A000C8A0
      9000C0989000C0988800C0908800B8908800B8888000B8887800B8807800B880
      7800B0787000A8787000A8706800A8707000FFF8F800FFFFFF00FFF8F800B880
      7800FFB89800FFC8A800FFC8A800C8887800C0907000E0C8B800000000000000
      00000000000000000000A8603800983C0000A8480800AC480000B0500800943C
      0000943C0000C0580800C0500000C0580800AC480000A8603800F0E8E0000000
      000000000000000000000000000000000000A898700098804800A8906000B898
      6800B8986800B0946000A8885000A8884800A0804000A0804000A07840009878
      3800907038009070380088683800886830008060300078603000786028007858
      2800705828007058280070582800988058000000000000000000B0D0E0000060
      A00000A0D00000C8F80000C8F8000098D0000060A00000A0E00000B0F00000B0
      F00000B0F00000B8F00000B8F00000B8F00000C0F00000C0F00000C0F00000D0
      F80000A8D8000064A400E0E8F0000000000000000000C8A0A000D0A89800FFFF
      E800FFF8F000FFFFE800FFFFE800FFFFE800FFFFE800FFFFE800FFF8F000FFF8
      F000FFF8F000FFF8F000FFFFF800FFF8F000B8787000F8F0E000D0704800F8F0
      E000B8807000E0A08000FFC8A800C88878000000000000000000000000000000
      0000000000000000000000000000A0603800983C0000A8480800AC480000B050
      0800B8500000B8500000C0580800A8480000A0583000E8E0E000000000000000
      000000000000000000000000000000000000A0885800A88C5800B8A07000C0A8
      8000C8A87800C0A06800B8985800B0905000B0884800B0884800A8804000A080
      4000A07838009878380090703800907038008868300080603000786030007860
      28007058280070582800705828008870400000000000000000003880B0001870
      B00000B8E80000D8F80000C8F00000D8F8000088B8000060A00000A0E80000A8
      F00000A8F00000A8F00000B0F00000B0F00000B0F00000B8F00000B8F00000B8
      F00008C8F8000080B8002878B000000000000000000000000000F0E8E800B880
      8000E8C8B800FFFFE800FFF0D800F8E8D000FFE8D000FFE8D000FFF0D800FFE8
      D000FFF0D800FFE8D000FFE8D000FFF8E000FFF8E000B0786800F8F0E000F8F0
      E000F8F0E000B8807000E8987000E08060000000000000000000000000000000
      000000000000000000000000000000000000A870480098400000A8480800AC48
      0000B04C0000B0500800A4440000A06840000000000000000000000000000000
      000000000000000000000000000000000000A0885000B0986800C8B08800D0B8
      9000D0B89000D0B08000C8A87000C8A06000C0985800C0985000B8904800B088
      4800A8804000A080400098783800907038008870380088683000806030007860
      3000785828007058280070582800806838000000000000000000B8D8E8002878
      B0000878B00000D8F80000D8F80000D0F00000D8F8000070B0000060A0000098
      E80000A0E80000A0F00000A0F00000A8F00000A8F00000A8F00000B0F00000B0
      F00000B0F00000B8F0000068A80070A8C8000000000000000000000000000000
      0000D8C0C000B8887800F8E0C800F0D0B800E0B8A000D8A89800D0A89000D0A8
      9000D0A89000D0A08800D0A08800D0A08800D8B09800D8A89800A0606000A870
      6800A0606000A8787000A0585000A85040000000000000000000000000000000
      000000000000000000000000000000000000B88870008C380000A8480800A848
      0000AC480000B0500800983C0000B07858000000000000000000000000000000
      000000000000000000000000000000000000A88C5800C0A07000D0B89000E0C8
      A800E0D0B000E0D0A800E0C09800E0C08800D8B87800D8B06800D0A05800C098
      5000B0884800A8804000A0804000987838009070380088683800806830008060
      30007860280070582800705828008068380000000000000000000000000080B0
      D0003880B0000090C00008E0F80008E0F80000E0F80000C8E8000468A8000060
      A0000090E0000098E8000098E80000A0E80000A0E80000A0F00000A8F00000A8
      F00000A8E80000B0F0000080C0001870A8000000000000000000000000000000
      00000000000000000000D0A8A800C0A0A00098504800D0A08800C8908000C888
      8000C8888000C8887800C8888000C8887800C8887800C8908000B8787000C898
      5800FFE89000C8985800A0606000C8A8A8000000000000000000000000000000
      0000000000000000000000000000C09078008C38000098400800A0440000A848
      0800A8480800AC480000B0500800983C0000B078580000000000000000000000
      000000000000000000000000000000000000B0986800C0A87800D8C8A000E8D8
      C000F0E0C800F0E0C800F0E0C000F0E0C000E8D8B000E8C89800E0C08000D0A8
      6000C0985000B0884800A8804000A08040009878380090703800886830008060
      3000786030007858280070582800887048000000000000000000000000000000
      00003080B0003080B0000078B0000070A80000D8F00000E8F80000E0F0000088
      B8000060A0000088E0000090E8000090E8000098E8000098E8000098E8000098
      E80000A8F0000090D8001068A800A8C8E0000000000000000000000000000000
      000000000000000000000000000000000000B8888800F8E8D800F8E8C800F8E0
      C800F8E8C800F8E0C800F8E8C800F8E8C800F8E0C800F8E8D000B8888000E0A0
      6000FFE89000E0A08000A8686800000000000000000000000000000000000000
      00000000000000000000C0988000883400009840080098400800A04400009838
      000098380000A8480800AC480000B0500800983C0000B0806000000000000000
      00000000000000000000E8D8CC00C8A08800C0B08800C8A87800E0D0A800F0E0
      D000F8E8D800F8F0E000F8F0E000F8E8D800F0E0C800F0D8B800E8D0A800E0C0
      8800D0A85800C0904800B0884000A88040009878380090703800887038008068
      3000786030007858280070582800988058000000000000000000000000000000
      0000000000003080B0003080B0003080B0000070A80000D8F00000E8F80000E0
      F0000088B8000060A0000080D8000090EC000090E800008CEC000088E8000890
      F0000890F0000070C0001068A800000000000000000000000000000000000000
      000000000000000000000000000000000000D8C0C000B8706800D0A8A800C8A8
      A800C8A8A800C8A8A800C8A8A000C8A8A800C8A8A000C8A8A800B0787000B870
      6000B8786800B8786800A06058000000000094441000B0806000000000000000
      000000000000C09880008C380000904008009038000098400800903800009060
      3800A8684000983C0000A8480800AC480000B0500800983C0000B07858000000
      000000000000E0D0C000944C1C0088340000D8C8B000C0A87000E0D0A800F0E8
      D000F8F0E000F8F0E800F8F8E800F8F0E800F8F0E000F0E8D000F0D8B800E8D0
      A000D8B07000C8985000B0904800A8804000A080400098783800907038008868
      3000806030007860280070582800B8A890000000000000000000000000000000
      0000000000000000000000000000D4E4F0001870A8000060A00000E0F00008F8
      F80008E8F0000060A0000080D8000090EC000090E800008CEC000088E8000890
      F0000070C0000060A00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8787000FFFFF800FFFF
      F800FFFFF800FFFFF800FFFFF800FFFFF800FFFFF800FFFFF800FFF0E800C090
      88000000000000000000000000000000000094441000B8886800985028000000
      0000000000009850280090400800903800009038000090400800906038000000
      000000000000A8684000983C0000A8480800A8480800A8480800983C00000000
      0000000000008C3C0800B85000008838080000000000D0B89800E8D0B000F8F8
      F000F8F8F400F8F8F400F8F8F400FCFCFC00FCFCFC00F8F8F400F0E8D000E8D0
      A000D8B07000D0A86800A8804000B0884800A8884800A0804000987840008060
      3000806030007058280070582800000000000000000000000000000000000000
      000000000000000000000000000000000000A0C0D8000078B0000060A00000D8
      E80000B8D8000060A0000480D0000090F0000890E8000090E8000890F0000080
      D8001068A800A0C8D80000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8787000FFFFF800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF0E800C090
      88000000000000000000000000000000000070100800B8886800B08068009038
      200098502800B8805800A8684000A464380090400800A0603000F0E8E0000000
      000000000000F8F0E800A8684000943C0000B0500800A8480000B05008009840
      00008C3C0800B8500000B05008008030000000000000D0B89800D0B08000E8D0
      B000F0E8D000F8F0E000F8F8F000F8F8F000F8F8F000F8F0E800F8E8D800F0D8
      B800E0C09000D0A86800B8985000B0884800A8884800A0804000987840008868
      38008060300078582800A8987000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000078A8C8000070A8000060
      A0000060A0001068A8000070B8000890F0000090E8000890E8000890E800086C
      AC003888B8000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0888000FFE8D800FFF8
      F000FFF0E800FFF8F000FFF8F000FFF8F000FFF8F000FFF8F000FFF8F000B870
      60000000000000000000000000000000000070100800B8887000E8D8C800B884
      6400C0987800C0947400B88060009C542400A0583000ECE0D800000000000000
      00000000000000000000F0E8E800A0604000943C0000A8480800AC480000B04C
      0000B04C0000C0580800A8480000883400000000000000000000C0A87000D8C0
      9000E8D8B800F0E8D800F8F0E800F8F8F000F8F8F000F8F0E800F8F0E000F0E0
      C000E0C89800D0B07800C0A06800B8985800B0905800A0885000987840008868
      3800806030008068380000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0D8E800D0E0
      E80000000000B8D8E8001068A8000078D0000890F0000890F0000078C0000060
      A000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8A8A000F8C0A800FFE8
      E000FFE8D800FFE8D800FFE8D800FFE8D800FFE8D800FFE8D800FFF8F000B870
      60000000000000000000000000000000000070100000C0907800ECE0D800DCC0
      B000D0B09800C8A08400A8704800A0603800F0E0E00000000000000000000000
      0000000000000000000000000000F8F0E800A870500098400000A8480800AC48
      0000B04C0000B0500000A8480000883000000000000000000000E8D8C800C8A8
      7000E0C09800E8D8C000F8E8D800F8F0E800F8F8F000F8F0E800F8F0E000F0E0
      C800E0D0A800D8B89000C8B07800C0A07000B8986000A8885000987840008868
      380078603000C8C0B00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000068A0C0000868A8000088E0000088DC001068A8009CC4
      DC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F8C0A800FFE0
      C800FFD8C000FFD8C800FFD8C800FFD8C800FFD8C800FFD8C800FFE8D000F8B8
      A0000000000000000000000000000000000070080000C49C8000F4F0EC00E0C8
      B800D8C0B000C8A0800088380800E0C8C0000000000000000000000000000000
      000000000000000000000000000000000000D0B8A80088380000A4440000A848
      0000A8480000B04C0000A444000088340000000000000000000000000000E0D0
      B000C8A87000E0C09000E8D8B800F0E8D000F8F0E000F8F0E000F0E8D800F0E0
      C000E0D0A800D8C09800C8B08000C0A07000B0986000A0885000907840008068
      3000C0B098000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002078B0000870B0000870B0003888B8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFC8B000FFC8
      B000FFC8B000FFC8B000FFC8B000FFC8B000FFD0B800FFD0B800FFD0B800FFC0
      A0000000000000000000000000000000000070080000CCA89000FFFFFF00F4F0
      EC00ECE0D800E8D8C800C0907000A0604800F0E8E40000000000000000000000
      0000000000000000000000000000E0C8B8009448180098400000A8480800A444
      0000A8480000B04C0000A4440000883400000000000000000000000000000000
      0000E0D8C400C8A87000D8B88800E0D0A800E8D8B800E8E0C000E8D8B800E8D0
      B000D8C09800D0B08000C0A87000B8986000A88850009878400090704000D0C0
      B000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001870A8002070A800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFD8C000FFB8
      9000FFB89800FFB89800FFB89800FFB89800FFB89800FFB89800FFB89800FFB8
      9000FFF0E80000000000000000000000000080200000B0785000D0B09800C8A4
      8C00C49C8000C0907800C0947400944C1C00A0604000F0E8E800000000000000
      00000000000000000000D0C8C800984818008C380000943C0400943C04009840
      0000984000009C40000098400000883808000000000000000000000000000000
      00000000000000000000D0C09800C8A87000D0B08000D8B88800D8B88800D0B0
      8000C8A87000C0A06800B0905800A888500098804800B0A08000ECE8E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFF0E800FFC8
      A800FFC8A800FFC8A800FFC8B000FFC8A800FFC8B000FFC8A800FFC8B000FFC8
      A800FFF8F0000000000000000000000000009848100080280000701000007010
      0800701008007010000070100000904018008C380000F0E8E800000000000000
      00000000000000000000D0C8C8008C3400009040100088340000883808008838
      0800883808008838080088340000944410000000000000000000000000000000
      0000000000000000000000000000F4F0E800D8C8B000D0B89000C0A87800B898
      6000B0946000B0986800B8A47C00C8C0A800ECE8E00000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000480000000100010000000000600300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000087F87FFFFBFFC0000F00000003F03FFF
      F9FFC0000F00000003F03FFFF87FC0000F00000003F03FFFF83FC0000F000000
      03F03FFFF81FC0000F00000087F07FF0000FC00007000000E7F27FF00007C000
      03000000E3F23FF00003C00001000000F3F33FF00007C00001000000F3E33FF0
      000FC00001000000F1E71FFFF81FC00003000000F1C79FFFF83FC00007000000
      F9C79FFFF8FFC0000F000000F8CF8FFFF9FFC0000F000000F88FCFFF003FC000
      0F000000FC8FCFFC000FC0000F000000FC9FEFF80007C0000F000000FC1FE7F0
      0003C0000F000000FE1FE1E00001C0000F000000FC0FC0E00001C0000F000000
      FC0FC0F00003C0000F000000FC0FC0F80007C0000F000000FC0FC0FC000FC000
      0F000000FE1FE1FF003FC0000F000000FF81FF80001F003E00FF00FFFE00FF00
      000F003E00FC003FF8007F000007007F00F0000FE0003F00000300FF80E00007
      80003F00000100FF00C0000300001F000001007E00C0000300000F000001003C
      0080000180000F000001001800800001C00007000001180018800000C0000300
      00003C001F000000C00001800000FE003F000000C00001C00000FF00FF000000
      C00000F00000FF00FF000000E00000FC0000FE007F000000F00000FF0001FC00
      3C000000F80001FF0001380018000000FE0003FF800F181818800001FF0003FF
      800F001800800001FF8007FF800F003C00C00003FFC80FFF800F007E00C00003
      FFFC0FFFC00F00FF00E00007FFFE1FFFC00F007E00F0000FFFFF3FFFC007003C
      00FC001FFFFFFFFFC007003C00FE007F00000000000000000000000000000000
      000000000000}
  end
  object ImgReportTree: TImageList
    Left = 480
    Top = 208
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006565
      3200656532006565320065653200656532006565320065653200656532006565
      3200656532000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECD7B500DFCA9800DAC08800D7B9
      8100D4B27800D1AD7100CBA96B00CBA36800C79F5F00C8995C00C3915400BD93
      5400E7DFCF000000000000000000000000000000000000000000000000000000
      000000000000000000002C1E1A004D2F24000000000000000000000000000000
      000000000000000000000000000000000000000000000000000065653200BBBB
      BB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E0C68D00D2AF6400CBA25400C597
      4300C18F3800BB882D00B5802300B2791C00AC6E1100A9680B00A45E02009D59
      04008F642500E4D8C20000000000000000000000000000000000000000000000
      0000000000001A151300CFC7C500E5C3B800572E1F0000000000000000000000
      000000000000000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1CA9700D8B67200D1AE6500CBA3
      5500C69B4B00C4943E00C08C3500B9862D00B77C2500B1751D00AB6B0F00A56C
      1C008A5C1D009F6E2300E9DCBF00000000000000000000000000000000000000
      00001D171500CDC2BF00FFFFFF00FFFFFF00DEBFB300532E2100000000000000
      000000000000000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7D09E00DABA7300D4AE6300CFA7
      5A00C99F4E00C7964500C1913800BE892E00B9812500B77B1B00AF6F1200AA73
      1E0094672500A1691900BA7E2900F2E3CD00000000000000000000000000524C
      4A00CDC2BE00FFFFFF00C0BFC00089969B00EBDCD900EEC4B5005E392B000000
      000000000000000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00989865009898650098986500EEEEEE009898650098986500EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6D2A300DEC28100DCB97000D3AA
      5A00CEA75300C99D4900C4913700BF862500BD852500B67E1E00B2780F00AD78
      2400966B2500A5701D00BD7E2700EED5B500000000000000000050494700C1B6
      B200FFFFFF00BBBABB003CA9C5002AB8DB003A92A90093ADB600C69686006839
      290000000000000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00FFFFFF00FFFFFF00FFFFFF00EEEEEE00FFFFFF00FFFFFF00EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5CEA000E0C17E00DDBB7800D6AD
      6100D0A95600CEA24900C7973E00C7933800C48C2C00BD872100B87D1000BA85
      2B00A2762F00AB742300BF882D00F3DCBB0000000000534D4C00C1B5B200FFFF
      FF00BBB9BA003DABC70044D7F70046CEED0054E6FF0037C1E20042A1BA007270
      6E0056281800000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE009898650098986500EEEEEE00989865009898650098986500EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6CEA100DFBF7B00D8B76D00D7B1
      6200CFA75500CFA24A00CB9B4300C7973A00C5902C00C08B2200BC831300BF8F
      3100AA803700B17D2800C68E3400F4DDBB0085716B0076615B00FFFFFF00BCBB
      BC003DAAC60043D6F60040C6E60056E0FE0055DDFD005AE4FF0054E3FF0037CF
      F2005F949C00512418000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00FFFFFF00FFFFFF00EEEEEE00FFFFFF00FFFFFF00FFFFFF00EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5CFA100DFC07B00D9B97000D7B3
      6500D1A95A00CFA44F00CD9D4500C7963900C7912E00C28C2500BA811500C192
      3600AB823C00B3832B00C6953800F3DDBD000000000000000000565A5C004AB3
      CD0040D5F70040C7E60058E2FF0054DEFE0054DEFE0054DDFD0055DDFC003FD2
      F40041A5BE005F7376000000020000000000000000000000000065653200BBBB
      BB00EEEEEE00989865009898650098986500EEEEEE009898650098986500EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5CEA000E0BF7A00D8B86F00D7B2
      6B00D5AD5E00CEA75200CC9F4500C6993700C8943000C2902C00BB811300C69C
      4500AF874000B4842F00CD993D00F3DDBC0000000000000000002F8CA20041D9
      FC003BC1E10059E1FE0054DEFE0054DEFE0054DEFE0054DDFD0041C4E30042CB
      EC002B798B008E8F9000585A5A0000000000000000000000000065653200BBBB
      BB00EEEEEE00FFFFFF00FFFFFF00FFFFFF00EEEEEE00FFFFFF00FFFFFF00EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6D1A100DFC38300DBBC7800D9B3
      6C00D4AB5B00CEA65200CDA14600C99D3E00C7922F00C38D2A00B8800F00C397
      4200B48D3F00BA8A3100CD9C4000F5E0BE000000000012101000357D8F0055C9
      E30068F4FF004FDFFF0051DAFB0055DFFE0054DBFA0045DBFE0024ABCA00748D
      9300678A9200100F0E000000000000000000000000000000000065653200BBBB
      BB00EEEEEE009898650098986500EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00FFFFFF006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2D29E00DFC48600E0C28300D9BA
      7400D8B26800D4AE6100D4AA5700D0A65000CB9E4100CD993E00C9973900E1CA
      9500BB985500B9872B00CF9E4200F4DFC3000000000000000000000000001C20
      210059898B0071DDEC0060EEFF004FDAFA003BD2F6004298AB0068B9CC002A3F
      460083777500000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00FFFFFF00FFFFFF00EEEEEE00EEEEEE00FFFFFF00BBBBBB00BBBB
      BB00BBBBBB006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECE2CC00D5B88400C8A36200C6A8
      6800C6A46800C6A66700C8A96800C6A56400C6A36200C6A36500C6A97100D4BF
      9300CBAC7A00BF923F00D09D4000F3E0C6000000000000000000000000000000
      0000000000002A2C2C006194970050D9F70049CEED0026849A00837977005C5B
      5B0000000000000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00FFFFFF00656532006565
      3200656532006565320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F6F1E900DDC8A100D1AD
      6A00CAA86800CAA66300C8A45B00C79D5500C1974800BF903C00B8892D00B582
      2200C1954000CDA65C00CE9F4200F3DDBF000000000000000000000000000000
      0000000000000000000000000000365A6300636E7100829A9F00141717000000
      000000000000000000000000000000000000000000000000000065653200BBBB
      BB00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00FFFFFF0065653200CBCB
      9800656532000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F4ED
      D300ECD6AA00ECD3AB00ECD4A800ECD1A100E7CC9900E4C68D00E3C48400E0C1
      7F00DEB87400DFBD7C00E2C07E00F4E8CB000000000000000000000000000000
      0000000000000000000000000000000000000402010058525000000000000000
      000000000000000000000000000000000000000000000000000065653200BBBB
      BB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00FFFFFF00656532006565
      3200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFDFC00FFFBF500FFFBFA00FFFDF600FFFDF800FBFAF200FDFCF100FFF7
      EF00FFF8F100FFF5E900FCF1E100FAFDF8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006565
      3200656532006565320065653200656532006565320065653200656532000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFE00700000007FCFFC0030000
      0003F87FC00300000001F03FC00300000000E01FC00300000000C00FC0030000
      00008007C003000000000003C00300000000C001C00300000000C001C0030000
      00008003C00300000000E007C00300000000F80FC00300008000FE1FC0070000
      E000FF3FC00F0000F000FFFFE01F000000000000000000000000000000000000
      000000000000}
  end
  object ImgReportMod: TImageList
    Height = 32
    Width = 32
    Left = 320
    Top = 296
    Bitmap = {
      494C010102000400040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000002000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFF0
      F200E3E4E4000000000000000000000000000000000000000000000000000000
      000000000000D0CFD000D1D4D400000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000D8D9DA00A6A0
      9B009E938B00CECDCD000000000000000000000000000000000000000000CDCD
      CC00AAA49F00BBB9B400AAA49C00968D89000000000000000000000000000000
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
      00000000000000000000000000000000000000000000BCB8B800A1978E00BCAD
      A100C7B8A9009C928700CBCACA00000000000000000000000000B5B1AF00BBB5
      B200ECE9E700FFFFFF00D4CABD008E776200948C830000000000000000000000
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
      0000000000000000000000000000DCDCDC00A8A29D00B2A49A00CDC0B300DED6
      CE00E1DBD300CBBFB2009F948B00C8C9C800D3D2D300AAA6A200D4CFCC00FBF8
      F600F5F1F000FCFBFC00C9BFB200A58D720097836D00A8A39D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F0
      EB00EEDBC800EDD8C200F0DFCF00000000000000000000000000000000000000
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
      00000000000000000000BFBDBB00ADA6A000D5CAC100E1D8CE00DFD8D000DCD4
      CC00D4C9C000CBBEB400C0AE9F0090857A0064564C00D5C9C300FCFBFA00EDE8
      E700F1EDE900FEFEFE00D6CBC500A1877500AC948200917E7100CAC6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EAB9
      9000DF9E6200E4A16800CD8A5600D4C3BA00F0E8E800ECE2DF00F2EFEF000000
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
      0000E1E1E100ABA6A600C2BBB500F2EDE800E9E3DD00DDD6CE00DACFC800CDC3
      B900C3B4A600B7A79400AE9582008C74630065534100D0C9C200F8F4F300F4F0
      EF00F6F5F400FDFDFE00EDE9E600AF9A8A00A9968100A9907E0096897D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3E8DE00EDE6DE00E5DACB00E3A2
      6700EAA25D00F2AA6800BC773F0076615700C9C5C800C8BFBF00CAC5C400CDCC
      CD00D1D7D900D7D1CA00D3A28100A47C6500C0A09E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C5C3
      C300ADA5A200DBD2D000F3F0EC00E2DBD400D9D0C800D3C9C100C8BBAF00BDAD
      A000AF9C8A009E8970007E6752005648380058493800CFC2BA00FBFAFA00F7F7
      F600FAFBFB00FBFBFB00FEFFFE00C9B8AD00AB928100B49C8C00A0897600A6A1
      9C0000000000000000000000000000000000000000000000000000000000E5D6
      D100D7AB8E00DDCCBF00D8D8D600D4DCDF00D3D0D400C4CBD100CBC0BB00E798
      5F00EEA15F00EEA26100C5804B0057301C00ACA39C00BDBFC200B2B1B500B8B3
      B200BF978300BA6C4300C3612F00843A18007D4B2C00C5B4AB00F8F6F6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B1AEAD00B7AF
      A900E0D6CE00E8E2DC00DBD4CB00D8CFC500CFC4B800C3B5A900B8A69400A791
      7E008E766000675643004E433300574A3B0094827100D0C3B900F9F9F900FCFC
      FC00FDFDFD00FDFCFC00FFFFFF00E9E4DF00AE958400AF968700B19A88009682
      7400C5C3C4000000000000000000000000000000000000000000F6EFEE009762
      4C00B65D2D00C3704100BB7E5A00BA8F7900BDADA500B2B8BB00C3A89500E691
      5800F0995B00F49E5C00C278440053260F006F402A00BC8C6E00DAB79B00D487
      5E00BB5C2B00BF613500C2653A0095512B00743110008F624C00CED1D200E0DD
      DD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D2CCC400E4DE
      D600DED9D100DCD6CD00D3C9BD00CEC2B600BDAB9E00AC998300947B64007160
      4D0050443600493A2D0082736300BFAE9F00CEC0B300CFC4BA00F6F3F300FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FBF9F900C0B2A100AD988400B1998900AD96
      8600847568000000000000000000000000000000000000000000C6B4AC007734
      1300C0673A00C6683800C4633200C3623200EC955900F3AD7800AD5A3000E47F
      4600F18C4B00F58E4C00B86735005E2712005D230900B75E2800FFB97700E07B
      4200B75E2E00B8613200BD6232009D4F25007B3A19008A503300BABABA00BBBA
      BA00DEDCDC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E4E0D800DDD3
      CA00D8CEC600CEC2B700C2B4A600B7A79600AB947E008C745F00604F42004338
      2C005342370092827200C6B6A800CCBFB200CDC2B800D1C4BB00E7E2DD00FFFF
      FF00FDFDFD00FCFCFC00FAFAFA00FBFBFB00EEEBE600B4A38D00AD948500B29B
      89009E8B7600AEA6A40000000000000000000000000000000000977160009247
      2000C7673800BF653800BD663800BE603200F2935300F9A86B0099451E00DD7B
      4500EC915A00F4985F00B35C28005C220B0061270F00B55F3100FEB37500D578
      4500AB522700B2592B00AC5629009B4C25007F3B1900854E3300B7BBBD00B6B8
      BA00C6C2C300DEDDDD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DAD1
      C800CBBDAF00BDADA000AE9C8A009C846E00796351004B3F3200382E26006858
      4C00B3A39500CEC0B400CDC2B600D0C5B900D7CEC300E7E0DC00F7F5F500FCFA
      FB00FBFBFB00FAFAFA00FBFBFB00F7F6F600F6F3F200D5CBC200AB948200A998
      8200A58D7C00A5918300000000000000000000000000ECE9E7008D5D43009947
      2200C7693D00C0603900BB603400BE5C2D00F4955600F09F650081321200D787
      4800FAAD6400FBAC6200E3803C00732D110061240C00AA552700FEAE6C00D270
      4000A24A22009E481F00913F19009D47210087391B0083422300C4896800CA92
      7300BDAAA100C9CCCD00ECECEC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A69C8F00A8917A008A745F005C4B3C00362C23003F342D008E7F7100C8B9
      AD00D0C2BA00CEC1B700D5CAC000E1DAD300F4F2EE00FAF9F900ECE8E600D8CE
      C700F5F2F100FEFFFF00FAF8F800FCF7F700F5F1F100ECE9E300C1B6A600A48F
      7C00A58C7D00A9988A00000000000000000000000000E4D8D200895238009F47
      2200BE5B2E00B7592E00AE532600BB532700F9955500E9915C007C301000D576
      3400FF9A4600F68B3E00FD954A00B05426005E1F09009C492100FF985D00C966
      3500913E1800A1451E00C4693500E8914C00D27939009D4C2200CA633400D66C
      2E00C59A8000C1C2C600E1DCDB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AEAC
      AA00B8AFA70088726300372E230029221B005E514900B0A29500D2C5B900CEC2
      B600D0C6BA00DBD3C900EFE9E500FBFAFC00F4F3F000DED6CD00C8B8AD00AB97
      8000AF9D9000F7F5F400FAF8F800FAF5F600FBF8F900F0EFEB00E2DDD600BCA9
      9B009F857300A7998A00000000000000000000000000DFC3B000AB5D3100E593
      5000E08F4D00CC713D00AD562C00B3532800F5844800DB74400080311100E17F
      3E00FEA55100FC904700FE964A00EF8F4700A14F2200A3522800DF794000B960
      3000BB683200EE954E00FFA85300FDA75200FBA45200DB793E00CC6A3900D06C
      3200C7825B00C0BAB900E1DADA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C5C1BD00CEC4
      BD00FFFBF800635952001A160E00776A5F00CBBAAC00CFC2B700CEC1B700D9D0
      C800EDEBE700F6F6F400F3F0ED00DFD7D000C5BAAC00B09D8A0096806B007861
      4F0056433200A4988D00FFFFFF00FAF8F800FAFBFB00FEFEFE00ECE8E300DDD6
      CC00C9BBAF00CABCB3000000000000000000F3ECE400DEA37E00D86C3100EB8C
      4800FFAB5800FC9B5000EA7F3E00E5743600FA8B4100EF843E00E0713500FB89
      4200FD964700FE8A4100FE934600FE9C4900FE8F4500F3884300ED874300F38B
      4500FFA35100FFA14B00FE964600FC9C4B00E68B4300D4703700D3743B00D571
      3800C8754700CBBFBA00E7E6EA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEC8C400ECE9E700FEFB
      FC00F6F3F000A0968B00A6988C00D2C3B900CFC1B800D2C8BC00DED8D000F3F1
      EF00FCFDFC00EDEAE500D5CBC100BDAC9C00A58F7D00876F5C00695542005B48
      3900675644006B564400A3999100FFFFFE00FBFBFB00EDE8E500E1DBD300DDD6
      CE00D9D0C900000000000000000000000000F9FFFF00EAA37D00DD6E3200D773
      3C00E5833D00F8883C00FD803500FF843A00FF924300FF914500FF8C4200FF88
      3F00FC8F4500FB864000FF924900FE964800FA873F00FD8D4300FF974600FF95
      4500FC934500FD964700F492450084401B00873C1600B7582900B5582C00B352
      2500BA684100D8D2CE00F3ECE800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFD9D400F4F2F100FAFB
      FB00F9F9F900E0D5CD00CFC2B700D4C7BD00DAD0C900ECE6E300FAF9F900F4F3
      F100DFD7CF00C7B9AC00B19C8A00957E680075614D00644F41006D5948007A64
      50006A5646003A312700211B1200A59F9900FFFFFF00E6E0D900D6CCC100D1C5
      BB0000000000000000000000000000000000F3DBCD00DF895D00D4693400D76D
      3900A34A24009D4E2400F67D3800FC7F3600FE7D3500FD7D3600FD803800FC83
      3B00FF8A4000FE823400FC863600FB893A00FE853800FF934700FE994900FE96
      4700FD964700FE994900F28D4000BC652E00BE6E3900CA764400CE784400D17B
      4500D98A5A00F2E3DB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFD9D300F4F1EF00FDFE
      FE00FEFFFF00E9E5E100D3C7BF00E6E0DB00F8F6F500FBF8F700E6E1DB00CFC2
      B800B5A495009C847300826B56006D5A47006E5A49007A655000755E4D004A3F
      3300241F1700211E1600231F1700251E16008E867E00CEC4B800C2B3A300CABD
      B10000000000000000000000000000000000F5DACA00DC865500D36B3200D977
      3C00CE6B3300B85A2A00F3823A00FF803700FE7F3700FE803800FD7F3700FB7D
      3700DD783C00DA946400E1A98300DFA67B00CE865700D6743700FE8F4000FD91
      4600FE8F4700FE904700FF914800FF984800FFA25200FFAC5B00FFA95500FFA7
      5200FFBB8C00FBF0EE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DED6D100F3EFED00FFFF
      FF00FEFEFE00FBFAF900F3F0ED00F7F6F700EEECE900D8D0C600C0B0A100AA93
      80009179630079635100745D4D007B6551007D6451005D4A3D00312920001F1C
      140024201800221F17001C191200221A13006D615800D5CDC100D8CDC300DBD2
      C900EDE8E400000000000000000000000000FFF5F300FFC5A200FF9D5000FF9F
      5500FF9B5400FF954C00F98B3E00FE7E3700FE7F3800FA7D3800FE803700C566
      3A00967F75009C928F00CCC3C200B1ADAA008B837F009E898100CA7B4600FE93
      4300FB8F4700FE8F4800FB8F4500F78C4100DC793900AD532000AE744C008691
      B7006D8DA400CECDC900E8F3F600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E5E1DC00F6F5F300FEFE
      FE00FEFEFE00FFFFFF00FDFDFC00EEE8E500CBBEB400AD9C880097826A00866D
      56007761500077624F0077614E00625140003F342800221D1700211E16002723
      1A001E1B13002D271E004F453B00978A8100D5C7BA00DCD5CC00EDE8E400DBCF
      C900000000000000000000000000000000000000000000000000F8E7D700EBC8
      AB00E2AF8100F58E4700FF944A00FF884100FE7F3B00FD7F3E00FF7D3400C893
      760064615F004A302900BFA898008D7B6F002C1811008D706000DF946500F784
      3900FA8D4200FC8C4200FF904200F6853F00A6542700A0411100555C64001D98
      E1000C679C004E668000D9D1DC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEE9E600FFFF
      FF00FDFDFD00FCFCFC00FEFEFE00E2DAD800A58E7A008F765D007D644F00745E
      4C007A66500078624E004D3F3100221C16001F1C140025211900242018001A16
      0E002F271F0093847900D3C4BA00CEC2B900D0C4BB00CEC3B800CEC4B9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFDFD300C6774900CE683000FB8A4400FE792A00FD722500FB732300F486
      440074432D0046444000B8A89F00807169003A2C2F00803C1700FF833600F787
      4100FF893C00FC853700FA7C3D00FD883A00FF983E00FF8132005C6979002599
      D500186D9B0006478500B0B4E100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E2DBD600F4F2
      F000FDFDFD00FAFAFA00FBFBFB00F8F7F700B1A499006E5845007A6450007C65
      5200614F4000332B2200201C15002521190026221A001C191100221C15006257
      5000BAACA300D5C9C000CFC3BC00D0C4BC00CEC2BB00CFC2BB00EDE8E5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ECCDBE00F3AD8400FCB68A00FECAAC00FDD0B900FAC4A800FF90
      4E007736150054525200A5948A0074655C00372B30008B431E00FF7E3200FF82
      36008D4D260050707F007AA5D00061839B00697274006A9DB2001D89C6002588
      C6001E71A800095C87004889D800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2DB
      D400F7F4F400FAF9FB00FAFAFA00FCFCFC00FAFAFA00A89C9200634F3E004336
      2C0025201900211D150026221A00211D15001B171000463E35009E928600D5C8
      BF00D3C7C000CDC1B900CFC3BA00CEC2BA00D1C5BC00D1C7BC00E2D9D4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000074422B00494645009C958D00847A740038292B004B434000D67F4D00F986
      3B005C5253000199DC0027DAFF001291CE000B67A0001CBFFD002792C9001AAC
      EB001BA8E600116296002B85C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDAD200F4F2F100F8F6F500FBFAFA00FBFBFB00FFFFFF009E9893002019
      11001B170F00221E16001B170F00312A220081746D00CBBEB400D6CBC200CDC2
      BA00CEC2B900D1C6BC00D4CABF00D7CFC400DAD2CA00E0D9D000DDD4CD00F1EE
      EB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000927A7500A3847B00D6C2B400D2C1B800A37A61002B6E910033C3F70044C2
      EA000DB0F50005BFFF0002BAFF0010BAFB0029B3E90039D1FC0027C7FD0010B9
      FB0020BBF30030B4E5002CAADC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DCD5CD00ECE7E200F4F1EF00F9F8F800FDFEFE00FFFFFF00C3C0
      BB00453E36002B271F0060544B00B8ABA000DACEC600D1C5BE00D0C4BB00D5CA
      C100D9D0C700DCD3CB00DFD8D000E2DBD500E5DDD700E8E0DB00E9E5E100E8E3
      DC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D0DDDA0087A9A2008F8F8500858D8A008990A2003BA7E30014C4FE000EB5
      F900288CD40077B2D20066A3C800228ED30016C2FF001CC0FE001BC1FF0013B7
      F9003ABFEE0064E2FD0089E4FD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DDD6CE00DFD9D200EDE9E500F1EEEA00EFECE800EFEA
      E400CEC6BD00DDDAD600DED8D200DBCEC500D8D0C900DDD5CD00DFD8D000E1DC
      D300E4DFD700E7E3DC00EAE7E000EEE7E500EFEAE800F1EEED00F5F4F200F2F0
      EE00F5F4F2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003187CD00129FDD0000B7FF0005BEFF0005C3FF00729E
      E00064505100B9B2AC008F6758002D698D003DE0FF0046D4FB0035D0FE0009B4
      F90063A7C3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DAD3CB00D8CEC300DBD2C900CFC4B900D3CA
      C100CEC1B400F4EFEF00E0D8D300D4CAC200E0D9D000E1DBD400E4DED700E6E0
      DB00E8E4DE00EDE7E400EEEAE700F1EDEC00F4EFEF00F6F6F400FAF9F800F5F3
      F200EFEBE9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000048B5E1004EBD
      EF003C556600BBACA30093746C003B789B0085DCEE0000000000000000000000
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
      0000E5DEDA00D5CAC200E2DBD400EDEAE700E5DED800EBE5E200EDEAE500F0EA
      EA00F3EFED00F5F3F200F7F4F500F9F8F800FDFDFD00FBFBFA00F2EFED00F2F1
      ED00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007D777200B5A9A0009C898300786F6C000000000000000000000000000000
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
      000000000000000000000000000000000000EAE4E200F1EDED00F5F2F000F7F6
      F600F9F8F700FBFAF900FDFDFD00FDFCFC00F5F2F100F0EDEB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C3BDBA00BEB1AA00BFB3AC00D8D4D0000000000000000000000000000000
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
      000000000000000000000000000000000000F3F1EF00F3EFEE00FEFDFD00FCFC
      FC00FEFFFF00FFFFFF00F8F6F500F0ECEB00F5F1F00000000000000000000000
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
      00000000000000000000000000000000000000000000F1EEEB00FDFEFD00FFFF
      FF00FBFAFA00F2EFEC00F2EFED00000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000F5F3F200F7F3F200F7F5
      F400F1EEEC000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000EFE8E400EEE9
      E600000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000200000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF00FFE7F9FFFFFFFFFF0000000000000000
      FFC3E0FFFFFFFFFF0000000000000000FF81C07FFFFFFFFF0000000000000000
      FE00003FFFE1FFFF0000000000000000FC00001FFFE01FFF0000000000000000
      F000001FFF00007F0000000000000000E000000FE000001F0000000000000000
      C0000007C000000F0000000000000000C0000007C00000070000000000000000
      C0000003C00000030000000000000000E0000003800000010000000000000000
      F0000003800000010000000000000000E0000003800000010000000000000000
      C000000300000001000000000000000080000007000000010000000000000000
      8000000F0000000300000000000000008000000F000000030000000000000000
      800000070000000100000000000000008000000FC00000010000000000000000
      C000001FF00000010000000000000000C000001FF80000010000000000000000
      E000001FFFF000010000000000000000F000000FFFF000010000000000000000
      F800000FFFF000010000000000000000FC000007FFFC00070000000000000000
      FE000007FFFFC07F0000000000000000FFF0000FFFFFF0FF0000000000000000
      FFFF003FFFFFF0FF0000000000000000FFFF007FFFFFFFFF0000000000000000
      FFFF81FFFFFFFFFF0000000000000000FFFF87FFFFFFFFFF0000000000000000
      FFFFCFFFFFFFFFFF000000000000000000000000000000000000000000000000
      000000000000}
  end
  object PlanMenu: TPopupMenu
    Left = 64
    Top = 216
    object MenuItem1: TMenuItem
      Action = PlanAddNode
    end
    object MenuItem2: TMenuItem
      Action = AnalogDeleteNode
    end
    object MenuItem3: TMenuItem
      Action = AnalogModNode
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N9: TMenuItem
      Action = AnalogCollapse
    end
    object N10: TMenuItem
      Action = AnalogExpand
    end
  end
  object ReportMenu: TPopupMenu
    Left = 144
    Top = 144
    object MenuItem4: TMenuItem
      Action = ReportAddNode
    end
    object MenuItem5: TMenuItem
      Action = ReportDeleteNode
    end
    object MenuItem6: TMenuItem
      Action = ReportModNode
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = ReportDesignAction
    end
    object SQL1: TMenuItem
      Action = ReportSQL
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Action = ReportCollapse
    end
    object N11: TMenuItem
      Action = ReportExpand
    end
  end
  object AnalogfrxReport: TfrxReport
    Version = '4.7.61'
    DotMatrixReport = False
    IniFile = '\MD\REPOS'
    PreviewOptions.Buttons = [pbPrint, pbZoom, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'chudnikau'
    ReportOptions.CreateDate = 40246.832902557900000000
    ReportOptions.LastChange = 40403.526633564810000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = AnalogfrxReportBeforePrint
    OnUserFunction = AnalogfrxReportUserFunction
    Left = 392
    Top = 208
  end
  object RxArchiveDisplayParams: TRxMemoryData
    FieldDefs = <
      item
        Name = 'paramquery_id'
        DataType = ftInteger
      end
      item
        Name = 'BooShowSeries'
        DataType = ftBoolean
      end
      item
        Name = 'OrderNumber'
        DataType = ftInteger
      end
      item
        Name = 'color'
        DataType = ftInteger
      end
      item
        Name = 'paramquery_name'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'MeterName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SPParam'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Canal'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'lvalue'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'hvalue'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'unitSN'
        DataType = ftString
        Size = 20
      end>
    Left = 232
    Top = 160
    object RxArchiveDisplayParamsParamqueryId: TIntegerField
      FieldName = 'paramquery_id'
      Visible = False
    end
    object RxArchiveDisplayParamsBooShowSeries: TBooleanField
      DisplayLabel = ' '
      FieldName = 'BooShowSeries'
    end
    object RxArchiveDisplayParamsOrderNumber: TIntegerField
      DisplayLabel = #8470' '#1087'.'#1087'.'
      DisplayWidth = 5
      FieldName = 'OrderNumber'
      Visible = False
    end
    object RxArchiveDisplayParamscolor: TIntegerField
      DisplayLabel = ' '
      FieldName = 'color'
    end
    object paramquery_name: TStringField
      DisplayLabel = #1053#1072#1079#1074'. '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      FieldName = 'paramquery_name'
      Size = 255
    end
    object DeviceName: TStringField
      DisplayLabel = #1057#1095#1077#1090#1095#1080#1082
      FieldName = 'MeterName'
      Visible = False
    end
    object SPParam: TStringField
      DisplayLabel = #1060#1080#1079#1080#1095'. '#1087#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'SPParam'
      Visible = False
    end
    object Canal: TStringField
      DisplayLabel = #1058#1088#1091#1073
      FieldName = 'Canal'
      Visible = False
    end
    object Description: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'Description'
    end
    object RxArchiveDisplayParamslvalue: TStringField
      DisplayLabel = #1052#1080#1085'. '#1079#1085#1072#1095'.'
      FieldName = 'lvalue'
    end
    object RxArchiveDisplayParamshvalue: TStringField
      DisplayLabel = #1052#1072#1082#1089'. '#1079#1085#1072#1095'.'
      FieldName = 'hvalue'
    end
    object unitSN: TStringField
      DisplayLabel = #1045#1076'. '#1080#1079#1084#1077#1088'.'
      FieldName = 'unitSN'
      Visible = False
    end
  end
  object frxDisplayParams: TfrxDBDataset
    UserName = 'frxDisplayParams'
    CloseDataSource = False
    FieldAliases.Strings = (
      'paramquery_id=paramquery_id'
      'BooShowSeries=BooShowSeries'
      'OrderNumber=OrderNumber'
      'color=color'
      'paramquery_name=paramquery_name'
      'MeterName=MeterName'
      'SPParam=SPParam'
      'Canal=Canal'
      'Description=Description'
      'unitSN=unitSN'
      'lvalue=lvalue'
      'hvalue=hvalue')
    DataSet = RxArchiveDisplayParams
    BCDToCurrency = False
    Left = 272
    Top = 232
  end
  object dtsRxDisplayParams: TDataSource
    DataSet = RxArchiveDisplayParams
    Left = 576
    Top = 208
  end
  object TreeManage: TImageList
    Left = 704
    Top = 120
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005D5D5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000C0C0C0008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00B6B6B6006A6A6A004F4F510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000C0C0
      C000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00B6B6B600BBBBBB00B3B3B300B6B6B6006F6F6F005A5A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000C0C0C0008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00B6B6B600BBBBBB00B7B7B700B3B3B300AEAEAE00B6B6B600B6B6B6007373
      7400646464000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080000000C0C0C000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003E586F00B6B6
      B600BBBBBB00B7B7B700B3B3B300ACACAC009F9F9F009898980074747400B6B6
      B6007B7B7C000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000FFFFFF008080800080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000028450025AAFF008C8C
      8C00B7B7B700B3B3B300AEAEAE00888888004E4E4E004F4F4F00373737004A4A
      4A0000000000000000000000000000000000000000000000000080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B4A71001D587D000F48
      6C003A6E8F0082828200A9A9A9007E7E7E00393939002B2B2B00232323000909
      0900000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000001653
      7900114E74000741660033668600444444003131310013131300000000000000
      00000090C40000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000A49710007466D00012E4E000F3C5C00060606000086AF000079
      AB00009CD100007AAD001C3B48000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000001416A000000000000313F00006C9200005C
      8100000000003C6D7B002A2A2A000808080000000000C0C0C000FFFFFF00FFFF
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000313F00008EB8000E41
      5900000000004B4B4B003B3B3B000E0E0E0000000000C0C0C000FFFFFF00FFFF
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000156E89006161
      6100545454006868680032323200000000000000000000000000FFFFFF00FFFF
      FF00FFFF0000FFFF0000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006C6C6C00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFDFFFFF3FFFFFFFFF87FFFE1
      FFFFFFFFF01FFFC1FFFFFFFFE007FF83FC7FFFFFC003F007FC7FFFFF8003C00F
      FC7FFFFF0007801FE00FE0070007801FE00FE0078001000FE00FE007E000000F
      FC7FFFFFF800000FFC7FFFFFFE00000FFC7FFFFFFF80801FFFFFFFFFFF80801F
      FFFFFFFFFFF7C03FFFFFFFFFFFFFF0FF00000000000000000000000000000000
      000000000000}
  end
  object ExportMenu: TPopupMenu
    Left = 48
    Top = 120
    object BMP1: TMenuItem
      Caption = 'BMP'
      OnClick = BMP1Click
    end
    object JPEG1: TMenuItem
      Caption = 'JPEG'
      OnClick = JPEG1Click
    end
    object TIFF1: TMenuItem
      Caption = 'TIFF'
      OnClick = TIFF1Click
    end
    object WORD1: TMenuItem
      Caption = 'WORD'
      OnClick = WORD1Click
    end
    object TEXT1: TMenuItem
      Caption = 'TEXT'
      OnClick = TEXT1Click
    end
    object XLS1: TMenuItem
      Caption = 'XLS'
      OnClick = XLS1Click
    end
    object XML1: TMenuItem
      Caption = 'XML'
      OnClick = XML1Click
    end
    object PDF1: TMenuItem
      Caption = 'PDF'
      OnClick = PDF1Click
    end
    object ODS1: TMenuItem
      Caption = 'ODS'
      OnClick = ODS1Click
    end
    object ODT1: TMenuItem
      Caption = 'ODT'
      OnClick = ODT1Click
    end
    object HTML1: TMenuItem
      Caption = 'HTML'
      OnClick = HTML1Click
    end
  end
  object ImageList: TImageList
    Left = 752
    Top = 176
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000090004F694731FF6947
      31FF694731FF694731FF694731FF694731FF694731FF694731FF694731FF6947
      31FF694731FF694731FF694731FF0090004F0000000000000000000000000000
      00000000000000000000FFA0A000FF7E7E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009300FFFFFFFFFF0075
      00FF007900FF007C00FF008000FF008300FF008600FF008A00FF008F00FF0094
      00FF009800FF009800FF009800FF694731FF0000000000000000000000000000
      0000FFF3F300FF515100CD000000FF3939000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009200FFFFFFFFFF40C1
      5DFF37B94FFF2BAD3EFF20A12FFF1A9E26FF12951BFF0E9414FF0A9A0FFF0399
      05FF009800FF009800FF009800FF694731FF000000000000000000000000FFB5
      B500FE000000DA000000DE000000FE000000FF757500FFB2B200FFF8F8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009200FFFFFFFFFF48C6
      69FF3EBE5AFFFFFFFFFF1F982DFFFFFFFFFFFFFFFFFF56CE7DFF0E9615FF0A9A
      0FFF039905FF009800FF009800FF694731FF0000000000000000FF878700FF2B
      2B00FF333300FF232300FF1E1E00FF252500FF1A1A00FF030300FF151500FFA9
      A900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009100FFFFFFFFFF50CB
      74FF46C366FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF56CE7DFF0F98
      16FF0A9A0FFF039905FF009400FF694731FF0000000000000000FFDCDC00FF67
      6700FF757500FF9A9A00FF939300FF6B6B00FF5B5B00FF717100FF757500FF34
      3400FF8F8F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009100FFFFFFFFFF58D0
      80FF4EC871FFFFFFFFFFFFFFFFFFFFFFFFFF1F982DFF20A02EFFFFFFFFFF56CE
      7DFF109A16FF0B9D0FFF009000FF694731FF0000000000000000000000000000
      0000FFAAAA00FF616100FFBBBB00FF646400FFD9D900FF909000FF585800FF98
      9800FF555500FFDDDD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF58D0
      7FFF55CC7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF27A639FF23A733FFFFFF
      FFFF17A222FF12A119FF008C00FF694731FF0000000000000000FF989800FF98
      980000000000FFEAEA00FF656500FF6D6D00000000000000000000000000FF8E
      8E00FF636300FF9B9B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF57CE
      7EFF51C775FF4BBF6DFF47BF67FF3EB85BFF2FA845FF269E37FF229C30FF20A0
      2EFF1FA82DFF19A725FF008700FF694731FF0000000000000000FF737300DD00
      0000FFCACA0000000000FFFBFB00FFFAFA00FF6B6B00FF848400000000000000
      0000FF7E7E00FF93930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF57CF
      7FFFFFFFFFFF4BBF6CFF48BC69FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF259F
      35FF29AE3BFF21AD30FF008300FF694731FF0000000000000000FFBBBB00FE00
      0000E1000000FF626200FFDBDB0000000000FF393900D0000000FF363600FFE8
      E80000000000FFF4F40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF58D0
      80FF99E3B1FFFFFFFFFF48BC69FF40B15DFFFFFFFFFFFFFFFFFFFFFFFFFF2AA2
      3DFF30B245FF2CB440FF007F00FF694731FF000000000000000000000000FF52
      5200FF3A3A00FF101000F0000000FF1A1A00FF000000FC000000FA000000FD00
      0000FFA2A2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF58D0
      80FF58D080FF99E3B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF34AC
      4CFF38B851FF34B94BFF007C00FF694731FF000000000000000000000000FFF7
      F700FF656500FF4F4F00FF676700FF585800FF464600FF333300FF313100FF45
      4500FF333300FF7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF58D0
      80FF58D080FF58D080FF99E3B1FFFFFFFFFFFFFFFFFF4CC06EFFFFFFFFFF45BF
      65FF42C060FF3CBE57FF007700FF694731FF0000000000000000000000000000
      000000000000FFC6C600FF767600FF626200FF636300FF8C8C00FF939300FF65
      6500FF757500FFECEC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFF58D0
      80FF58D080FF58D080FF58D080FF57CF7EFF56CD7DFF56CD7DFF57CF7EFF53CC
      78FF4BC86EFF44C363FF007200FF694731FF0000000000000000000000000000
      000000000000000000000000000000000000FF757500FFA6A600FF636300FFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF694731FF0000000000000000000000000000
      000000000000000000000000000000000000FF7E7E00FF7A7A00FFF4F4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000090004F009000FF0090
      00FF009000FF009000FF009000FF009000FF009000FF009000FF009000FF0091
      00FF009100FF009200FF009200FF0090004F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF000000008000FCFF00000000
      8000F0FF000000008000E01F000000008000C00F000000008000C00700000000
      8000F003000000008000C8E3000000008000C433000000008000C10B00000000
      8000E007000000008000E003000000008000F803000000008000FF0F00000000
      8000FF1F000000008000FFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object OpenDialog: TOpenDialog
    Left = 600
    Top = 288
  end
end
