program Code128BarcodeGenerator;

uses
  Vcl.Forms,
  FormMain_u in 'Forms\FormMain_u.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
