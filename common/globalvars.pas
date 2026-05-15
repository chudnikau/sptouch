{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit globalvars;

interface

uses Windows;

const
  REPOARCHIVE_PATH = '.\repos\archive.fr3';
  SPTOUCH_STR = 'SpTouch';
//  PREFIX_NAME = 'SP-TOUCH';
//  INSTALL_PATH = 'C:\Program Files\SP-TOUCH\';
  {$IFDEF USE_MDSERVER}
  EXENAME = 'MdServer.exe';
  {$ELSE}
  EXENAME = 'MdClient.exe';
  {$ENDIF}
  MAINTENANCE_NAME = 'MdMaintenance';
  MAINTENANCE_EXENAME = 'MdMaintenance.exe';
  //DIAGRAM_POSITIONFILENAME = 'mdcpos.dpd';
  FILE_LICENSE = 'license.lic';
  //параметр опроса недоступен для опроса
  PARAMQUERY_ENABLE = 1;
  //параметр опроса доступен для опроса
  PARAMQUERY_DISABLE = 0;
  //флаг часового значения
  ARRAY_HOUR = 'H';
  //флаг суточного значения
  ARRAY_DAY = 'D';
  //флаг месячного значения
  ARRAY_MONTH = 'M';
  //флаг годового значения
  ARRAY_YEAR = 'Y';
  //библиотека категори плагинов
  PLUGIN_CAT = 'category.ctg';

  DB_UNIT_KEY                     = 'K001';
  SETTING_KEY                     = 'K002';

  DB_NAME_VAL                     = 'V001';
  DB_HOST_VAL                     = 'V002';
  DB_PORT_VAL                     = 'V003';
  DB_LOGIN_VAL                    = 'V004';
  DB_PASSWORD_VAL                 = 'V005';
  INI_APP_ONLYONE                 = 'V006';
  UPDATE_INTERVAL_VAL             = 'V007';
  PLAY_ALERT_VAL                  = 'V008';
  INI_APP_W_ALERT_FORM            = 'V009';
  INI_APP_E_ALERT_FORM            = 'V010';
  DNS_NAME_VAL                    = 'V011';
  LOCK_SECRET_VAL                 = 'V012';
  DDE_QUERY_INTERVAL_VAL          = 'V013';
  DDE_QUERY_NOT_USE_INTERVAL_VAL  = 'V014';
  DDE_RELIABILITY_OF_READING_VAL  = 'V015';
  DDE_QUERY_TOPIC_VAL             = 'V016';
  DDE_QUERY_PRIORITY_VAL          = 'V017';
  ARCHIVE_FILTER_DATE_VAL         = 'V018';
  ANALOG_VIEW_PAGE_VAL            = 'V019';
  ARCHIVE_VIEW_PAGE_VAL           = 'V020';
  REPORTS_VIEW_PAGE_VAL           = 'V021';

type
  TProcessEntry32 = packed record
     dwSize: DWORD;
     cntUsage: DWORD;
     th32ProcessID: DWORD;
     th32DefaultHeapID: DWORD;
     th32ModuleID: DWORD;
     cntThreads: DWORD;
     th32ParentProcessID: DWORD;
     pcPriClassBase: Longint;
     dwFlags: DWORD;
     szExeFile: array [0..MAX_PATH - 1] of WideChar;
  end;
  
implementation

end.
