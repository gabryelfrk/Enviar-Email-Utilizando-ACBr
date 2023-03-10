unit UEnviaEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ClasseEmailACBr;

type
  TFrmEnviar = class(TForm)
    MemoEmail: TMemo;
    BtnEnviar: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnEnviarClick(Sender: TObject);
  private
    { Private declarations }
    procedure EnviaEmailACBr;
  public
    { Public declarations }
  end;

var
  FrmEnviar: TFrmEnviar;
  EmailACBr: TEmailACBr;

implementation

{$R *.dfm}

uses UConexao;

procedure TFrmEnviar.BtnEnviarClick(Sender: TObject);
begin
  EnviaEmailACBr;
end;

procedure TFrmEnviar.EnviaEmailACBr;
var
   vAssinatura,DoNome,ParaEmail,Assunto,CorpoEmail: string;
begin
  DoNome      := Edit1.Text;
  //vAssinatura := 'Assinatura';
  ParaEmail   := Edit2.Text;
  Assunto     := Edit3.Text;
  CorpoEmail  := MemoEmail.Text;

  EmailACBr.EnviarEmail(DoNome,ParaEmail,'Para Nome',Assunto,CorpoEmail,'');
end;

procedure TFrmEnviar.FormCreate(Sender: TObject);
begin
   if EmailACBr = nil then
      EmailACBr := TEmailACBr.Create;

   EmailACBr.Conexao := FrmConexao.ADOConPrimario;
end;

procedure TFrmEnviar.FormDestroy(Sender: TObject);
begin
   if EmailACBr <> nil then
      FreeAndNil(EmailACBr);
end;

end.
