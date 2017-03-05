unit PascalSharp.UriKind;

interface

Type
{$SCOPEDENUMS ON}
  TUriKind = ( //
    // Сводка:
    // The kind of the Uri is indeterminate.
    RelativeOrAbsolute = 0,
    //
    // Сводка:
    // The Uri is an absolute Uri.
    Absolute = 1,
    //
    // Сводка:
    // The Uri is a relative Uri.
    Relative = 2);

implementation

end.
