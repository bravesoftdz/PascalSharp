unit PascalSharp.Version.Ext.Windows;

interface

uses
  PascalSharp.Version;

type
  TVersionInfo = Class
    Class function FileVersion(FileName: String): TVersion;
    Experimental;
    Class function SelfVersion(): TVersion;
  End;

implementation

uses
  Winapi.Windows;

{ TVersionInfoWindows }

class function TVersionInfo.FileVersion(FileName: String): TVersion;
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  Result := TVersion.Empty;
  VerInfoSize := GetFileVersionInfoSize(PWideChar(FileName), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PWideChar(FileName), 0, VerInfoSize, VerInfo) then
      begin
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          Result.Major := dwFileVersionMS shr 16;
          Result.Minor := dwFileVersionMS and $FFFF;
          Result.Build := dwFileVersionLS shr 16;
          Result.Revision := dwFileVersionLS and $FFFF;
        end;
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
end;

class function TVersionInfo.SelfVersion: TVersion;
begin
  Result := TVersionInfo.FileVersion(ParamStr(0));
end;

end.
