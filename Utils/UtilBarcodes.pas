unit UtilBarcodes;

interface

uses Graphics, SysUtils, Classes;

function GenerateBarcodeBitmap(const text: string; const barWidth, barHeight: Integer): TBitmap;

implementation

const
  Code128Patterns: array[0..106] of string = (
    '11011001100','11001101100','11001100110','10010011000','10010001100',
    '10001001100','10011001000','10011000100','10001100100','11001001000',
    '11001000100','11000100100','10110011100','10011011100','10011001110',
    '10111001100','10011101100','10011100110','11001110010','11001011100',
    '11001001110','11011100100','11001110100','11101101110','11101001100',
    '11100101100','11100100110','11101100100','11100110100','11100110010',
    '11011011000','11011000110','11000110110','10100011000','10001011000',
    '10001000110','10110001000','10001101000','10001100010','11010001000',
    '11000101000','11000100010','10110111000','10110001110','10001101110',
    '10111011000','10111000110','10001110110','11101110110','11010001110',
    '11000101110','11011101000','11011100010','11011101110','11101011000',
    '11101000110','11100010110','11101101000','11101100010','11100011010',
    '11101111010','11001000010','11110001010','10100110000','10100001100',
    '10010110000','10010000110','10000101100','10000100110','10110010000',
    '10110000100','10011010000','10011000010','10000110100','10000110010',
    '11000010010','11001010000','11110111010','11000010100','10001111010',
    '10100111100','10010111100','10010011110','10111100100','10011110100',
    '10011110010','11110100100','11110010100','11110010010','11011011110',
    '11011110110','11110110110','10101111000','10100011110','10001011110',
    '10111101000','10111100010','11110101000','11110100010','10111011110',
    '10111101110','11101011110','11110101110','11010000100','11010010000',
    '11010011100','1100011101011'
  );

  StartCodeA = 103;
  StartCodeB = 104;
  CodeSwitchToB = 100;
  CodeSwitchToA = 101;
  CodeStop = 106;

function CharToCode128Value(ch: Char; var codeSet: Char): Integer;
begin
  if codeSet = 'A' then
  begin
    if Ord(ch) <= 95 then
      Result := Ord(ch)
    else
    begin
      // Switch to B if character not in A
      codeSet := 'B';
      Result := -1;
    end;
  end
  else // codeSet = 'B'
  begin
    if Ord(ch) >= 32 then
      Result := Ord(ch) - 32
    else
    begin
      // Switch to A if character not in B
      codeSet := 'A';
      Result := -1;
    end;
  end;
end;

function EncodeToCode128AB(const data: string): string;
var
  codeSet: Char;
  encoded: string;
  checksum, i, posVal, codeValue: Integer;
begin
  codeSet := 'A';
  encoded := Code128Patterns[StartCodeA];
  checksum := StartCodeA;
  posVal := 1;
  i := 1;

  while i <= Length(data) do
  begin
    codeValue := CharToCode128Value(data[i], codeSet);
    if codeValue = -1 then
    begin
      // Switch code set
      if codeSet = 'B' then
      begin
        encoded := encoded + Code128Patterns[CodeSwitchToB];
        Inc(checksum, CodeSwitchToB * posVal);
        Inc(posVal);
        continue; // retry same character in new code set
      end
      else
      begin
        encoded := encoded + Code128Patterns[CodeSwitchToA];
        Inc(checksum, CodeSwitchToA * posVal);
        Inc(posVal);
        continue;
      end;
    end;

    encoded := encoded + Code128Patterns[codeValue];
    Inc(checksum, codeValue * posVal);
    Inc(posVal);
    Inc(i);
  end;

  checksum := checksum mod 103;
  encoded := encoded + Code128Patterns[checksum]; // checksum
  encoded := encoded + Code128Patterns[CodeStop]; // stop
  Result := encoded;
end;

function GenerateBarcodeBitmap(const text: string; const barWidth, barHeight: Integer): TBitmap;
var
  encoded: string;
  bmp: TBitmap;
  i, x: Integer;
begin
  encoded := EncodeToCode128AB(text);

  bmp := TBitmap.Create;
  bmp.Width := Length(encoded) * barWidth;
  bmp.Height := barHeight;
  bmp.PixelFormat := pf1bit;

  bmp.Canvas.Brush.Color := clWhite;
  bmp.Canvas.FillRect(Rect(0, 0, bmp.Width, bmp.Height));
  bmp.Canvas.Brush.Color := clBlack;

  x := 0;
  for i := 1 to Length(encoded) do
  begin
    if encoded[i] = '1' then
      bmp.Canvas.FillRect(Rect(x, 0, x + barWidth, barHeight));
    Inc(x, barWidth);
  end;

  Result := bmp;
end;

end.
