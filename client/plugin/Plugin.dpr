{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

library Plugin;

uses
  ShareMem,
  SysUtils,
  Classes,
  Windows,
  Dialogs,
  Forms,
  ExtCtrls, 
  ObjectInspector in '..\ObjectInspector.pas' {ObjectInspectorForm},
  PluginContainer in 'PluginContainer.pas',
  PluginPanel in 'PluginPanel.pas';

{$R *.res}

{$E plg}                        
{$LIBSUFFIX '.pipeh'}
{$LIBVERSION '1'}

var
  FPluginContainer: TPluginContainer;

procedure DLLMain(Reason: Integer);
begin
  if Reason = DLL_PROCESS_DETACH then FPluginContainer.Free;
end;

function PluginContainer: TPluginContainer; stdcall;
begin
  Result := FPluginContainer;
end;

function PluginVersion: Integer; stdcall;
begin                                                      //версия плагина, использую для совмешения
  Result := 1;
end;

exports
  PluginContainer,
  PluginVersion;

begin
  DLLProc := @DLLMain;
  FPluginContainer := TPluginContainer.Create;              //создаю класс плагина
  with FPluginContainer do
  begin
    Title := 'FPluginContainer';                            //задаю свойства инициализации контейнера
    HelpText := 'Описание FPluginContainer';
    CategoryIndex := 0;
    PreviewFileName := '.\plugins\gpipe.view.bmp';
    PropClass := TObjectInspector;
    Plugin := TPluginPanel.Create(nil);                     //создаю класс плагина
    with TPluginPanel(Plugin) do
    begin
      Width := 150;                                         //задаю свойства инициализации плагина
      Height := 13;
      Color := 177;
      Caption := 'Труба';
      ViewFileName := '.\plugins\gpipe.bmp';                //изображение плагина
    end;
  end;
end.
