unit PS.System.Convert;

interface

uses
  System.NetEncoding;

Type
  TConvert = Class
    Class Function ToBase64String(inArray: TArray<Byte>): String;
  End;

implementation

{ TConvert }

class function TConvert.ToBase64String(inArray: TArray<Byte>): String;
begin
  Result := TNetEncoding.Base64.EncodeBytesToString(inArray);
end;

end.
