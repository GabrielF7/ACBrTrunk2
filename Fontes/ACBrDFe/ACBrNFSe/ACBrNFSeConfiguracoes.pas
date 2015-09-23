{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{  de Servi�o eletr�nica - NFSe                                                }

{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFSeConfiguracoes;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrDFeConfiguracoes, pcnConversao, pnfsConversao;

type

 TConfigGeral = record
    VersaoSoap: String;
    Prefixo2: String;
    Prefixo3: String;
    Prefixo4: String;
    Identificador: String;
    QuebradeLinha: String;
    RetornoNFSe: String;
    ProLinkNFSe: String;
    HomLinkNFSe: String;
    DadosSenha: String;
 end;

 TConfigNameSpace = record
   Producao: String;
   Homologacao: String;
 end;

 TConfigAssinar = record
    RPS: Boolean;
    Lote: Boolean;
    URI: Boolean;
    Recepcionar: Boolean;
    ConsSit: Boolean;
    ConsLote: Boolean;
    ConsNFSeRps: Boolean;
    ConsNFSe: Boolean;
    Cancelar: Boolean;
    Gerar: Boolean;
    RecSincrono: Boolean;
    Substituir: Boolean;
 end;

 TConfigXML = record
    VersaoCabecalho: String;
    VersaoDados: String;
    VersaoXML: String;
    NameSpace: String;
    CabecalhoStr: Boolean;
    DadosStr: Boolean;
  end;

 TConfigSchemas = record
    Validar: Boolean;
    DefTipos: String;
    Cabecalho: String;
    ServicoEnviar: String;
    ServicoConSit: String;
    ServicoConLot: String;
    ServicoConRps: String;
    ServicoConSeqRps: String;
    ServicoConNfse: String;
    ServicoCancelar: String;
    ServicoGerar: String;
    ServicoEnviarSincrono: String;
    ServicoSubstituir: String;
  end;

 TConfigSoapAction = record
    Recepcionar: String;
    ConsSit: String;
    ConsLote: String;
    ConsNFSeRps: String;
    ConsNFSe: String;
    Cancelar: String;
    Gerar: String;
    RecSincrono: String;
    Substituir: String;
 end;

 TConfigURL = record
    HomRecepcaoLoteRPS: String;
    HomConsultaLoteRPS: String;
    HomConsultaNFSeRPS: String;
    HomConsultaSitLoteRPS: String;
    HomConsultaSeqRPS: String;
    HomConsultaNFSe: String;
    HomCancelaNFSe: String;
    HomGerarNFSe: String;
    HomRecepcaoSincrono: String;
    HomSubstituiNFSe: String;

    ProRecepcaoLoteRPS: String;
    ProConsultaLoteRPS: String;
    ProConsultaSeqRPS: String;
    ProConsultaNFSeRPS: String;
    ProConsultaSitLoteRPS: String;
    ProConsultaNFSe: String;
    ProCancelaNFSe: String;
    ProGerarNFSe: String;
    ProRecepcaoSincrono: String;
    ProSubstituiNFSe: String;
  end;

 TConfigEnvelope = record
    CabecalhoMsg: String;
    Recepcionar: String;
    ConsSit: String;
    ConsLote: String;
    ConsNFSeRps: String;
    ConsNFSe: String;
    Cancelar: String;
    Gerar: String;
    RecSincrono: String;
    Substituir: String;
 end;

  { TGeralConfNFSe }

  TGeralConfNFSe = class(TGeralConf)
  private
    FPIniParams: TMemIniFile;

    FConfigGeral: TConfigGeral;
    FConfigNameSpace: TConfigNameSpace;
    FConfigAssinar: TConfigAssinar;
    FConfigXML: TConfigXML;
    FConfigSchemas: TConfigSchemas;
    FConfigSoapAction: TConfigSoapAction;
    FConfigURL: TConfigURL;
    FConfigEnvelope: TConfigEnvelope;

    FCodigoMunicipio: Integer;
    FProvedor: TnfseProvedor;
    FxProvedor: String;
    FxMunicipio: String;
    FxUF: String;
    FxNomeURL_H: String;
    FxNomeURL_P: String;
    FSenhaWeb: String;
    FUserWeb: String;
    FConsultaLoteAposEnvio: Boolean;

    procedure SetCodigoMunicipio(const Value: Integer);

  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeGeralConfNFSe: TGeralConfNFSe); overload;
    procedure SetConfigMunicipio;

    property ConfigGeral: TConfigGeral read FConfigGeral;
    property ConfigNameSpace: TConfigNameSpace read FConfigNameSpace;
    property ConfigAssinar: TConfigAssinar read FConfigAssinar;
    property ConfigXML: TConfigXML read FConfigXML;
    property ConfigSchemas: TConfigSchemas read FConfigSchemas;
    property ConfigSoapAction: TConfigSoapAction read FConfigSoapAction;
    property ConfigURL: TConfigURL read FConfigURL;
    property ConfigEnvelope: TConfigEnvelope read FConfigEnvelope;
  published
    property CodigoMunicipio: Integer read FCodigoMunicipio write SetCodigoMunicipio;
    property Provedor: TnfseProvedor read FProvedor;
    property xProvedor: String read FxProvedor;
    property xMunicipio: String read FxMunicipio;
    property xUF: String read FxUF;
    // Alguns provedores possui o nome da cidade na URL dos WebServer
    property xNomeURL_H: String read FxNomeURL_H;
    property xNomeURL_P: String read FxNomeURL_P;

    property SenhaWeb: String read FSenhaWeb write FSenhaWeb;
    property UserWeb: String read FUserWeb write FUserWeb;
    property ConsultaLoteAposEnvio: Boolean read FConsultaLoteAposEnvio write FConsultaLoteAposEnvio;
  end;

  { TArquivosConfNFSe }

  TArquivosConfNFSe = class(TArquivosConf)
  private
    FEmissaoPathNFSe: boolean;
    FSalvarApenasNFSeProcessadas: boolean;
    FPathGer: String;
    FPathRPS: String;
    FPathNFSe: String;
    FPathCan: String;
    FNomeLongoNFSe: Boolean;
    FTabServicosExt: Boolean;
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeArquivosConfNFSe: TArquivosConfNFSe); overload;

    function GetPathGer(Data: TDateTime = 0; CNPJ: String = ''): String;
    function GetPathRPS(Data: TDateTime = 0; CNPJ: String = ''): String;
    function GetPathNFSe(Data: TDateTime = 0; CNPJ: String = ''): String;
    function GetPathCan(Data: TDateTime = 0; CNPJ: String = ''): String;
  published
    property EmissaoPathNFSe: boolean read FEmissaoPathNFSe
      write FEmissaoPathNFSe default False;
    property SalvarApenasNFSeProcessadas: boolean
      read FSalvarApenasNFSeProcessadas write FSalvarApenasNFSeProcessadas default False;
    property PathGer: String read FPathGer write FPathGer;
    property PathRPS: String read FPathRPS  write FPathRPS;
    property PathNFSe: String read FPathNFSe write FPathNFSe;
    property PathCan: String read FPathCan write FPathCan;
    property NomeLongoNFSe: Boolean read FNomeLongoNFSe write FNomeLongoNFSe default False;
    property TabServicosExt: Boolean read FTabServicosExt write FTabServicosExt default False;
  end;

  { TConfiguracoesNFSe }

  TConfiguracoesNFSe = class(TConfiguracoes)
  private
    function GetArquivos: TArquivosConfNFSe;
    function GetGeral: TGeralConfNFSe;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(DeConfiguracoesNFSe: TConfiguracoesNFSe); overload;

  published
    property Geral: TGeralConfNFSe read GetGeral;
    property Arquivos: TArquivosConfNFSe read GetArquivos;
    property WebServices;
    property Certificados;
  end;

implementation

uses
  ACBrUtil,
  DateUtils;

{ TConfiguracoesNFSe }

constructor TConfiguracoesNFSe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  WebServices.ResourceName := 'ACBrNFSeServicos';
end;

procedure TConfiguracoesNFSe.Assign(DeConfiguracoesNFSe: TConfiguracoesNFSe);
begin
  Geral.Assign(DeConfiguracoesNFSe.Geral);
  WebServices.Assign(DeConfiguracoesNFSe.WebServices);
  Certificados.Assign(DeConfiguracoesNFSe.Certificados);
  Arquivos.Assign(DeConfiguracoesNFSe.Arquivos);
end;

function TConfiguracoesNFSe.GetArquivos: TArquivosConfNFSe;
begin
  Result := TArquivosConfNFSe(FPArquivos);
end;

function TConfiguracoesNFSe.GetGeral: TGeralConfNFSe;
begin
  Result := TGeralConfNFSe(FPGeral);
end;

procedure TConfiguracoesNFSe.CreateGeralConf;
begin
  FPGeral := TGeralConfNFSe.Create(Self);
end;

procedure TConfiguracoesNFSe.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfNFSe.Create(self);
end;

{ TGeralConfNFSe }

constructor TGeralConfNFSe.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FProvedor := proNenhum;
end;

procedure TGeralConfNFSe.Assign(DeGeralConfNFSe: TGeralConfNFSe);
begin
  inherited Assign(DeGeralConfNFSe);

  FProvedor := DeGeralConfNFSe.Provedor;
end;

procedure TGeralConfNFSe.SetCodigoMunicipio(const Value: Integer);
begin
  FCodigoMunicipio := Value;
  if FCodigoMunicipio <> 0 then
    SetConfigMunicipio;
end;

procedure TGeralConfNFSe.SetConfigMunicipio;
var
  Ok: Boolean;
  NomeArqParams, Texto, sCampo, sFim, CodIBGE: String;
  I: Integer;
begin
  // ===========================================================================
  // Verifica se o c�digo IBGE consta no arquivo de param�tros: Cidades.ini
  // se encontrar retorna o nome do Provedor
  // ===========================================================================
  NomeArqParams := ApplicationPath + 'Cidades.ini';
  CodIBGE := IntToStr(FCodigoMunicipio);

  if not FileExists(NomeArqParams) then
    raise Exception.Create('Arquivo de Par�metro n�o encontrado: ' +
      NomeArqParams);

  FPIniParams := TMemIniFile.Create(NomeArqParams);

  FxProvedor := FPIniParams.ReadString(CodIBGE, 'Provedor', '');
  FProvedor  := StrToProvedor(Ok, FxProvedor);
  FxMunicipio := FPIniParams.ReadString(CodIBGE, 'Nome', '');
  FxUF := FPIniParams.ReadString(CodIBGE, 'UF', '');
  FxNomeURL_H := FPIniParams.ReadString(CodIBGE, 'NomeURL_H', '');
  FxNomeURL_P := FPIniParams.ReadString(CodIBGE, 'NomeURL_P', '');

  FPIniParams.Free;

  if FProvedor = proNenhum
   then raise Exception.Create('C�digo do Municipio ['+ CodIBGE +'] n�o Encontrado.');

  // ===========================================================================
  // Le as configura��es especificas do Provedor referente a cidade desejada
  // ===========================================================================
  NomeArqParams := ApplicationPath + FxProvedor +'.ini';

  if not FileExists(NomeArqParams) then
    raise Exception.Create('Arquivo de Par�metro n�o encontrado: ' +
      NomeArqParams);

  FPIniParams := TMemIniFile.Create(NomeArqParams);

  FConfigGeral.VersaoSoap := FPIniParams.ReadString('Geral', 'VersaoSoap', '');
  FConfigGeral.Prefixo2 := FPIniParams.ReadString('Geral', 'Prefixo2', '');
  FConfigGeral.Prefixo3 := FPIniParams.ReadString('Geral', 'Prefixo3', '');
  FConfigGeral.Prefixo4 := FPIniParams.ReadString('Geral', 'Prefixo4', '');
  FConfigGeral.Identificador := FPIniParams.ReadString('Geral', 'Identificador', '');
  FConfigGeral.QuebradeLinha := FPIniParams.ReadString('Geral', 'QuebradeLinha', '');

  FConfigNameSpace.Producao := FPIniParams.ReadString('NameSpace', 'Producao', '');
  FConfigNameSpace.Homologacao := FPIniParams.ReadString('NameSpace', 'Homologacao', '');

  FConfigAssinar.RPS := FPIniParams.ReadBool('Assinar', 'RPS', False);
  FConfigAssinar.Lote := FPIniParams.ReadBool('Assinar', 'Lote', False);
  FConfigAssinar.URI := FPIniParams.ReadBool('Assinar', 'URI', False);
  FConfigAssinar.Recepcionar := FPIniParams.ReadBool('Assinar', 'Recepcionar', False);
  FConfigAssinar.ConsSit := FPIniParams.ReadBool('Assinar', 'ConsSit', False);
  FConfigAssinar.ConsLote := FPIniParams.ReadBool('Assinar', 'ConsLote', False);
  FConfigAssinar.ConsNFSeRps := FPIniParams.ReadBool('Assinar', 'ConsNFSeRps', False);
  FConfigAssinar.ConsNFSe := FPIniParams.ReadBool('Assinar', 'ConsNFSe', False);
  FConfigAssinar.Cancelar := FPIniParams.ReadBool('Assinar', 'Cancelar', False);
  FConfigAssinar.Gerar := FPIniParams.ReadBool('Assinar', 'Gerar', False);
  FConfigAssinar.RecSincrono := FPIniParams.ReadBool('Assinar', 'RecSincrono', False);
  FConfigAssinar.Substituir := FPIniParams.ReadBool('Assinar', 'Substituir', False);

  FConfigXML.VersaoCabecalho := FPIniParams.ReadString('XML', 'VersaoCabecalho', '');
  FConfigXML.VersaoDados := FPIniParams.ReadString('XML', 'VersaoDados', '');
  FConfigXML.VersaoXML := FPIniParams.ReadString('XML', 'VersaoXML', '');
  FConfigXML.NameSpace := Trim(FPIniParams.ReadString('XML', 'NameSpace', ''));
  FConfigXML.CabecalhoStr := FPIniParams.ReadBool('XML', 'Cabecalho', False);
  FConfigXML.DadosStr := FPIniParams.ReadBool('XML', 'Dados', False);

  FConfigSchemas.Validar := FPIniParams.ReadBool('Schemas', 'Validar', True);
  FConfigSchemas.DefTipos := FPIniParams.ReadString('Schemas', 'DefTipos', '');
  FConfigSchemas.Cabecalho := FPIniParams.ReadString('Schemas', 'Cabecalho', '');
  FConfigSchemas.ServicoEnviar := FPIniParams.ReadString('Schemas', 'ServicoEnviar', '');
  FConfigSchemas.ServicoConSit := FPIniParams.ReadString('Schemas', 'ServicoConsSit', '');
  FConfigSchemas.ServicoConLot := FPIniParams.ReadString('Schemas', 'ServicoConsLot', '');
  FConfigSchemas.ServicoConRps := FPIniParams.ReadString('Schemas', 'ServicoConsRps', '');
  FConfigSchemas.ServicoConNfse := FPIniParams.ReadString('Schemas', 'ServicoConsNfse', '');
  FConfigSchemas.ServicoCancelar := FPIniParams.ReadString('Schemas', 'ServicoCancelar', '');
  FConfigSchemas.ServicoGerar := FPIniParams.ReadString('Schemas', 'ServicoGerar', '');
  FConfigSchemas.ServicoEnviarSincrono := FPIniParams.ReadString('Schemas', 'ServicoEnviarSincrono', '');
  FConfigSchemas.ServicoSubstituir := FPIniParams.ReadString('Schemas', 'ServicoSubstituir', '');

  FConfigSoapAction.Recepcionar := FPIniParams.ReadString('SoapAction', 'Recepcionar', '');
  FConfigSoapAction.ConsSit := FPIniParams.ReadString('SoapAction', 'ConsSit', '');
  FConfigSoapAction.ConsLote := FPIniParams.ReadString('SoapAction', 'ConsLote', '');
  FConfigSoapAction.ConsNFSeRps := FPIniParams.ReadString('SoapAction', 'ConsNFSeRps', '');
  FConfigSoapAction.ConsNFSe := FPIniParams.ReadString('SoapAction', 'ConsNFSe', '');
  FConfigSoapAction.Cancelar := FPIniParams.ReadString('SoapAction', 'Cancelar', '');
  FConfigSoapAction.Gerar := FPIniParams.ReadString('SoapAction', 'Gerar', '');
  FConfigSoapAction.RecSincrono := FPIniParams.ReadString('SoapAction', 'RecSincrono', '');
  FConfigSoapAction.Substituir := FPIniParams.ReadString('SoapAction', 'Substituir', '');

  FConfigURL.HomRecepcaoLoteRPS := StringReplace(FPIniParams.ReadString('URL_H', 'RecepcaoLoteRPS', ''), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomConsultaLoteRPS := StringReplace(FPIniParams.ReadString('URL_H', 'ConsultaLoteRPS', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomConsultaSitLoteRPS := StringReplace(FPIniParams.ReadString('URL_H', 'ConsultaSitLoteRPS', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomConsultaNFSeRPS := StringReplace(FPIniParams.ReadString('URL_H', 'ConsultaNFSeRPS', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomConsultaNFSe := StringReplace(FPIniParams.ReadString('URL_H', 'ConsultaNFSe', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomCancelaNFSe := StringReplace(FPIniParams.ReadString('URL_H', 'CancelaNFSe', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomGerarNFSe := StringReplace(FPIniParams.ReadString('URL_H', 'GerarNFSe', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomRecepcaoSincrono := StringReplace(FPIniParams.ReadString('URL_H', 'RecepcaoSincrono', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);
  FConfigURL.HomSubstituiNFSe := StringReplace(FPIniParams.ReadString('URL_H', 'SubstituiNFSe', FConfigURL.HomRecepcaoLoteRPS), '%NomeURL_H%', FxNomeURL_H, [rfReplaceAll]);

  if FPIniParams.ReadString('URL_P', 'RecepcaoLoteRPS', '') = '*******' then
  begin
    FConfigURL.ProRecepcaoLoteRPS := FPIniParams.ReadString('URL_P', 'RecepcaoLoteRPS_' + CodIBGE, '');
    FConfigURL.ProConsultaLoteRPS := FPIniParams.ReadString('URL_P', 'ConsultaLoteRPS_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProConsultaSitLoteRPS := FPIniParams.ReadString('URL_P', 'ConsultaSitLoteRPS_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProConsultaNFSeRPS := FPIniParams.ReadString('URL_P', 'ConsultaNFSeRPS_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProConsultaNFSe := FPIniParams.ReadString('URL_P', 'ConsultaNFSe_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProCancelaNFSe := FPIniParams.ReadString('URL_P', 'CancelaNFSe_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProGerarNFSe := FPIniParams.ReadString('URL_P', 'GerarNFSe_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProRecepcaoSincrono := FPIniParams.ReadString('URL_P', 'RecepcaoSincrono_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
    FConfigURL.ProSubstituiNFSe := FPIniParams.ReadString('URL_P', 'SubstituiNFSe_' + CodIBGE, FConfigURL.ProRecepcaoLoteRPS);
  end
  else
  begin
    FConfigURL.ProRecepcaoLoteRPS := StringReplace(FPIniParams.ReadString('URL_P', 'RecepcaoLoteRPS', ''), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProConsultaLoteRPS := StringReplace(FPIniParams.ReadString('URL_P', 'ConsultaLoteRPS', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProConsultaSitLoteRPS := StringReplace(FPIniParams.ReadString('URL_P', 'ConsultaSitLoteRPS', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProConsultaNFSeRPS := StringReplace(FPIniParams.ReadString('URL_P', 'ConsultaNFSeRPS', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProConsultaNFSe := StringReplace(FPIniParams.ReadString('URL_P', 'ConsultaNFSe', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProCancelaNFSe := StringReplace(FPIniParams.ReadString('URL_P', 'CancelaNFSe', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProGerarNFSe := StringReplace(FPIniParams.ReadString('URL_P', 'GerarNFSe', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProRecepcaoSincrono := StringReplace(FPIniParams.ReadString('URL_P', 'RecepcaoSincrono', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
    FConfigURL.ProSubstituiNFSe := StringReplace(FPIniParams.ReadString('URL_P', 'SubstituiNFSe', FConfigURL.ProRecepcaoLoteRPS), '%NomeURL_P%', FxNomeURL_P, [rfReplaceAll]);
  end;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('CabecalhoMsg', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.CabecalhoMsg := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('Recepcionar', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.Recepcionar := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('ConsSit', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.ConsSit := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('ConsLote', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.ConsLote := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('ConsNFSeRps', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.ConsNFSeRps := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('ConsNFSe', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.ConsNFSe := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('Cancelar', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.Cancelar := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('Gerar', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.Gerar := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('RecSincrono', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.RecSincrono := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('Substituir', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigEnvelope.Substituir := Texto;

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('RetornoNFSe', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigGeral.RetornoNFSe := Texto;

  FConfigGeral.ProLinkNFSe := FPIniParams.ReadString('LinkNFSe', 'Producao', '');
  FConfigGeral.HomLinkNFSe := FPIniParams.ReadString('LinkNFSe', 'Homologacao', '');

  Texto := '';
  I := 1;
  while true do
  begin
    sCampo := 'Texto' + IntToStr(I);
    sFim   := FPIniParams.ReadString('DadosSenha', sCampo, 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;
    Texto := Texto + sFim;
    Inc(I);
  end;
  FConfigGeral.DadosSenha := Texto;

  FPIniParams.Free;
end;

{ TArquivosConfNFSe }

constructor TArquivosConfNFSe.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FEmissaoPathNFSe := False;
  FSalvarApenasNFSeProcessadas := False;
  FPathGer := '';
  FPathRPS := '';
  FPathNFSe := '';
  FPathCan := '';
  FNomeLongoNFSe := False;
  FTabServicosExt := False;
end;

procedure TArquivosConfNFSe.Assign(DeArquivosConfNFSe: TArquivosConfNFSe);
begin
  inherited Assign(DeArquivosConfNFSe);

  EmissaoPathNFSe := DeArquivosConfNFSe.EmissaoPathNFSe;
  SalvarApenasNFSeProcessadas := DeArquivosConfNFSe.SalvarApenasNFSeProcessadas;
  PathGer := DeArquivosConfNFSe.PathGer;
  PathRPS := DeArquivosConfNFSe.PathRPS;
  PathNFSe := DeArquivosConfNFSe.PathNFSe;
  PathCan := DeArquivosConfNFSe.PathCan;
  NomeLongoNFSe := DeArquivosConfNFSe.NomeLongoNFSe;
  TabServicosExt := DeArquivosConfNFSe.TabServicosExt;
end;

function TArquivosConfNFSe.GetPathGer(Data: TDateTime;
  CNPJ: String): String;
begin
  Result := GetPath(FPathGer, 'Ger', CNPJ, Data);
end;

function TArquivosConfNFSe.GetPathRPS(Data: TDateTime;
  CNPJ: String): String;
begin
  Result := GetPath(FPathRPS, 'RPS', CNPJ, Data);
end;

function TArquivosConfNFSe.GetPathNFSe(Data: TDateTime = 0;
  CNPJ: String = ''): String;
begin
  Result := GetPath(FPathNFSe, 'NFSe', CNPJ, Data);
end;

function TArquivosConfNFSe.GetPathCan(Data: TDateTime = 0;
  CNPJ: String = ''): String;
begin
  Result := GetPath(FPathCan, 'Can', CNPJ, Data);
end;

end.
