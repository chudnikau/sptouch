{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit APIBalloon;

interface

uses
  Windows,Forms,SysUtils,Messages,Classes,Graphics,Controls,ExtCtrls,CommCtrl;

const
  TTM_SETTITLE=(WM_USER+32);
  TTS_BALLOON=$40;

type
  TBalloonIconType=(bNoIcon,bInfo,bWarning,bError);

  TAPIBalloon=class(TComponent)
  private
    FBalloonHandle:THandle;
    POldWndProc,PNewWndproc:Pointer;
    POldControlWndProc,PNewControlWndProc:Pointer;
    FControlWnd:THandle;
    FControl:TControl;
    FToolInfo:TToolInfo;
    FShowing:boolean;
    FBackGroundColor:TColor;
    FBalloonIcon:TBalloonIconType;
    FTitleText:string;
    FPrompt:TStrings;
    FTextBuffer:string;
    FFont:TFont;
    FTimeOut:Integer;
    FTimer:TTimer;
    FFirstWait:Boolean;
    FShowTime:DWORD;
    FOnClick:TNotifyEvent;
    FAfterShow:TNotifyEvent;
    FBeforeShow:TNotifyEvent;
    FAfterClose:TNotifyEvent;
    FMaxTipWidth:Integer;
    procedure CreateBalloonWnd;
    procedure NewWinProc(var Msg:TMessage);
    procedure SetTitleText(Value:string);
    procedure SetFont(Value:TFont);
    procedure SetMaxTipWidth(Value:integer);
    procedure InitializeBalloon;
    procedure OnTimer(sender:TObject);
    procedure SetPrompt(const Value:TStrings);
    procedure NewControlWndProc(var Msg:TMessage);
    function GetBalloonPos(Control:TControl):TPoint;
  protected
    procedure Notification(AComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure Show(X,Y:integer); overload;
    procedure Show(Control:TControl); overload;
    procedure Close;
    property Showing:boolean read FShowing;
  published
    property BackGroundColor:TColor read FBackGroundColor write FBackGroundColor default clInfoBk;
    property BalloonIcon:TBalloonIconType read FBalloonIcon write FBalloonIcon default BInfo;
    property TimeOut:Integer read FTimeOut write FTimeOut default 5000;
    property Title:string read FTitleText write SetTitleText;
    property Prompt:TStrings read FPrompt write SetPrompt;
    property Font:TFont read FFont write SetFont;
    property MaxTipWidth:integer read FMaxTipWidth write SetMaxTipWidth default -1;

    property AfterShow:TNotifyEvent read FAfterShow write FAfterShow;
    property BeforeShow:TNotifyEvent read FBeforeShow write FBeforeShow;
    property AfterClose:TNotifyEvent read FAfterClose write FAfterClose;
    property OnClick:TNotifyEvent read FOnClick write FOnClick;
  end;

var
  FAPIBalloon : TAPIBalloon;

implementation

function GetLastInputTime:DWORD;
var
  LI:TLastInputInfo;
const
  GetLastInputInfo:function(var plii:TLastInputInfo):BOOL; stdcall=nil;
  function _GetLastInputInfo(var plii:TLastInputInfo):BOOL; stdcall;
  begin
    plii.dwTime:=GetTickCount;
    Result:=plii.cbSize=SizeOf(TLastInputInfo);
  end;
begin
  if not Assigned(GetLastInputInfo) then begin
    GetLastInputInfo:=GetProcAddress(GetModuleHandle(user32),'GetLastInputInfo');
    if not Assigned(GetLastInputInfo) then GetLastInputInfo:=@_GetLastInputInfo;
  end;
  LI.cbSize:=SizeOf(LI);
  GetLastInputInfo(LI);
  Result:=LI.dwTime;
end;

{ TAPIBaloon }

constructor TAPIBalloon.Create(AOwner:TComponent);
begin
  FShowing:=false;
  FBackGroundColor:=clInfoBk;
  FBalloonIcon:=BInfo;
  FMaxTipWidth:=-1;
  FTimeOut:=5000;

  FPrompt:=TStringList.Create;
  FFont:=TFont.Create;
  FFont.Assign(Screen.HintFont);

  PNewControlWndProc:=MakeObjectInstance(NewControlWndProc);
  inherited Create(AOwner);

  if not(csDesigning in ComponentState) then begin
    FTimer:=TTimer.Create(Self.Owner);
    FTimer.Interval:=2000;
    FTimer.OnTimer:=OnTimer;
    FTimer.Enabled:=false;
  end;
  CreateBalloonWnd;
end;

destructor TAPIBalloon.Destroy;
begin
  if FBalloonHandle<>0 then DestroyWindow(FBalloonHandle);
  if Assigned(PNewWndProc) then FreeObjectInstance(PNewWndProc);
  inherited Destroy;
  if Assigned(PNewControlWndProc) then FreeObjectInstance(PNewControlWndProc);
  FFont.Free;
  FPrompt.Free;
end;

procedure TAPIBalloon.NewControlWndProc(var Msg:TMessage);
begin
  Msg.Result:=CallWindowProc(POldControlWndProc,FControlWnd,Msg.Msg,Msg.wParam,Msg.lParam);
  case Msg.Msg of
    WM_WINDOWPOSCHANGED:with PWindowPos(Msg.lParam)^ do begin
        if Flags and(SWP_NOSIZE or SWP_NOMOVE)<>(SWP_NOSIZE or SWP_NOMOVE) then begin
          with GetBalloonPos(FControl) do
            SendMessage(FBalloonHandle,TTM_TRACKPOSITION,0,LParam(MAKELONG(X,Y)));
        end;
      end;
    WM_DESTROY:Close;
  end;
end;

procedure TAPIBalloon.NewWinProc(var Msg:TMessage);
begin
  Msg.Result:=0;
  case Msg.Msg of
    WM_MOUSEACTIVATE:begin
        Msg.Result:=MA_NOACTIVATE;
        Exit;
      end;
    WM_LBUTTONDOWN:
      if Showing then begin
        if Assigned(FOnClick) then FOnClick(self);
        Close;
      end;
    TTM_TRACKACTIVATE:FShowing:=Msg.WParam<>0;
  end;
  Msg.Result:=CallWindowProc(POldWndProc,FBalloonHandle,Msg.Msg,Msg.wParam,Msg.lParam);
end;

procedure TAPIBalloon.SetTitleText(Value:string);
begin
  FTitleText:=Value;
end;

procedure TAPIBalloon.SetFont(Value:TFont);
begin
  FFont.Assign(Value);
end;

procedure TAPIBalloon.SetMaxTipWidth(Value:integer);
begin
  if FMaxTipWidth<>Value then FMaxTipWidth:=Value;
end;

procedure TAPIBalloon.SetPrompt(const Value:TStrings);
begin
  FPrompt.Assign(Value);
end;

procedure TAPIBalloon.Close;
begin
  if FShowing then begin
    if Assigned(FControl) then FControl.RemoveFreeNotification(Self);
    FControl:=nil;
    FTimer.Enabled:=False;
    SendMessage(FBalloonHandle,TTM_TRACKACTIVATE,0,integer(@FtoolInfo));
    if FControlWnd<>0 then SetWindowLong(FControlWnd,GWL_WNDPROC,Integer(POldControlWndProc));
    FControlWnd:=0;
    if (csDestroying in ComponentState) then Exit;
    if Assigned(FAfterClose) then FAfterClose(Self);
  end;
end;

procedure TAPIBalloon.InitializeBalloon;
begin
  if FShowing then Close;
  FTextBuffer:=FPrompt.Text;
  FToolInfo.lpszText:=PChar(FTextBuffer);
  SendMessage(FBalloonHandle,TTM_DELTOOL,0,lparam(@FToolInfo));
  SendMessage(FBalloonHandle,TTM_ADDTOOL,0,lparam(@FToolInfo));
  SendMessage(FBalloonHandle,TTM_SETTIPBKCOLOR,ColorToRgb(FbackGroundColor),0);
  if FTitleText<>'' then SendMessage(FBalloonHandle,TTM_SETTITLE,Ord(FBalloonIcon),lparam(PChar(FTitleText)));
  SendMessage(FBalloonHandle,WM_SETFONT,FFont.Handle,0);
  SendMessage(FBalloonHandle,TTM_SETTIPTEXTCOLOR,ColorToRgb(FFont.Color),0);
  SendMessage(FBalloonHandle,TTM_SETMAXTIPWIDTH,0,LPARAM(FMaxTipWidth));
  if FTimeOut>=0 then begin
    if FTimeOut>500 then
      FTimer.Interval:=FTimeOut
    else
      FTimer.Interval:=500;
    FTimer.Enabled:=True;
  end
  else
    FTimer.Enabled:=False;
  FShowTime:=GetTickCount;
  FFirstWait:=(FShowTime-GetLastInputTime>500);
end;

procedure TAPIBalloon.Show(Control:TControl);
var
  Form:TCustomForm;
begin
  Close;
  if Assigned(FControl) then FControl.RemoveFreeNotification(Self);
  FControl:=Control;
  if Assigned(FControl) then begin
    FControl.FreeNotification(Self);
    Form:=ValidParentForm(Control);
    FControlWnd:=Form.Handle;
    with GetBalloonPos(FControl) do
      Show(X,Y);
    if FControlWnd<>0 then POldControlWndProc:=Pointer(SetWindowLong(FControlWnd,GWL_WNDPROC,Integer(PNewControlWndProc)));
  end;
end;

function TAPIBalloon.GetBalloonPos(Control:TControl):TPoint;
var
  R:TRect;
begin
  if Assigned(FControl) then begin
    R:=FControl.ClientRect;
    with FControl.ClientOrigin do
      OffsetRect(R,X-R.Left,Y-R.Top);
    Result.X:=(R.Left+R.Right)div 2;
    Result.Y:=(R.Bottom+R.Top)div 2;
  end;
end;

procedure TAPIBalloon.Show(X,Y:Integer);
begin
  Close;
  if Assigned(FBeforeShow) then FBeforeShow(Self);
  InitializeBalloon;
  SendMessage(FBalloonHandle,TTM_TRACKPOSITION,0,lparam(MAKELONG(X,Y)));
  SendMessage(FBalloonHandle,TTM_TRACKACTIVATE,1,lparam(@FToolInfo));
  if Assigned(FAfterShow) then FAfterShow(Self);
end;

procedure TAPIBalloon.CreateBalloonWnd;
begin
  FBalloonHandle:=CreateWindowEx(WS_EX_NOACTIVATE or WS_EX_TOPMOST,TOOLTIPS_CLASS,nil,
    WS_POPUP or TTS_NOPREFIX or TTS_BALLOON or TTS_ALWAYSTIP {or $80 or TTF_IDISHWND},0,0,0,0,0,0,HInstance,nil);
  if FBalloonHandle<>0 then begin
    PNewWndProc:=MakeObjectInstance(NewWinProc);
    POldWndProc:=Pointer(SetWindowLong(FBalloonHandle,GWL_WNDPROC,Longint(PNewWndProc)));

    FToolInfo.uFlags:={TTF_ABSOLUTE or } TTF_TRACK{or TTF_CENTERTIP };
    FToolInfo.cbSize:=SizeOf(FToolInfo);
  end
end;

procedure TAPIBalloon.OnTimer(Sender:TObject);
var
  Time:DWORD;
  Delta:Integer;
begin
  Time:=GetLastInputTime;
  if not FFirstWait then
    Close
  else
    if Time>=FShowTime then begin
      FFirstWait:=False;
      Delta:=FTimer.Interval-(GetTickCount-Time);
      if Delta<50 then
        Close
      else
        if Delta<Integer(FTimer.Interval) then FTimer.Interval:=Delta;
    end;
end;

procedure TAPIBalloon.Notification(AComponent:TComponent;Operation:TOperation);
begin
  inherited;
  if (Operation=opRemove)and(FControl=AComponent) then FControl:=nil;
end;

end.
