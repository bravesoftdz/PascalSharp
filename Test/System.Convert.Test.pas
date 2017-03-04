unit System.Convert.Test;

interface

uses
  PS.System.Convert,
  System.SysUtils,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestConvert = class(TObject)
  public
    [Test]
    procedure ToBase64String;
  end;

implementation

{ TTestConvert }

procedure TTestConvert.ToBase64String;
var
  bytes: TArray<Byte>;
begin
  bytes := TEncoding.UTF8.GetBytes('abcdef==');
  Assert.AreEqual('YWJjZGVmPT0=', TConvert.ToBase64String(bytes));
end;

initialization

TDUnitX.RegisterTestFixture(TTestConvert);

end.
