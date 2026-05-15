unit NetPC;

interface

uses Windows, SysUtils, Dialogs;

type
  COMPUTER_NAME_FORMAT = (
    ComputerNameNetBIOS,
    ComputerNameDnsHostname,
    ComputerNameDnsDomain,
    ComputerNameDnsFullyQualified,
    ComputerNamePhysicalNetBIOS,
    ComputerNamePhysicalDnsHostname,
    ComputerNamePhysicalDnsDomain,
    ComputerNamePhysicalDnsFullyQualified,
    ComputerNameMax);

function GetDNS_Name: string;

implementation

function GetComputerNameEx(ComputerNameFormat: COMPUTER_NAME_FORMAT;
  lpNameBuffer: LPSTR; nSize: PULONG): BOOL; stdcall;
  external kernel32 Name 'GetComputerNameExA';

function GetDNS_Name: string;
var
  nameDnsDomain: string;
  nameDnsDomainLen: DWord;
begin
  nameDnsDomainLen := 255;
  SetLength(nameDnsDomain, nameDnsDomainLen);
  if (GetComputerNameEx(ComputerNameDnsDomain, PChar(nameDnsDomain), @nameDnsDomainLen)) then
    SetLength(nameDnsDomain, nameDnsDomainLen)
  else
    nameDnsDomain := 'Unknown';
  Result := nameDnsDomain;
end;

end.
