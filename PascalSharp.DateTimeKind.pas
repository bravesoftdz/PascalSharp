unit PascalSharp.DateTimeKind;

interface

type
  TDateTimeKind = ( //
    // Сводка:
    // The time represented is not specified as either local time or Coordinated Universal
    // Time (UTC).
    Unspecified = 0,
    //
    // Сводка:
    // The time represented is UTC.
    Utc = 1,
    //
    // Сводка:
    // The time represented is local time.
    Local = 2);

implementation

end.
