program PrjEnviaEmail;



uses
  Vcl.Forms,
  UFrmConfigEmail in 'UFrmConfigEmail.pas' {FrmConfigEmail},
  ClasseEmailACBR in 'Classe\ClasseEmailACBR.pas',
  UEnviaEmail in 'UEnviaEmail.pas' {FrmEnviar},
  UConexao in 'UConexao.pas' {FrmConexao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmConfigEmail, FrmConfigEmail);
  Application.CreateForm(TFrmEnviar, FrmEnviar);
  Application.CreateForm(TFrmConexao, FrmConexao);
  Application.Run;
end.
