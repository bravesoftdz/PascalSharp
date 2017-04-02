unit PascalSharp.Version;

interface

Type
  TVersion = Record
  private
    FMajor, FMinor, FBuild, FRevision: Word;
  public
    Function IsEmpty: Boolean;
    Function ToString: String;
    Function ToArray: TArray<Word>;
    Class Function Parse(Const Input: String): TVersion; static;
    Class Function Empty: TVersion; static;
    constructor Create(const AMajor: Word; AMinor: Word = 0; ABuild: Word = 0;
      ARevision: Word = 0); overload;
    constructor Create(const AVersion: String); overload;
{$REGION 'Class operator'}
    class operator Equal(a: TVersion; b: TVersion): Boolean;
    class operator GreaterThan(a: TVersion; b: TVersion): Boolean;
    class operator GreaterThanOrEqual(a: TVersion; b: TVersion): Boolean;
    class operator NotEqual(a: TVersion; b: TVersion): Boolean;
    class operator LessThan(a: TVersion; b: TVersion): Boolean;
    class operator LessThanOrEqual(a: TVersion; b: TVersion): Boolean;
    class operator Implicit(a: String): TVersion;
{$ENDREGION}
    property Major: Word read FMajor write FMajor;
    property Minor: Word read FMinor write FMinor;
    property Build: Word read FBuild write FBuild;
    property Revision: Word read FRevision write FRevision;
  End;

implementation

uses
  System.SysUtils;
{ TVersion }

constructor TVersion.Create(const AVersion: String);
begin
  Self := TVersion.Parse(AVersion);
end;

constructor TVersion.Create(const AMajor: Word; AMinor, ABuild, ARevision: Word);
begin
  FMajor := AMajor;
  FMinor := AMinor;
  FBuild := ABuild;
  FRevision := ARevision;
end;

class function TVersion.Empty: TVersion;
begin
  Result := TVersion.Create(0);
end;

class function TVersion.Parse(const Input: String): TVersion;
var
  raw: TArray<String>;
begin
  raw := Input.Split(['.', ','], TStringSplitOptions.ExcludeEmpty);
  case Length(raw) of
    0:
      Result := TVersion.Empty;
    1:
      Result := TVersion.Create(raw[0].ToInteger);
    2:
      Result := TVersion.Create(raw[0].ToInteger, raw[1].ToInteger);
    3:
      Result := TVersion.Create(raw[0].ToInteger, raw[1].ToInteger, raw[2].ToInteger);
    4:
      Result := TVersion.Create(raw[0].ToInteger, raw[1].ToInteger, raw[2].ToInteger,
        raw[3].ToInteger);
  end;
end;

class operator TVersion.Implicit(a: String): TVersion;
begin
  Result := TVersion.Parse(a);
end;

function TVersion.IsEmpty: Boolean;
begin
  Result := Self = TVersion.Empty;
end;

function TVersion.ToArray: TArray<Word>;
begin
  Result := [Major, Minor, Build, Revision];
end;

function TVersion.ToString: String;
begin
  Result := string.Join('.', [Major, Minor]);
  if (Build > 0) and (Revision > 0) then
    Result := string.Join('.', [Major, Minor, Build, Revision])
  else if Build > 0 then
    Result := string.Join('.', [Major, Minor, Build]);
end;

{$REGION 'Class operator'}

class operator TVersion.Equal(a, b: TVersion): Boolean;
begin
  Result := //
    (a.Major = b.Major) and //
    (a.Minor = b.Minor) and //
    (a.Build = b.Build) and //
    (a.Revision = b.Revision); //
end;

class operator TVersion.GreaterThan(a, b: TVersion): Boolean;
var
  rawVerA: TArray<Word>;
  rawVerB: TArray<Word>;
  i: Byte;
begin
  Result := False;
  rawVerA := a.ToArray;
  rawVerB := b.ToArray;
  for i := Low(rawVerA) to High(rawVerA) do
    if rawVerA[i] > rawVerB[i] then
      Exit(True);
end;

class operator TVersion.GreaterThanOrEqual(a, b: TVersion): Boolean;
begin
  Result := (a = b) or (a > b);
end;

class operator TVersion.LessThan(a, b: TVersion): Boolean;
begin
  Result := b > a;
end;

class operator TVersion.LessThanOrEqual(a, b: TVersion): Boolean;
begin
  Result := (a < b) or (a = b);
end;

class operator TVersion.NotEqual(a, b: TVersion): Boolean;
begin
  Result := NOT(a = b);
end;
{$ENDREGION}

end.
