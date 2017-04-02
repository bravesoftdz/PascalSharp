unit PascalSharp.Version.Ext.Android;

interface

uses PascalSharp.Version;

type
  TVersionInfo = Class
    Class function SelfVersion(): TVersion;
    Experimental;
  End;

implementation

uses
  Androidapi.JNI.JavaTypes,
  FMX.Helpers.Android,
  Androidapi.JNI.GraphicsContentViewText;
{ TVersionInfo }

class function TVersionInfo.SelfVersion: TVersion;
var
  PackageManager: JPackageManager;
  PackageInfo: JPackageInfo;
begin
  PackageManager := SharedActivity.getPackageManager;
  PackageInfo := PackageManager.getPackageInfo(SharedActivityContext.getPackageName(),
    TJPackageManager.JavaClass.GET_ACTIVITIES);
  result := JStringToString(PackageInfo.versionName);
end;

end.
