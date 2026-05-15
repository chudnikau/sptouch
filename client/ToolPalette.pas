{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ToolPalette;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SPTForm, ExtCtrls, dxsbar, bsSkinCtrls, ComCtrls,
  ImgList, ButtonGroup, PluginContainer, MdExtCtrls, CategoryButtons,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxSplitter, cxContainer, cxTreeView, cxCustomData,
  cxStyles, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer;

type
  TPluginDLLHandleArray = array of THandle;

  TToolPalette = class(TSPTForm)
    ImageList: TImageList;
    dxSideBar: TdxSideBar;
    MdSplitter1: TMdSplitter;
    PluginHelp: TLabel;
    cxTreeList1: TcxTreeList;
    BtnAddDiagram: TSpeedButton;
    BtnDelDiagram: TSpeedButton;
    BtnModDiagram: TSpeedButton;
    procedure dxSideBarItemClick(Sender: TObject; Item: TdxSideBarItem);
    procedure dxSideBarDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  public
    PluginDLLHandleArray: TPluginDLLHandleArray;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
   end;

var
  FToolPalette: TToolPalette = nil;

implementation

uses globalvars, PluginCore, FileUtils, PluginUtils;

{$R *.dfm}

constructor TToolPalette.Create(AOwner: TComponent);
var
  PluginContainer: TProcPluginContainer;
  CategoryList: TProcCategoryList;
  i: Integer;
  PluginClass: TPersistentClass;
  PluginFileList: TStringList;
  CategoryDLLHandle, PluginDLLHandle: THandle;
  Glyph: TBitmap;
begin
  inherited Create(AOwner);
  ImageList.Clear;
  //категории плагинов из библиотеки
  CategoryDLLHandle := LoadLibrary('.\plugins\' + PLUGIN_CAT);
  try
    @CategoryList := GetProcAddress(CategoryDLLHandle, 'CategoryList');
    ASSERT(Assigned(CategoryList));
    for i := 0 to CategoryList.Count - 1 do
      dxSideBar.Groups.Add.Caption := CategoryList[i];
  finally
    FreeLibrary(CategoryDLLHandle);
  end;
  //плагины из библиотек
  PluginFileList := TStringList.Create;
  try
    FileList('.\plugins\*.' + IntToStr(GetCurrentPluginVersion), PluginFileList);
    SetLength(PluginDLLHandleArray, PluginFileList.Count);
    for i := 0 to PluginFileList.Count - 1 do
    begin
      PluginDLLHandle := LoadLibrary(PChar('.\plugins\' + PluginFileList[i]));
      PluginDLLHandleArray[i] := PluginDLLHandle;
      @PluginContainer := GetProcAddress(PluginDLLHandle, 'PluginContainer');
      ASSERT(Assigned(PluginContainer));
      PluginClass := GetClass(PluginContainer.Plugin.ClassName);
      ASSERT(Assigned(PluginClass) and Assigned(PluginClass.GetInterfaceEntry(IProperty)));
      with dxSideBar.Groups[PluginContainer.CategoryIndex].Items.Add do
      begin
        Caption := PluginContainer.Title;
        ItemObject := PluginContainer;
        Glyph := TBitmap.Create;
        try
          PluginContainer.PreviewGlyph(PluginContainer.PreviewFileName, Glyph);
          LargeImage := ImageList.Add(Glyph, nil);
        finally
          Glyph.Free;
        end;
      end;
    end;
  finally
    PluginFileList.Free;
  end;
end;

destructor TToolPalette.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(PluginDLLHandleArray) do FreeLibrary(PluginDLLHandleArray[i]);
  inherited Destroy;
end;

procedure TToolPalette.dxSideBarDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
 Accept := False;
end;

procedure TToolPalette.dxSideBarItemClick(Sender: TObject;
  Item: TdxSideBarItem);
begin
  PluginHelp.Caption := TPluginContainer(Item.ItemObject).HelpText;
end;

end.
