unit UFrmConfigEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Data.Win.ADODB,
  ACBrBase, ACBrMail, ClasseEmailACBr;

type
  TFrmConfigEmail = class(TForm)
    lblDoEmail: TLabel;
    edtDoEmail: TEdit;
    lblSMTP: TLabel;
    edtSMTP: TEdit;
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    lblPorta: TLabel;
    edtPorta: TEdit;
    Label1: TLabel;
    chkTLS: TCheckBox;
    chkSSL: TCheckBox;
    lblSenha: TLabel;
    chkMostrarSenha: TCheckBox;
    edtSenha: TEdit;
    btnSalvar: TSpeedButton;
    btnAlterar: TSpeedButton;
    gbEmailTeste: TGroupBox;
    btnEnvioTeste: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    lblAssuntoTeste: TLabel;
    edtParaEmailTeste: TEdit;
    edtParaNomeTeste: TEdit;
    edtAssuntoTeste: TEdit;
    edtDoNome: TEdit;
    lblNota: TLabel;
    Button1: TButton;
    procedure chkMostrarSenhaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPortaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnEnvioTesteClick(Sender: TObject);
    procedure ACBrMailMailException(const AMail: TACBrMail; const E: Exception;
      var ThrowIt: Boolean);
    procedure ACBrMailAfterMailProcess(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEnvioTesteMouseEnter(Sender: TObject);
    procedure btnEnvioTesteMouseLeave(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vBotao: string;
    procedure ControlaCampos;
    procedure BloqueiaCampos;
  public
    { Public declarations }
  end;

var
  FrmConfigEmail: TFrmConfigEmail;
  EmailACBr: TEmailACBr;

implementation

{$R *.dfm}

uses UConexao, UEnviaEmail;

procedure TFrmConfigEmail.btnEnvioTesteClick(Sender: TObject);
var
   TLS,SSL: boolean;
begin
   if chkTLS.Checked then
      TLS := true
   else
      TLS := false;

   if chkSSL.Checked then
      SSL := true
   else
      SSL := false;

   Screen.Cursor := crHourGlass;

   if edtParaEmailTeste.Text <> EmptyStr then
      EmailACBr.EnviarEmailTeste(edtDoEmail.Text,
                                 edtDoNome.Text,
                                 edtSMTP.Text,
                                 edtUsuario.Text,
                                 edtSenha.text,
                                 edtAssuntoTeste.Text,
                                 edtParaEmailTeste.Text,
                                 edtParaNomeTeste.Text,
                                 StrToInt(edtPorta.Text),
                                 TLS,
                                 SSL);
end;

procedure TFrmConfigEmail.btnEnvioTesteMouseEnter(Sender: TObject);
begin
   if not EmailACBr.RetornaCampos then
      btnEnvioTeste.Enabled := false;
end;

procedure TFrmConfigEmail.btnEnvioTesteMouseLeave(Sender: TObject);
begin
   btnEnvioTeste.Enabled := true;
end;

procedure TFrmConfigEmail.btnSalvarClick(Sender: TObject);
var
   TLS, SSL: string;
begin
   if edtDoEmail.Text = EmptyStr then
   begin
      MessageBox(Handle,pchar('Preencha o campo Do E-mail!'),pchar('Informa??o'),64);
      Abort;
   end
   else if edtSMTP.Text = EmptyStr then
   begin
      MessageBox(Handle,pchar('Preencha o campo Host!'),pchar('Informa??o'),64);
      Abort;
   end
   else if edtPorta.Text = EmptyStr then
   begin
      MessageBox(Handle,pchar('Preencha o campo Porta!'),pchar('Informa??o'),64);
      Abort;
   end
   else if edtUsuario.Text = EmptyStr then
   begin
      MessageBox(Handle,pchar('Preencha o campo Usu?rio (E-mail)!'),pchar('Informa??o'),64);
      Abort;
   end
   else if edtSenha.Text = EmptyStr then
   begin
      MessageBox(Handle,pchar('Preencha o campo Senha!'),pchar('Informa??o'),64);
      Abort;
   end;

   if chkTLS.Checked then
      TLS := '1'
   else
      TLS := '0';

   if chkSSL.Checked then
      SSL := '1'
   else
      SSL := '0';

   EmailACBr.DoEmail := edtDoEmail.Text;
   EmailACBr.DoNome  := edtDoNome.Text;
   EmailACBr.Host    := edtSMTP.Text;
   EmailACBr.Porta   := StrToInt(edtPorta.Text);
   EmailACBr.Usuario := edtUsuario.Text;
   EmailACBr.Senha   := edtSenha.Text;
   EmailACBr.TLS     := TLS;
   EmailACBr.SSL     := SSL;

   if vBotao = 'Alterar' then
   begin
      try
         EmailACBr.Alterar;

         MessageBox(Handle,pchar('Alterado com Sucesso!'),pchar('Informa??o'),64);

         BloqueiaCampos;
      except
         MessageBox(Handle,pchar('Erro ao Alterar!'),pchar('Aviso'),48);
      end;
   end
   else
   begin
      try
         EmailACBr.Inserir;

         MessageBox(Handle,pchar('Cadastrado com Sucesso!'),pchar('Informa??o'),64);

         BloqueiaCampos;
      except
         MessageBox(Handle,pchar('Erro ao Cadastrar!'),pchar('Aviso'),48);
      end;
   end;
end;

procedure TFrmConfigEmail.Button1Click(Sender: TObject);
begin
   if FrmEnviar = nil then
    FrmEnviar := FrmEnviar.Create(Self);

    FrmEnviar.ShowModal;

    FreeAndNil(FrmEnviar);
end;

procedure TFrmConfigEmail.chkMostrarSenhaClick(Sender: TObject);
begin
   if chkMostrarSenha.Checked then
      edtSenha.PasswordChar := #0
   else
      edtSenha.PasswordChar := '*';
end;

procedure TFrmConfigEmail.ControlaCampos;
begin
   if EmailACBr.RetornaCampos then
   begin
      edtDoEmail.Text := EmailACBr.DoEmail;
      edtDoNome.Text  := EmailACBr.DoNome;
      edtSMTP.Text    := EmailACBr.Host;
      edtPorta.Text   := IntToStr(EmailACBr.Porta);
      if EmailACBr.TLS = '1' then
         chkTLS.Checked  := true;
      if EmailACBr.SSL = '1' then
         chkSSL.Checked  := true;
      edtUsuario.Text := EmailACBr.Usuario;
      edtSenha.Text   := EmailACBr.Senha;
      edtDoEmail.Enabled := false;
      edtDoNome.Enabled  := false;
      edtSMTP.Enabled    := false;
      edtPorta.Enabled   := false;
      chkTLS.Enabled     := false;
      chkSSL.Enabled     := false;
      edtUsuario.Enabled := false;
      edtSenha.Enabled   := false;
      btnSalvar.Enabled  := false;
   end
   else
      btnAlterar.Enabled := false;
end;

procedure TFrmConfigEmail.edtPortaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', Chr(8)]) then
     Key := #0
end;

procedure TFrmConfigEmail.FormCreate(Sender: TObject);
begin
   if EmailACBr = nil then
      EmailACBr := TEmailACBr.Create;
   if FrmConexao = nil then
    FrmConexao := TFrmConexao.Create(Self);


   EmailACBr.Conexao := FrmConexao.ADOConPrimario;

   ControlaCampos;
end;

procedure TFrmConfigEmail.FormDestroy(Sender: TObject);
begin
   if EmailACBr <> nil then
      FreeAndNil(EmailACBr);
//   if FrmConexao <> nil then
//    FreeAndNil(FrmConexao);
end;

procedure TFrmConfigEmail.ACBrMailAfterMailProcess(Sender: TObject);
begin
   MessageBox(Handle,pchar('Enviado com Sucesso!'),pchar('Informa??o'),64);
   Screen.Cursor := crDefault;
end;

procedure TFrmConfigEmail.ACBrMailMailException(const AMail: TACBrMail;
  const E: Exception; var ThrowIt: Boolean);
begin
   MessageBox(Handle,pchar('Erro ao Enviar'),pchar('Aviso'),48);
   Screen.Cursor := crDefault;
end;

procedure TFrmConfigEmail.BloqueiaCampos;
begin
   edtDoEmail.Enabled := false;
   edtDoNome.Enabled  := false;
   edtSMTP.Enabled    := false;
   edtPorta.Enabled   := false;
   chkTLS.Enabled     := false;
   chkSSL.Enabled     := false;
   edtUsuario.Enabled := false;
   edtSenha.Enabled   := false;
   btnSalvar.Enabled  := false;
   btnAlterar.Enabled := true;
end;

procedure TFrmConfigEmail.btnAlterarClick(Sender: TObject);
begin
   edtDoEmail.Enabled := true;
   edtDoNome.Enabled  := true;
   edtSMTP.Enabled    := true;
   edtPorta.Enabled   := true;
   chkTLS.Enabled     := true;
   chkSSL.Enabled     := true;
   edtUsuario.Enabled := true;
   edtSenha.Enabled   := true;
   btnSalvar.Enabled  := true;
   btnAlterar.Enabled := false;

   vBotao := 'Alterar';
end;

end.
