{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

program SPTServer;

uses
  Forms,
  SysUtils,
  Windows,
  Dialogs,
  Main in 'Main.pas' {FMain},
  Meter in 'Meter.pas' {FMeter},
  DBdata in '..\..\common\DBdata.pas',
  Settings in 'Settings.pas' {FSettings},
  SPServer in '..\..\common\SPServer.pas',
  About in '..\..\common\About.pas' {FAbout},
  GettingArchiveData in 'GettingArchiveData.pas' {FGettingArchiveData},
  TablesSynchronization in 'TablesSynchronization.pas' {FTablesSynchronization},
  globalclasses in '..\..\common\globalclasses.pas',
  DialogsEx in '..\..\common\DialogsEx.pas',
  globalvars in '..\..\common\globalvars.pas',
  QuerySearchList in '..\..\common\QuerySearchList.pas' {ListParams},
  Log in '..\..\common\Log.pas',
  Progress in '..\..\common\Progress.pas' {FProgress},
  globalmethods in '..\..\common\globalmethods.pas',
  SPData in '..\..\common\SPData.pas',
  dm_general in '..\..\common\dm_general.pas' {DM: TDataModule},
  DdeMan in 'c:\program files\borland\bds\4.0\source\Win32\vcl\DdeMan.pas',
  Login in '..\..\common\Login.pas' {FLogin},
  Statistic in 'Statistic.pas' {FStatistic},
  Splash in '..\..\common\Splash.pas' {SplashForm};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF USE_ADMIN}
  if Windows.MessageBox(0,
    PChar('Вы запустили программу по администрированию ' + Application.Title + #13#10 +
    'Если Вы не обладаете достаточным опытом использования этого продукта, ' + #13#10 +
    'настоятельно рекомундуется немедленно прекратить работу программы. Прекратить работу?'), 'Предупреждение',
    MB_OKCANCEL + MB_ICONWARNING) = IDOK then
  begin
    Application.Terminate;
    Exit;
  end;
  {$ENDIF}
  UDM := TDM.Create(Application);
  try
    UDBData := TDBData.Create(UDM);
    try
      if not UDM.Connect then Exit;
      ShowSplash(UDM.HostDes);
      try
        Application.CreateForm(TFMain, FMain);
      finally
        CloseSplashForm;
      end;
      Application.Run;
    finally
      UDBData.Free;
    end;
  finally
    UDM.Free;
  end;
end.
