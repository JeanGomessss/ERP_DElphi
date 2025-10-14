unit uLogSistema;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, udmDados;

procedure GravaLog(const AUsuario, AAcao, ATabela: string; AIdRegistro: Integer; const ADescricao: string);

implementation

procedure GravaLog(const AUsuario, AAcao, ATabela: string; AIdRegistro: Integer; const ADescricao: string);
begin
  with DMDados.QTemp do
  begin
    Close;
    SQL.Text := 'EXECUTE PROCEDURE PROC_GRAVA_LOG (:USUARIO, :ACAO, :TABELA, :ID_REGISTRO, :DESCRICAO)';
    ParamByName('USUARIO').AsString := AUsuario;
    ParamByName('ACAO').AsString := AAcao;
    ParamByName('TABELA').AsString := ATabela;
    ParamByName('ID_REGISTRO').AsInteger := AIdRegistro;
    ParamByName('DESCRICAO').AsString := ADescricao;
    ExecSQL;
  end;
end;

end.
