unit Core.UseCases.RegisterUser.Implementation;

interface

uses
  System.SysUtils,
  Core.UseCases.RegisterUser.Abstractions,
  Core.Repositories.Interfaces,
  Core.Services.Interfaces;

type
  TRegisterUserUseCase = class(TInterfacedObject, IRegisterUserUseCase)
  private
    FUserRepository: IUserRepository;
    FPasswordHasher: IPasswordHasher;
    procedure ValidateRequest(const ARequest: TRegisterUserRequest);
  public
    constructor Create(const AUserRepository: IUserRepository; const APasswordHasher: IPasswordHasher);
    function Execute(const ARequest: TRegisterUserRequest): TRegisterUserResponse;
  end;

implementation

uses
  Core.Entities.User,
  Core.Exceptions,
  System.DateUtils;

constructor TRegisterUserUseCase.Create(const AUserRepository: IUserRepository; const APasswordHasher: IPasswordHasher);
begin
  FUserRepository := AUserRepository;
  FPasswordHasher := APasswordHasher;
end;

procedure TRegisterUserUseCase.ValidateRequest(const ARequest: TRegisterUserRequest);
begin
  if (ARequest = nil) or (ARequest.Username.IsEmpty or ARequest.Email.IsEmpty or ARequest.Password.IsEmpty) then
    raise EValidationException.Create('Username, Email, and Password are required.');

  if FUserRepository.UsernameExists(ARequest.Username) then
    raise EResourceAlreadyExistsException.CreateFmt('Username \'%s\' is already taken.', [ARequest.Username]);

  if FUserRepository.EmailExists(ARequest.Email) then
    raise EResourceAlreadyExistsException.CreateFmt('Email \'%s\' is already registered.', [ARequest.Email]);
end;

function TRegisterUserUseCase.Execute(const ARequest: TRegisterUserRequest): TRegisterUserResponse;
var
  LNewUser: TUser;
begin
  ValidateRequest(ARequest);

  LNewUser := TUser.Create;
  try
    LNewUser.Username := ARequest.Username;
    LNewUser.Email := ARequest.Email;
    LNewUser.PasswordHash := FPasswordHasher.Hash(ARequest.Password);
    LNewUser.IsActive := True;

    FUserRepository.Add(LNewUser);

    Result := TRegisterUserResponse.Create;
    Result.UserId := LNewUser.Id;
    Result.Username := LNewUser.Username;
    Result.Email := LNewUser.Email;
    Result.CreatedAt := Now;
  finally
    LNewUser.Free;
  end;
end;

end.