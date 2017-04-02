unit PascalSharp.Version.Ext;

interface

uses
  PascalSharp.Version;

type
  TVersionHelper = record helper for TVersion
    Class function FileVersion(FileName: String): TVersion; static;
  End;

implementation

uses
{$IF Defined(MSWINDOWS)}
  PascalSharp.Version.Ext.Windows;
{$ELSEIF Defined(Android)}
  PascalSharp.Version.Ext.Android;
{$ELSE}
  System.SysUtils;
{$ENDIF}
{ TVersionHelper }

class function TVersionHelper.FileVersion(FileName: String): TVersion;
begin
  Result := TVersionInfo.FileVersion(FileName);
end;

end.
