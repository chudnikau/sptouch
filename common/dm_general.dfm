object DM: TDM
  OldCreateOrder = False
  Height = 185
  Width = 244
  object MySQLConnection: TZConnection
    Protocol = 'mysql-5'
    HostName = 'localhost'
    Port = 3306
    Properties.Strings = (
      'CLIENT_MULTI_STATEMENTS=1')
    AutoCommit = False
    ReadOnly = True
    Left = 40
    Top = 32
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\Program Files\Lo' +
      'gika\Spnet95\Spdef.mdb;Mode=Read;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmRead
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 136
    Top = 32
  end
end
