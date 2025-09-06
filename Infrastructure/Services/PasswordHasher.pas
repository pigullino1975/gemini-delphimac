unit Infrastructure.Services.PasswordHasher;

interface

uses
  Core.Services.Interfaces;

// TPasswordHasher implementa la interfaz IPasswordHasher usando el algoritmo Argon2.
// Depende de la librería externa delphi-argon2.
// Repositorio: https://github.com/atorgov/delphi-argon2
type
  TPasswordHasher = class(TInterfacedObject, IPasswordHasher)
  public
    function Hash(const APassword: string): string;
    function Verify(const APassword, AHash: string): Boolean;
  end;

implementation

uses
  System.SysUtils,
  Argon2; // Esta es la unidad principal de la librería delphi-argon2

function TPasswordHasher.Hash(const APassword: string): string;
var
  LArgon2: TArgon2;
begin
  LArgon2 := TArgon2.Create;
  try
    // Usamos los parámetros recomendados por defecto de la librería.
    // Estos parámetros (coste de memoria, iteraciones, paralelismo) definen la "fuerza" del hash.
    Result := LArgon2.Hash(APassword);
  finally
    LArgon2.Free;
  end;
end;

function TPasswordHasher.Verify(const APassword, AHash: string): Boolean;
var
  LArgon2: TArgon2;
begin
  LArgon2 := TArgon2.Create;
  try
    Result := LArgon2.Verify(AHash, APassword);
  finally
    LArgon2.Free;
  end;
end;

end.
