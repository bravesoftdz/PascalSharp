unit Test.Version;

interface

uses
  PascalSharp.Version,
  PascalSharp.Version.Ext,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestVersion = class(TObject)
  public
    // [Test]
    // [TestCase('Self', '0,1.2.3.4')]
    // [TestCase('B', '1,1.0.0.0')]
    // procedure ExeVersion(a: Integer; b: String);
    [Test]
    procedure SelfVersion;
    [Test]
    [TestCase('A', '1,1.0')]
    [TestCase('B', '1,1.0.0.0')]
    procedure Equal(a, b: String);
    [Test]
    [TestCase('A', '1.0.0.1,1.0')]
    [TestCase('B', '1.1,1.0.1.0')]
    procedure GreaterThan(a, b: String);
    [Test]
    [TestCase('A', '1,1.0.0.0')]
    [TestCase('B', '1.1,1.0.1.1')]
    procedure GreaterThanOrEqual(a, b: String);
    [Test]
    [TestCase('A', '1,1.0.1.0')]
    [TestCase('B', '1.1,1.0.1.1')]
    procedure NotEqual(a, b: String);
    [Test]
    [TestCase('A', '1,1.0.1.0')]
    [TestCase('B', '1.1,2.0.1.1')]
    procedure LessThan(a, b: String);
    [Test]
    [TestCase('A', '1,1.0.1.0')]
    [TestCase('B', '1.1,2.0.1.1')]
    procedure LessThanOrEqual(a, b: String);
    [Test]
    [TestCase('A', '1,1.0')]
    [TestCase('B', '1.2,1.2')]
    [TestCase('C', '1.2.3,1.2.3')]
    [TestCase('D', '1.2.3.4,1.2.3.4')]
    [TestCase('E', '1.2..,1.2')]
    procedure Parse(Input, Output: String);
    [Test]
    [TestCase('A', '1,0,0,0,1.0')]
    [TestCase('B', '1,2,0,0,1.2')]
    [TestCase('C', '1,2,3,0,1.2.3')]
    [TestCase('D', '1,2,3,4,1.2.3.4')]
    procedure &Create(AMajor, AMinor, ABuild, ARevision: Integer; AResult: String);
    [Test]
    [TestCase('A', '0,True')]
    [TestCase('B', '0.0,True')]
    [TestCase('C', '0.0.0,True')]
    [TestCase('D', '0.0.0.0,True')]
    [TestCase('E', '0.0.0.1,False')]
    procedure IsEmpty(AVersion: String; AEmpty: Boolean);
  end;

implementation

{ TTestVersion }

procedure TTestVersion.&Create(AMajor, AMinor, ABuild, ARevision: Integer; AResult: String);
begin
  Assert.AreEqual(TVersion.Create(AMajor, AMinor, ABuild, ARevision).ToString, AResult);
end;

procedure TTestVersion.Equal(a, b: String);
begin
  Assert.IsTrue(TVersion.Create(a) = TVersion.Create(b));
end;

procedure TTestVersion.GreaterThan(a, b: String);
begin
  Assert.IsTrue(TVersion.Create(a) > TVersion.Create(b));
end;

procedure TTestVersion.GreaterThanOrEqual(a, b: String);
begin
  Assert.IsTrue(TVersion.Create(a) >= TVersion.Create(b));
end;

procedure TTestVersion.IsEmpty(AVersion: String; AEmpty: Boolean);
begin
  Assert.AreEqual(TVersion.Create(AVersion).IsEmpty, AEmpty);
end;

procedure TTestVersion.LessThan(a, b: String);
begin
  Assert.IsTrue(TVersion.Create(a) < TVersion.Create(b));
end;

procedure TTestVersion.LessThanOrEqual(a, b: String);
begin
  Assert.IsTrue(TVersion.Create(a) <= TVersion.Create(b));
end;

procedure TTestVersion.NotEqual(a, b: String);
begin
  Assert.IsTrue(TVersion.Create(a) <> TVersion.Create(b));
end;

procedure TTestVersion.Parse(Input, Output: String);
begin
  Assert.AreEqual(TVersion.Parse(Input).ToString, Output);
end;

procedure TTestVersion.SelfVersion;
begin
  Assert.AreEqual(TVersion.FileVersion(ParamStr(0)).ToString, TVersion.Create('1').ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TTestVersion);

end.
