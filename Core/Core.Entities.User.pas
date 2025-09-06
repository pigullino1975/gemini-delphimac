unit Core.Entities.User;

interface

uses
  System.Generics.Collections;

type
  TUserRole = (urAdmin, urOperator, urAuditor);
  TUserRoles = set of TUserRole;

  TUser = class
  private
    FId: TGuid;
    FUsername: string;
    FEmail: string;
    FPasswordHash: string; // NUNCA guardar la contraseña en texto plano
    FIsActive: Boolean;
    FMfaSecret: string;   // Secreto para el autenticador (Google/Microsoft Authenticator)
    FMfaIsEnabled: Boolean;
    FRoles: TUserRoles;
  public
    constructor Create;

    property Id: TGuid read FId write FId;
    property Username: string read FUsername write FUsername;
    property Email: string read FEmail write FEmail;
    property PasswordHash: string read FPasswordHash write FPasswordHash;
    property IsActive: Boolean read FIsActive write FIsActive;
    property MfaSecret: string read FMfaSecret write FMfaSecret;
    property MfaIsEnabled: Boolean read FMfaIsEnabled write FMfaIsEnabled;
    property Roles: TUserRoles read FRoles write FRoles;
  end;

implementation

uses
  System.SysUtils;

constructor TUser.Create;
begin
  inherited;
  FId := TGuid.NewGuid;
  FIsActive := True;
  FMfaIsEnabled := False;
end;

end.