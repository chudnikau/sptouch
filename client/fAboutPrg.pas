unit fAboutPrg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TformAbout = class(TForm)
    buttonOK: TButton;
    imageAbout1: TImage;
    lblApplicationName: TLabel;
    lblVersion: TLabel;
    lblCopyright: TLabel;
    Bevel1: TBevel;
    lblOSInformation: TLabel;
    lblOSMemoryAvailable: TLabel;
    lbEMaileCaption: TLabel;
    lbEMail: TLabel;
    lblHyperlinkCaption: TLabel;
    lblHyperlink: TLabel;
    PanelLogo1: TPanel;
    procedure lblHyperlinkClick(Sender: TObject);
    procedure lbEMailClick(Sender: TObject);
  private
    procedure GetVersionInfo;
    procedure GetOSInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

procedure ShowAbout;

implementation

uses
  ShellApi;

{$R *.DFM}

const
  // Version info key names
  vsComments         = 'Comments';
  vsCompanyName      = 'CompanyName';
  vsFileDescription  = 'FileDescription';
  vsFileVersion      = 'FileVersion';
  vsInternalName     = 'InternalName';
  vsLegalCopyright   = 'LegalCopyright';
  vsLegalTrademarks  = 'LegalTrademarks';
  vsOriginalFilename = 'OriginalFilename';
  vsProductVersion   = 'ProductVersion';
  vsProductName      = 'ProductName';
  vsSpecialBuild     = 'SpecialBuild';
  vsPrivateBuild     = 'PrivateBuild';
  // additional
  vsMail             = 'Mail';
  vsURL              = 'URL';

type
  PLongVersion = ^TLongVersion;
  TLongVersion = record
    case Integer of
    0: (All: array[1..4] of Word);
    1: (MS, LS: LongInt);
  end;

function GetVersionInfoStrs(StrList: TStrings; FileLongVer: PLongVersion): boolean;
var VerInfo: Pointer;
    VerInfoSize: integer;
    FixedFileInfo: PVSFixedFileInfo;
    Len: Cardinal;
    Handle: DWord;
    P: Pointer;
    Value, Prefix: string;
    i: integer;
begin
 Result := false;
 if not Assigned(StrList) then exit;
 VerInfo := Nil;
 Value := Application.ExeName;
 VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Handle);
 if VerInfoSize > 0 then
 try
  GetMem(VerInfo, VerInfoSize);
  if not GetFileVersionInfo(PChar(ParamStr(0)), Handle,
    VerInfoSize, VerInfo) then exit;
  // Get File info
  if VerQueryValue(VerInfo, '\', Pointer(FixedFileInfo), Len) then begin
   if Assigned(FileLongVer) then begin
    FileLongVer.MS := FixedFileInfo^.dwProductVersionMS;
    FileLongVer.LS := FixedFileInfo^.dwProductVersionLS;
   end;
  end;
  // Build string prefix
  P := Nil;
  VerQueryValue(VerInfo, '\VarFileInfo\Translation', P, Len);
  Prefix := '\StringFileInfo\' +
    IntToHex(MakeLong(HiWord(Longint(P^)), LoWord(Longint(P^))), 8) + '\';
  // Get values for names in StrList
  StrList.BeginUpdate;
  try
   for i:=0 to StrList.Count-1 do begin
    if VerQueryValue(VerInfo, PChar(Prefix + StrList[i]), P, Len) then begin
     SetLength(Value, Len);
     Move(P^, Value[1], Len);
    end else
     Value := '';
    StrList[i] := StrList[i] + '=' + Value;
   end;
  finally
   StrList.EndUpdate;
  end;
  Result := true;
 finally
  if Assigned(VerInfo) then FreeMem(VerInfo);
 end;
end;

function GetOSInfoString: string;
var
 OSVerInfo: TOSVersionInfo;
 info: string;
 build: DWORD;
begin
 OSVerInfo.dwOSVersionInfoSize := SizeOf(OSVerInfo);
 GetVersionEx(OSVerInfo);
 info := 'Windows ';
 build := 0;
 with OSVerInfo do begin
  case dwPlatformId of
    VER_PLATFORM_WIN32_NT:
      begin
       if dwMajorVersion = 5
        then info := info + '2000'
        else info := info + 'NT';
       build := dwBuildNumber;
      end;
    VER_PLATFORM_WIN32_WINDOWS:
      begin
       build := WORD(dwBuildNumber);
       if dwMajorVersion = 4 then
        case dwMinorVersion of
  	 0:   info := info + '95';
         1:   info := info + '98';
	 else info := info + '9x';
        end;
      end;
  end;
  Result := Format('%s (Version %d.%d Build %d %s)',
    [info, dwMajorVersion, dwMinorVersion, build, szCSDVersion]);
 end;
end;

procedure ShowAbout;
begin
 with TformAbout.Create(Application) do begin
  ShowModal;
  Free;
 end;
end;

// TformAbout /////////////////////////////////////////////////////////////////

constructor TformAbout.Create(AOwner: TComponent);
begin
 inherited;
 GetVersionInfo;
 GetOSInfo;
end;

destructor TformAbout.Destroy;
begin
 inherited;
end;

procedure TformAbout.GetOSInfo;
var
 mst: TMemoryStatus;
begin
 //lblOSInformation.Caption := GetOSInfoString;
 mst.dwLength := sizeof(TMemoryStatus);
 GlobalMemoryStatus(mst);
 lblOSMemoryAvailable.Caption :=
   Format(lblOSMemoryAvailable.Caption, [(mst.dwTotalPhys + 1023) div 1024]);
end;

procedure TformAbout.GetVersionInfo;
var StrList: TStringList;
    LongVer: TLongVersion;
begin
 StrList := TStringList.Create;
 with StrList do
 try
  // Add version info key names
  Add(vsLegalCopyright);
  Add(vsFileDescription);
  Add(vsMail);
  Add(vsURL);
  if GetVersionInfoStrs(StrList, @LongVer) then begin
   // Fill label captions from version info keys
   lblApplicationName.Caption := Values[vsFileDescription];
   lblCopyright.Caption := Values[vsLegalCopyright];
   lbEMail.Caption := Values[vsMail];
   lblHyperlink.Caption := Values[vsURL];
   with LongVer do
    lblVersion.Caption := Format(lblVersion.Caption, [All[2], All[1], All[3]]);
  end else begin
   // Set default values in label captions
   lblApplicationName.Caption := 'FlexGraphics Demo';
   lblCopyright.Caption := 'Copyright (C) 2002 FlexGraphics software';
   lbEMail.Caption := '';
   lblHyperlink.Caption := '';
  end;
 finally
  Free;
 end;
 lblOSInformation.Caption := GetOSInfoString;
end;

procedure TformAbout.lblHyperlinkClick(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar(lblHyperlink.Caption), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TformAbout.lbEMailClick(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar('mailto:' + lbEMail.Caption), nil, nil, SW_SHOWMAXIMIZED);
end;

end.
