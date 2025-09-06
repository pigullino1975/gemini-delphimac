unit Core.UseCases.RegisterUser.Abstractions;

interface

uses
  Core.Entities.User;

type
  // Datos de entrada para el caso de uso de registro
  TRegisterUserRequest = class
  public
    Username: string;
    Email: string;
    Password: string;
  end;

  // Datos de salida del caso de uso de registro
  TRegisterUserResponse = class
  public
    UserId: TGuid;
    Username: string;
    Email: string;
    CreatedAt: TDateTime;
  end;

  // Interfaz para el caso de uso (Interactor)
  IRegisterUserUseCase = interface(IInterface)
    ['{E7E3B5D1-F4F7-4B1A-8A0E-3B6C0E7D3A21}']
    function Execute(const ARequest: TRegisterUserRequest): TRegisterUserResponse;
  end;

implementation

end.
