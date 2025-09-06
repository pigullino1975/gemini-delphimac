program DelphiCleanArch;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Core.Entities.User in 'Core\Core.Entities.User.pas',
  Core.Exceptions in 'Core\Core.Exceptions.pas',
  Core.Repositories.Interfaces in 'Core\Core.Repositories.Interfaces.pas',
  Core.Services.Interfaces in 'Core\Core.Services.Interfaces.pas',
  Core.UseCases.RegisterUser.Abstractions in 'Core\Core.UseCases.RegisterUser.Abstractions.pas',
  Core.UseCases.RegisterUser.Implementation in 'Core\Core.UseCases.RegisterUser.Implementation.pas',
  Infrastructure.Services.PasswordHasher in 'Infrastructure\Infrastructure.Services.PasswordHasher.pas',
  Infrastructure.Persistence.Firebird.UserRepository in 'Infrastructure\Infrastructure.Persistence.Firebird.UserRepository.pas';

begin
  try
    Writeln('Project DelphiCleanArch created successfully.');
    Writeln('Core units included. Ready to build the Infrastructure layer.');
    // En el futuro, aquí se iniciará el servidor web.
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  // Readln; // Descomentar para mantener la consola abierta

end.
