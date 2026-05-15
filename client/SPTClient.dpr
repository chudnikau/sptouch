{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

program SPTClient;

uses
  ShareMem,
  Forms,
  Windows,
  Dialogs,
  SysUtils,
  StrUtils,
  Main in 'Main.pas' {FMain},
  ChooseAnl in 'ChooseAnl.pas' {ChooseArchiveForm},
  DBdata in '..\..\common\DBdata.pas',
  About in '..\..\common\About.pas' {FAbout},
  Lists in '..\..\common\Lists.pas',
  AnlDiagrams in 'AnlDiagrams.pas' {ModDiagrams},
  ModDiagram in 'ModDiagram.pas' {FModDiagram},
  ModParamDiagram in 'ModParamDiagram.pas' {FParamDiagram},
  APIBalloon in '..\..\common\APIBalloon.pas',
  sqlmod in 'sqlmod.pas' {FSQLMod},
  globalvars in '..\..\common\globalvars.pas',
  ModifyParamOfAnlGroup in 'ModifyParamOfAnlGroup.pas' {FModifyParamOfAnlGroup},
  globalclasses in '..\..\common\globalclasses.pas',
  globalmethods in '..\..\common\globalmethods.pas',
  Settings in 'Settings.pas',
  QuerySearchList in '..\..\common\QuerySearchList.pas' {FQuerySearchList},
  DialogsEx in '..\..\common\DialogsEx.pas',
  SQLCreater in 'SQLCreater.pas' {FSQLCreater},
  Report in 'Report.pas' {FReport},
  dm_general in '..\..\common\dm_general.pas' {DM: TDataModule},
  Wcrypt2 in '..\..\common\Wcrypt2.pas',
  Login in '..\..\common\Login.pas' {FLogin},
  frxDesgn in 'frxDesgn.pas' {frxDesignerForm},
  NetPC in '..\..\common\NetPC.pas',
  Log in '..\..\common\Log.pas',
  OKCANCL1 in 'c:\program files\borland\bds\4.0\ObjRepos\DelphiWin32\OKCANCL1.PAS' {OKBottomDlg},
  AlarmForm in 'AlarmForm.pas' {AlertForm},
  ArchiveAlarmsDlg in 'ArchiveAlarmsDlg.pas' {AlertArchiveDlg},
  SPTForm in '..\..\common\SPTForm.pas',
  RegObject in 'RegObject.pas',
  SpMiscUtils in '..\..\common\SpMiscUtils.pas',
  FileUtils in '..\..\common\FileUtils.pas',
  SCADAEditor in 'SCADAEditor.pas' {SCADAEditor: TFrame},
  Splash in 'Splash.pas' {SplashForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SpTouch Client';
  UDM := TDM.Create(nil);
  try
    UDBData := TDBData.Create(UDM);
    try
      //делаю попытку подключиться к базе данных
      if not UDM.Connect then Exit;
      if not UDBData.UserIsAdmin(UDM.User) then
      begin
        _MessageBox(0, PChar('Обнаружены ошибки прав доступа в режиме "Администратор". ' +
          'Приложение будет закрыто'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
        Exit;
      end;
      ShowSplash(UDM.HostDes);
      try
        Application.ProcessMessages;
        Application.CreateForm(TMain, FMain);
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
