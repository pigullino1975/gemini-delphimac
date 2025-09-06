unit Infrastructure.Persistence.Firebird.UserRepository;

interface

uses
  FireDAC.Comp.Client,
  Core.Repositories.Interfaces;

type
  TFirebirdUserRepository = class(TInterfacedObject, IUserRepository)
  private
    FConnection: TFDConnection;
    function QueryToUser(AQuery: TFDQuery): TUser;
  public
    constructor Create(const AConnection: TFDConnection);

    // IUserRepository
    function FindById(const AId: TGuid): TUser;
    function FindByUsername(const AUsername: string): TUser;
    function FindByEmail(const AEmail: string): TUser;
    procedure Add(const AUser: TUser);
    procedure Update(const AUser: TUser);
    procedure Delete(const AId: TGuid);
    function UsernameExists(const AUsername: string): Boolean;
    function EmailExists(const AEmail: string): Boolean;
  end;

implementation

uses
  System.SysUtils,
  Core.Entities.User;

constructor TFirebirdUserRepository.Create(const AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TFirebirdUserRepository.QueryToUser(AQuery: TFDQuery): TUser;
begin
  Result := TUser.Create;
  Result.Id := AQuery.FieldByName('ID').AsGUID;
  Result.Username := AQuery.FieldByName('USERNAME').AsString;
  Result.Email := AQuery.FieldByName('EMAIL').AsString;
  Result.PasswordHash := AQuery.FieldByName('PASSWORD_HASH').AsString;
  Result.IsActive := AQuery.FieldByName('IS_ACTIVE').AsBoolean;
  Result.MfaSecret := AQuery.FieldByName('MFA_SECRET').AsString;
  Result.MfaIsEnabled := AQuery.FieldByName('MFA_IS_ENABLED').AsBoolean;
  // Aquí se podrían cargar los roles si estuvieran en otra tabla o campo
end;

procedure TFirebirdUserRepository.Add(const AUser: TUser);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'INSERT INTO USERS (ID, USERNAME, EMAIL, PASSWORD_HASH, IS_ACTIVE, MFA_SECRET, MFA_IS_ENABLED) ' +
                  'VALUES (:ID, :USERNAME, :EMAIL, :PASSWORD_HASH, :IS_ACTIVE, :MFA_SECRET, :MFA_IS_ENABLED)';
    Q.ParamByName('ID').AsGUID := AUser.Id;
    Q.ParamByName('USERNAME').AsString := AUser.Username;
    Q.ParamByName('EMAIL').AsString := AUser.Email;
    Q.ParamByName('PASSWORD_HASH').AsString := AUser.PasswordHash;
    Q.ParamByName('IS_ACTIVE').AsBoolean := AUser.IsActive;
    Q.ParamByName('MFA_SECRET').AsString := AUser.MfaSecret;
    Q.ParamByName('MFA_IS_ENABLED').AsBoolean := AUser.MfaIsEnabled;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TFirebirdUserRepository.Delete(const AId: TGuid);
begin
  // Implementación de borrado
end;

function TFirebirdUserRepository.EmailExists(const AEmail: string): Boolean;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'SELECT 1 FROM USERS WHERE EMAIL = :EMAIL';
    Q.ParamByName('EMAIL').AsString := AEmail;
    Q.Open;
    Result := not Q.IsEmpty;
  finally
    Q.Free;
  end;
end;

function TFirebirdUserRepository.FindByEmail(const AEmail: string): TUser;
var
  Q: TFDQuery;
begin
  Result := nil;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'SELECT * FROM USERS WHERE EMAIL = :EMAIL';
    Q.ParamByName('EMAIL').AsString := AEmail;
    Q.Open;
    if not Q.IsEmpty then
      Result := QueryToUser(Q);
  finally
    Q.Free;
  end;
end;

function TFirebirdUserRepository.FindById(const AId: TGuid): TUser;
begin
  // Implementación de búsqueda por ID
end;

function TFirebirdUserRepository.FindByUsername(const AUsername: string): TUser;
var
  Q: TFDQuery;
begin
  Result := nil;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'SELECT * FROM USERS WHERE USERNAME = :USERNAME';
    Q.ParamByName('USERNAME').AsString := AUsername;
    Q.Open;
    if not Q.IsEmpty then
      Result := QueryToUser(Q);
  finally
    Q.Free;
  end;
end;

procedure TFirebirdUserRepository.Update(const AUser: TUser);
begin
  // Implementación de actualización
end;

function TFirebirdUserRepository.UsernameExists(const AUsername: string): Boolean;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'SELECT 1 FROM USERS WHERE USERNAME = :USERNAME';
    Q.ParamByName('USERNAME').AsString := AUsername;
    Q.Open;
    Result := not Q.IsEmpty;
  finally
    Q.Free;
  end;
end;

end.
