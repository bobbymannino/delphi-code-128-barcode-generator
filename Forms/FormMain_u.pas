unit FormMain_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    LabelInput: TLabel;
    EditInput: TEdit;
    ImageOutput: TImage;
    procedure EditInputChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses UtilBarcodes;

procedure TFormMain.EditInputChange(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  Bitmap := GenerateBarcodeBitmap(EditInput.Text, 2, 50);
  ImageOutput.Picture.Bitmap := Bitmap;
end;

end.
