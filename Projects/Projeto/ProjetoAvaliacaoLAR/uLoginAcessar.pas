unit uLoginAcessar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, udmDados, uTelaPrincipal, uLogSistema;

type
  TfrmLogin = class(TForm)
    pnlFundo: TPanel;
    pnlLateral: TPanel;
    lblBemVindo: TLabel;
    lblCandidatoAvaliacao: TLabel;
    imgLogoEmpresa: TImage;
    pnlUsuario: TPanel;
    lblUsuario: TLabel;
    txtUsuario: TEdit;
    pnlLinhaUsuario: TPanel;
    pnlSenha: TPanel;
    lblSenha: TLabel;
    txtSenha: TEdit;
    pnlLinhaSenha: TPanel;
    pnlBotaoConfirma: TPanel;
    btnConfirma: TSpeedButton;
    btnFechar: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnConfirmaClick(Sender: TObject);
begin
  DMDados.QUsuario.Close;
  DMDados.QUsuario.ParamByName('LOGIN').AsString := txtUsuario.Text;
  DMDados.QUsuario.ParamByName('SENHA').AsString := txtSenha.Text;
  DMDados.QUsuario.Open;

  if DMDados.QUsuario.IsEmpty then
  begin
    // Log de tentativa de login inválida
    GravaLog('SISTEMA', 'LOGIN_FALHA', 'USUARIO', 0,
             'Tentativa de login falhou para o usuário: ' + txtUsuario.Text);

    ShowMessage('Usuário e/ou senha incorretos.');
    Application.Terminate;
  end
  else
  begin
    // Guarda o nome do usuário logado
    DMDados.UsuarioLogado := DMDados.QUsuario.FieldByName('LOGIN').AsString;

    // Log de login bem-sucedido
    GravaLog(DMDados.UsuarioLogado, 'LOGIN_SUCESSO', 'USUARIO',
             DMDados.QUsuario.FieldByName('ID').AsInteger,
             'Usuário logado com sucesso.');

    ModalResult := mrOk;
  end;
end;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  pnlFundo.Left  := Round ((frmLogin.Width - pnlFundo.Width) / 2) ;
  pnlFundo.Top := Round ((frmLogin.Height - pnlFundo.Height) / 2) ;
end;

procedure TfrmLogin.txtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnConfirmaClick(self);
  end;
end;

end.
