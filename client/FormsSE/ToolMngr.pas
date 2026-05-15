unit ToolMngr;

interface

{$IFNDEF VER80}                { DELPHI 1.0     }
 {$IFNDEF VER90}               { DELPHI 2.0     }
  {$IFNDEF VER93}              { C++Builder 1.0 }
   {$IFNDEF VER100}            { DELPHI 3.0     }
    {$IFNDEF VER110}           { C++Builder 3.0 }
     {$IFNDEF VER120}          { DELPHI 4.0 }
      {$IFNDEF VER125}         { C++Builder 4.0 }
       {$IFNDEF VER130}        { DELPHI/C++Builder 5.0 }
         {$DEFINE DELPHI6_UP}
       {$ENDIF}
      {$ENDIF}
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Menus;

const
  DefaultDockWidth   = 210;
  DefaultDockHeight  = 120;

type
  {$IFDEF VER120}
  TWMContextMenu = packed record
    Msg: Cardinal;
    hWnd: HWND;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint);
      1: (
        Pos: TSmallPoint;
        Result: Longint);
  end;
  {$ENDIF}

  TToolContainer = class;

  TFormDockSites = class
  private
    FOwner: TCustomForm;
    FOnDockDrop: TNotifyEvent;
  protected
    procedure RightDockPanelDockOver(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure BottomDockPanelDockOver(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure DockPanelDockDrop(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer);
    procedure DockPanelUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure DockPanelGetSiteInfo(Sender: TObject;
      DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
      var CanDock: Boolean);
  public
    BottomDockPanel: TPanel;
    HSplitter: TSplitter;
    RightDockPanel: TPanel;
    VSplitter: TSplitter;
    constructor Create(AOwner: TCustomForm);
    procedure ShowDockPanel(APanel: TPanel; MakeVisible: Boolean;
      Client: TControl);
    property  Owner: TCustomForm read FOwner;
    property  OnDockDrop: TNotifyEvent read FOnDockDrop write FOnDockDrop;
  end;


  TToolContainer = class(TForm)
    pgTools: TPageControl;
    pmTools: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure pgToolsGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure pgToolsUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure pgToolsDockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
  private
    { Private declarations }
    FTools: TList;
    FArranging: boolean;
    FDockSites: TFormDockSites;
    FOnNeedClose: TNotifyEvent;
    FOnPopupChange: TNotifyEvent;
    procedure ArrangeTools;
    function  GetPageForm(PageIndex: integer): TCustomForm;
    function  FindPage(ToolForm: TCustomForm): TTabSheet;
    procedure PopupClosePage(Sender: TObject);
    procedure PopupCloseAll(Sender: TObject);
    procedure PopupToolClick(Sender: TObject);
    procedure DoToolsPopup(Sender: TObject; MousePos: TPoint);
    function  GetActivePageForm: TCustomForm;
    procedure SetActivePageForm(const Value: TCustomForm);
    function  GetTool(Index: integer): TCustomForm;
    function  GetToolCount: integer;
    function  ComputeDockingRect(var DockRect: TRect; MousePos: TPoint): TAlign;
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
  protected
    procedure DoPopupChange; virtual;
  public
    { Public declarations }
    procedure InitDockSites(ADockSites: TFormDockSites);
    procedure InsertTool(ToolForm: TCustomForm);
    procedure RemoveTool(ToolForm: TCustomForm);
    procedure RemoveAll;
    function  IsToolExists(ToolForm: TCustomForm): boolean;
    property  Tools[Index: integer]: TCustomForm read GetTool;
    property  ToolCount: integer read GetToolCount;
    property  DockSites: TFormDockSites read FDockSites;
    property  ActivePageForm: TCustomForm read GetActivePageForm
      write SetActivePageForm;
    property  OnNeedClose: TNotifyEvent read FOnNeedClose write FOnNeedClose;
    property  OnPopupChange: TNotifyEvent read FOnPopupChange
      write FOnPopupChange;
  end;

var
  ToolForms: TList;
  ToolContainer: TToolContainer;

procedure RegisterToolForm(ToolForm: TCustomForm);
procedure UnRegisterToolForm(ToolForm: TCustomForm);

function  FindChildContainer(Control: TWinControl): TToolContainer;
function  FindToolParentContainer(ToolForm: TCustomForm): TToolContainer;
function  FindToolForm(const AName: string): TCustomForm;

implementation

{$R *.DFM}

function FindToolParentContainer(ToolForm: TCustomForm): TToolContainer;
var Control: TControl;
begin
 Result := Nil;
 if not Assigned(ToolForm) then exit;
 Control := ToolForm.Parent;
 while Assigned(Control) do
  if Control is TToolContainer then begin
   Result := TToolContainer(Control);
   break;
  end else
   Control := Control.Parent;
end;

function FindChildContainer(Control: TWinControl): TToolContainer;
var i: integer;
begin
 Result := Nil;
 with Control do
 for i:=0 to ControlCount-1 do
  if Controls[i] is TToolContainer then begin
   Result := TToolContainer(Controls[i]);
   break;
  end;
end;

function FindToolForm(const AName: string): TCustomForm;
var i: integer;
begin
 Result := Nil;
 for i:=0 to ToolForms.Count-1 do
  if TCustomForm(ToolForms[i]).Name = AName then begin
   Result := TCustomForm(ToolForms[i]);
   break;
  end;
end;

procedure RegisterToolForm(ToolForm: TCustomForm);
begin
 if not Assigned(ToolForms) then ToolForms := TList.Create;
 TForm(ToolForm).DragKind := dkDock;
 ToolForms.Add(ToolForm);
end;

procedure UnRegisterToolForm(ToolForm: TCustomForm);
var Container: TToolContainer;
begin
 if Assigned(ToolForms) then begin
  ToolForms.Remove(ToolForm);
  if ToolForms.Count = 0 then
   {$IFDEF VER120}
   begin
    ToolForms.Free;
    ToolForms := Nil;
   end;
   {$ELSE}
   FreeAndNil(ToolForms);
   {$ENDIF}
 end;
 Container := FindToolParentContainer(ToolForm);
 if Assigned(Container) then Container.RemoveTool(ToolForm);
end;

// TFormDockSites /////////////////////////////////////////////////////////////

constructor TFormDockSites.Create(AOwner: TCustomForm);
begin
  FOwner := AOwner;
  RightDockPanel := TPanel.Create(AOwner);
  with RightDockPanel do begin
    Align := alRight;
    Width := 0;
    Caption := '';
    DockSite := True;
    BevelOuter := bvNone;
    Parent := AOwner;
    OnDockDrop := DockPanelDockDrop;
    OnDockOver := RightDockPanelDockOver;
    OnGetSiteInfo := DockPanelGetSiteInfo;
    OnUndock := DockPanelUndock;
  end;
  VSplitter := TSplitter.Create(AOwner);
  with VSplitter do begin
    Align := alRight;
    Width := 4;
    Visible := False;
    {$IFDEF DELPHI6_UP}
    AutoSnap := False;
    {$ENDIF}
    Parent := AOwner;
    Color := clBtnFace;
  end; 
  BottomDockPanel := TPanel.Create(AOwner);
  with BottomDockPanel do begin
    Align := alBottom;
    Height := 0;
    Caption := '';
    Parent := AOwner;
    BevelOuter := bvNone;
    DockSite := True;
    OnDockDrop := DockPanelDockDrop;
    OnDockOver := BottomDockPanelDockOver;
    OnGetSiteInfo := DockPanelGetSiteInfo;
    OnUndock := DockPanelUndock;
  end;
  HSplitter := TSplitter.Create(AOwner);
  with HSplitter do begin
    Align := alBottom;
    Height := 4;
    Visible := False;
    {$IFDEF DELPHI6_UP}
    AutoSnap := False;
    {$ENDIF}
    Parent := AOwner;
  end;
end;

procedure TFormDockSites.DockPanelDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  //OnDockDrop gets called AFTER the client has actually docked,
  //so we check for DockClientCount = 1 before making the dock panel visible.
  if (Sender as TPanel).DockClientCount = 1 then begin
    ShowDockPanel(Sender as TPanel, True, nil);
  end;
  (Sender as TPanel).DockManager.ResetBounds(True);
  //Make DockManager repaints it's clients.
  if Assigned(FOnDockDrop) then FOnDockDrop(Self);
end;

procedure TFormDockSites.DockPanelGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  //if CanDock is true, the panel will not automatically draw the preview rect.
  CanDock := DockClient is TToolContainer;
end;

procedure TFormDockSites.DockPanelUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  //OnUnDock gets called BEFORE the client is undocked, in order to optionally
  //disallow the undock. DockClientCount is never 0 when called from this event.
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, False, nil);
end;

procedure TFormDockSites.RightDockPanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := Source.Control is TToolContainer;
  if Accept then
    with RightDockPanel do begin
      // Modify the DockRect to preview dock area.
      ARect.TopLeft := ClientToScreen(Point(-DefaultDockWidth, 0));
      ARect.BottomRight := ClientToScreen(Point(Width, Height));
      Source.DockRect := ARect;
    end;
end;

procedure TFormDockSites.BottomDockPanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := Source.Control is TToolContainer;
  if Accept then
    with BottomDockPanel do begin
      // Modify the DockRect to preview dock area.
      ARect.TopLeft := ClientToScreen(Point(0, -DefaultDockHeight));
      ARect.BottomRight := ClientToScreen(Point(Width, Height));
      Source.DockRect := ARect;
    end;
end;

procedure TFormDockSites.ShowDockPanel(APanel: TPanel; MakeVisible: Boolean;
  Client: TControl);

  function GetVisibleDockClientCount: integer;
  {$IFNDEF DELPHI6_UP}
  var i: integer;
  {$ENDIF}
  begin
    {$IFDEF DELPHI6_UP}
    Result := APanel.VisibleDockClientCount;
    {$ELSE}
    Result := APanel.DockClientCount;
    if Result > 0 then
      for i:=Result - 1 downto 0 do
        if not TControl(APanel.DockClients[i]).Visible then Dec(Result);
    {$ENDIF}
  end;

begin
  //Client - the docked client to show if we are re-showing the panel.
  //Client is ignored if hiding the panel.

  //Since docking to a non-visible docksite isn't allowed, instead of setting
  //Visible for the panels we set the width to zero. The default InfluenceRect
  //for a control extends a few pixels beyond it's boundaries, so it is possible
  //to dock to zero width controls.

  //Don't try to hide a panel which has visible dock clients.
  if not MakeVisible and (GetVisibleDockClientCount > 1) then
    Exit;

  if APanel = RightDockPanel then
    VSplitter.Visible := MakeVisible
  else
    HSplitter.Visible := MakeVisible;

    if MakeVisible then
      if APanel = RightDockPanel then
      begin
        APanel.Width := DefaultDockWidth;
        VSplitter.Left := FOwner.ClientWidth - APanel.Width + VSplitter.Width;
      end
      else begin
        APanel.Height := DefaultDockHeight; 
        HSplitter.Top := FOwner.ClientHeight - APanel.Height - HSplitter.Width;
      end
    else
      if APanel = RightDockPanel then
        APanel.Width := 0
      else
        APanel.Height := 0;
  if MakeVisible and (Client <> nil) then Client.Show;
end;

// TToolContainer ///////////////////////////////////////////////////////////

procedure TToolContainer.FormCreate(Sender: TObject);
begin
  FTools := TList.Create;
end;

procedure TToolContainer.FormDestroy(Sender: TObject);
begin
 FTools.Free;
end;

procedure TToolContainer.FormShow(Sender: TObject);
begin
 with pgTools do begin
  Left := -1;
  Top := 0;
  Width := Self.ClientWidth +3;
  Height := Self.ClientHeight +2;
 end;
end;

procedure TToolContainer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FTools.Clear;
  ArrangeTools;
  if Assigned(FDockSites) and (HostDockSite is TPanel) then
    FDockSites.ShowDockPanel(HostDockSite as TPanel, False, nil);
  Action := caFree;
end;

procedure TToolContainer.FormResize(Sender: TObject);
var
  i: integer;
begin
  if FArranging then exit;
  for i:=0 to pgTools.PageCount-1 do
    with GetPageForm(i) do begin
      UndockWidth := pgTools.Pages[i].ClientWidth;
      UndockHeight := pgTools.Pages[i].ClientHeight;
    end;
end;

procedure TToolContainer.DoPopupChange;
begin
 if Assigned(FOnPopupChange) then FOnPopupChange(Self);
end;

function TToolContainer.GetTool(Index: integer): TCustomForm;
begin
 Result := TCustomForm(FTools[Index]);
end;

function TToolContainer.GetToolCount: integer;
begin
 Result := FTools.Count;
end;

procedure TToolContainer.InitDockSites(ADockSites: TFormDockSites);
begin
 FDockSites := ADockSites;
end;

procedure TToolContainer.InsertTool(ToolForm: TCustomForm);
var Container: TToolContainer;
begin
 if not Assigned(ToolForm) or (FTools.IndexOf(ToolForm) >= 0) then exit;
 Container := FindToolParentContainer(ToolForm);
 if Assigned(Container) and (Container <> Self) then
  Container.RemoveTool(ToolForm);
 FTools.Add(ToolForm);
 ArrangeTools;
 DoPopupChange;
 if Assigned(HostDockSite) and (HostDockSite is TPanel) and
    Assigned(TPanel(HostDockSite).DockManager) then
   TPanel(HostDockSite).DockManager.ResetBounds(True);
end;

procedure TToolContainer.RemoveTool(ToolForm: TCustomForm);
begin
 FTools.Remove(ToolForm);
 ArrangeTools;
 if (FTools.Count = 0) and Assigned(FOnNeedClose) then FOnNeedClose(Self);
 if not (csDestroying in ComponentState) then DoPopupChange;
end;

procedure TToolContainer.RemoveAll;
begin
 FTools.Clear;
 ArrangeTools;
 if (FTools.Count = 0) and Assigned(FOnNeedClose) then FOnNeedClose(Self);
 if not (csDestroying in ComponentState) then DoPopupChange;
end;

function TToolContainer.GetPageForm(PageIndex: integer): TCustomForm;
begin
  Result := TCustomForm(pgTools.Pages[PageIndex].Controls[0]);
end;

function TToolContainer.FindPage(ToolForm: TCustomForm): TTabSheet;
var i: integer;
begin
 Result := Nil;
 for i:=0 to FTools.Count-1 do
  if GetPageForm(i) = ToolForm then begin
   Result := pgTools.Pages[i];
   break;
  end;
end;

procedure TToolContainer.ArrangeTools;
var i, Index: integer;
    Exists: array of boolean;
    ToolForm: TCustomForm;
    Page: TTabSheet;
begin
 FArranging := True;
 try
  SetLength(Exists, FTools.Count);
  FillChar(Exists[0], Length(Exists) * SizeOf(Exists[0]), 0);
  i := pgTools.PageCount-1;
  while i >= 0 do begin
   ToolForm := GetPageForm(i);
   Index := FTools.IndexOf(ToolForm);
   if Index < 0 then begin
    ToolForm.Hide;
    ToolForm.ManualDock(Nil);
   end else
    Exists[Index] := True;
   dec(i);
  end;
  for i:=0 to Length(Exists)-1 do begin
   if Exists[i] then continue;
   ToolForm := TCustomForm(FTools[i]);
   ToolForm.ManualDock(pgTools, nil, alClient);
   Page := pgTools.Pages[pgTools.PageCount-1];
   if Page.ClientWidth < TForm(ToolForm).Width then
     Width := Width + (TForm(ToolForm).Width - Page.ClientWidth);
   if Page.ClientHeight < TForm(ToolForm).Height then
     Height := Height + (TForm(ToolForm).Height - Page.ClientHeight);
   TForm(ToolForm).UndockWidth := Page.ClientWidth;
   TForm(ToolForm).UndockHeight := Page.ClientHeight;
   Page.TabVisible := True;
   ToolForm.Show;
  end;
 finally
  FArranging := False; 
 end;
end;

function TToolContainer.IsToolExists(ToolForm: TCustomForm): boolean;
begin
 Result := FTools.IndexOf(ToolForm) >= 0;
end;

procedure TToolContainer.PopupClosePage(Sender: TObject);
begin
 RemoveTool(ActivePageForm);
end;

procedure TToolContainer.PopupCloseAll(Sender: TObject);
begin
 RemoveAll;
end;

procedure TToolContainer.PopupToolClick(Sender: TObject);
var ToolForm: TCustomForm;
begin
 if not (Sender is TMenuItem) then exit;
 ToolForm := TCustomForm(TMenuItem(Sender).Tag);
 if IsToolExists(ToolForm) then
  RemoveTool(ToolForm)
 else begin
  InsertTool(ToolForm);
  pgTools.ActivePage := FindPage(ToolForm);
 end;
end;

function TToolContainer.GetActivePageForm: TCustomForm;
begin
 Result := GetPageForm( pgTools.ActivePage.PageIndex );
end;

procedure TToolContainer.SetActivePageForm(const Value: TCustomForm);
begin
 pgTools.ActivePage := FindPage(Value);
end;

procedure TToolContainer.DoToolsPopup(Sender: TObject;
  MousePos: TPoint);
var i: integer;
    pmItem: TMenuItem;
    ToolForm: TCustomForm;
begin
 if not Assigned(ToolForms) or (ToolForms.Count = 0) then exit;
 with pmTools do begin
  {$IFNDEF VER120}
  Items.Clear;
  {$ELSE}
  while Items.Count > 0 do Items.Delete(Items.Count-1);
  {$ENDIF}
  pmItem := TMenuItem.Create(pmTools);
  pmItem.Caption := '&Close';
  pmItem.OnClick := PopupClosePage;
  Items.Add(pmItem);
  pmItem := TMenuItem.Create(pmTools);
  pmItem.Caption := '-';
  Items.Add(pmItem);
  for i:=0 to ToolForms.Count-1 do begin
   ToolForm := TCustomForm(ToolForms[i]);
   pmItem := TMenuItem.Create(pmTools);
   pmItem.Caption := ToolForm.Caption;
   pmItem.OnClick := PopupToolClick;
   pmItem.Tag := integer(ToolForm);
   if IsToolExists(ToolForm) then pmItem.Checked := true;
   Items.Add(pmItem);
  end;
  pmItem := TMenuItem.Create(pmTools);
  pmItem.Caption := '-';
  Items.Add(pmItem);
  pmItem := TMenuItem.Create(pmTools);
  pmItem.Caption := 'Close &All';
  pmItem.OnClick := PopupCloseAll;
  Items.Add(pmItem);
  MousePos := Self.ClientToScreen(MousePos);
  Popup(MousePos.X, MousePos.Y);
 end;
end;

procedure TToolContainer.WMContextMenu(var Message: TWMContextMenu);
var Pt: TPoint;
    i: integer;
    Found: boolean;
begin
 Pt := ScreenToClient(Point(Message.XPos, Message.YPos));
 if PtInRect(pgTools.BoundsRect, Pt) then begin
  dec(Pt.X, pgTools.Left);
  dec(Pt.Y, pgTools.Top);
  Found := False;
  for i:=0 to pgTools.ControlCount-1 do
   if PtInRect(pgTools.Controls[i].BoundsRect, Pt) then begin
    Found := True;;
    break;
   end;
  if Found then
   inherited
  else begin
   DoToolsPopup(pgTools, Pt);
   Message.Result := 1;
  end;
 end else
  inherited;
end;

procedure TToolContainer.FormDockOver(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := Source.Control is TForm;
  //Draw dock preview depending on where the cursor is relative to our client area
  if Accept and
     Assigned(HostDockSite) and
     (ComputeDockingRect(ARect, Point(X, Y)) <> alNone) then
    Source.DockRect := ARect;
end;

function TToolContainer.ComputeDockingRect(var DockRect: TRect;
  MousePos: TPoint): TAlign;
var
  DockTopRect,
  DockLeftRect,
  DockBottomRect,
  DockRightRect,
  DockCenterRect: TRect;
begin
  Result := alNone;
  //divide form up into docking "Zones"
  DockLeftRect.TopLeft := Point(0, 0);
  DockLeftRect.BottomRight := Point(ClientWidth div 5, ClientHeight);

  DockTopRect.TopLeft := Point(ClientWidth div 5, 0);
  DockTopRect.BottomRight := Point(ClientWidth div 5 * 4, ClientHeight div 5);

  DockRightRect.TopLeft := Point(ClientWidth div 5 * 4, 0);
  DockRightRect.BottomRight := Point(ClientWidth, ClientHeight);

  DockBottomRect.TopLeft := Point(ClientWidth div 5, ClientHeight div 5 * 4);
  DockBottomRect.BottomRight := Point(ClientWidth div 5 * 4, ClientHeight);

  DockCenterRect.TopLeft := Point(ClientWidth div 5, ClientHeight div 5);
  DockCenterRect.BottomRight := Point(ClientWidth div 5 * 4, ClientHeight div 5 * 4);

  //Find out where the mouse cursor is, to decide where to draw dock preview.
  if PtInRect(DockLeftRect, MousePos) then
    begin
      Result := alLeft;
      DockRect := DockLeftRect;
      DockRect.Right := ClientWidth div 2;
    end
  else
    if PtInRect(DockTopRect, MousePos) then
      begin
        Result := alTop;
        DockRect := DockTopRect;
        DockRect.Left := 0;
        DockRect.Right := ClientWidth;
        DockRect.Bottom := ClientHeight div 2;
      end
    else
      if PtInRect(DockRightRect, MousePos) then
        begin
          Result := alRight;
          DockRect := DockRightRect;
          DockRect.Left := ClientWidth div 2;
        end
      else
        if PtInRect(DockBottomRect, MousePos) then
          begin
            Result := alBottom;
            DockRect := DockBottomRect;
            DockRect.Left := 0;
            DockRect.Right := ClientWidth;
            DockRect.Top := ClientHeight div 2;
         end
        else
          if PtInRect(DockCenterRect, MousePos) then
          begin
            Result := alClient;
            DockRect := DockCenterRect;
          end;
  if Result = alNone then Exit;

  //DockRect is in screen coordinates.
  DockRect.TopLeft := ClientToScreen(DockRect.TopLeft);
  DockRect.BottomRight := ClientToScreen(DockRect.BottomRight);
end;

procedure TToolContainer.CMDockClient(var Message: TCMDockClient);
var
  ARect: TRect;
  DockType: TAlign;
  Host: TToolContainer;
  Pt: TPoint;
  Container: TToolContainer;
  ToolForm: TForm;
begin
  //Overriding this message allows the dock form to create host forms
  //depending on the mouse position when docking occurs. If we don't override
  //this message, the form will use VCL's default DockManager.

  //NOTE: the only time ManualDock can be safely called during a drag
  //operation is we override processing of CM_DOCKCLIENT.

  //Find out how to dock (Using a TAlign as the result of ComputeDockingRect)
  Pt.x := Message.MousePos.x;
  Pt.y := Message.MousePos.y;
  DockType := ComputeDockingRect(ARect, Pt);

  if Message.DockSource.Control is TToolContainer then begin
    // Container docking //////////////////////////////////////
    Container := TToolContainer(Message.DockSource.Control);
    if DockType <> alClient then begin
      if HostDockSite is TPanel then
        Container.ManualDock(HostDockSite, nil, DockType);
    end else begin
      if HostDockSite is TToolContainer then
        Host := TToolContainer(HostDockSite)
      else
      if (HostDockSite is TPanel) and
         (HostDockSite.ControlCount = 1) and
         (HostDockSite.Controls[0] is TToolContainer) then
        Host := TToolContainer(HostDockSite.Controls[0])
      else
        Host := Nil;
      if Assigned(Host) then begin
        while Container.ToolCount > 0 do
          Host.InsertTool(Container.Tools[0]);
        with Host.pgTools do
          ActivePage := Pages[PageCount-1];
      end;
    end;
  end else
  if Message.DockSource.Control is TForm then begin
    // Form docking //////////////////////////////////////////
    ToolForm := TForm(Message.DockSource.Control);
    if DockType = alClient then begin
      InsertTool(ToolForm);
      pgTools.ActivePage := FindPage(ToolForm);
    end else begin
      // We need create ToolContainer to dock form
      Host := TToolContainer.Create(Application);
      Host.InsertTool(ToolForm);
      Host.Show;
      Host.ManualDock(HostDockSite, nil, DockType);
    end;
  end;
end;

procedure TToolContainer.pgToolsGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock :=
    not Assigned(HostDockSite) and (DockClient is TForm) and
    not (DockClient is TToolContainer);
end;

procedure TToolContainer.pgToolsDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
var
  ToolForm: TForm;
  Page: TTabSheet;
begin
  if FArranging then exit;

  ToolForm := TForm(Source.Control);
  FTools.Add(ToolForm);
  ToolForm.Show;
  Page := FindPage(ToolForm);
  if not Assigned(Page) then exit;
  Page.TabVisible := True;
  pgTools.ActivePage := Page;
  DoPopupChange;
end;

procedure TToolContainer.pgToolsUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
var
  Container: TToolContainer;
  MousePos: TPoint;
begin
  if FArranging then exit;

  if not Assigned(NewTarget) then begin
    // Create new container for tool form
    Container := TToolContainer.Create(Application);
    Container.InsertTool(TForm(Client));
    // Set Container position. We don't really know where the user drops our
    // ToolForm so we just use last mouse position as drop point.
    GetCursorPos(MousePos);
    with Container.ClientToScreen(Point(0, 0)) do begin
      dec(MousePos.X, X - Container.Left);
      dec(MousePos.Y, Y - Container.Top);
    end;
    with TForm(Client) do
      Container.SetBounds(MousePos.X, MousePos.Y, Width, Height);
    Container.Show;
    Allow := False;
  end else
    // Remove undocking tool form from container
    RemoveTool(Client as TForm);

  if (pgTools.DockClientCount = 0) and (NewTarget <> Self) then
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

initialization

finalization
  ToolForms.Free;

end.
