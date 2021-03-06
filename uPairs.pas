unit uPairs;

interface

type
  TCell = record
    Index: Integer;
    Flag: Boolean;
  end;

type
  TPairs = class(TObject)
  private
    FCell: array of array of TCell;
    FWidth: Integer;
    FHeight: Integer;
  public
    constructor Create; overload;
    constructor Create(const AWidth, AHeight: Integer); overload;
    destructor Destroy; override;
    function Width: Integer;
    function Height: Integer;
    procedure Clear;
    procedure SetCell(const X, Y: Integer; Cell: TCell);
    function GetCell(const X, Y: Integer): TCell;
    function Equals(const X1, Y1, X2, Y2: Integer): Boolean;
    procedure Gen;
    function IsFinal: Boolean;
  end;

var
  Pairs: TPairs;

implementation

uses System.Math;

{ TPairs }

procedure TPairs.Clear;
var
  X, Y: Integer;
begin
  for Y := 0 to Height - 1 do
    for X := 0 to Width - 1 do
    begin
      FCell[X, Y].Index := 0;
      FCell[X, Y].Flag := False;
    end;
end;

constructor TPairs.Create(const AWidth, AHeight: Integer);
begin
  FWidth := AWidth;
  FHeight := AHeight;
  SetLength(FCell, FWidth, FHeight);
  Self.Clear;
end;

constructor TPairs.Create;
begin
  Create(0, 0);
end;

destructor TPairs.Destroy;
begin

  inherited;
end;

function TPairs.Equals(const X1, Y1, X2, Y2: Integer): Boolean;
begin
  Result := FCell[X1, Y1].Index = FCell[X2, Y2].Index;
end;

procedure TPairs.Gen;
var
  I, D, C, F, X, Y: Integer;
begin
  D := Width * Height;
  C := 1;
  F := 1;
  for I := 0 to D - 1 do
  begin
    while True do
    begin
      X := RandomRange(0, Width);
      Y := RandomRange(0, Height);
      if FCell[X, Y].Index = 0 then
      begin
        FCell[X, Y].Index := C;
        Inc(F);
        if F > 2 then
        begin
          F := 1;
          Inc(C);
        end;
        Break;
      end;
    end;
  end;
end;

function TPairs.GetCell(const X, Y: Integer): TCell;
begin
  Result := FCell[X, Y];
end;

function TPairs.Height: Integer;
begin
  Result := FHeight;
end;

function TPairs.IsFinal: Boolean;
var
  X, Y: Integer;
begin
  Result := True;
  for Y := 0 to Height - 1 do
    for X := 0 to Width - 1 do
      if not FCell[X, Y].Flag then
      begin
        Result := False;
        Exit;
      end;
end;

procedure TPairs.SetCell(const X, Y: Integer; Cell: TCell);
begin
  FCell[X, Y] := Cell;
end;

function TPairs.Width: Integer;
begin
  Result := FWidth;
end;

end.
