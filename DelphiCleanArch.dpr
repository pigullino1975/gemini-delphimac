program DelphiCleanArch;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  // --- Core Units ---
  Core.Entities.User in 'Core\Entities\User.pas',
  Core.Exceptions in 'Core\Exceptions\Exceptions.pas',
  Core.Repositories.Interfaces in 'Core\Repositories\Interfaces.pas',
  Core.Services.Interfaces in 'Core\Services\Interfaces.pas',
  Core.UseCases.RegisterUser.Abstractions in 'Core\UseCases\RegisterUser\Abstractions.pas',
  Core.UseCases.RegisterUser.Implementation in 'Core\UseCases\RegisterUser\Implementation.pas',
  // --- Infrastructure Units ---
  Infrastructure.Services.PasswordHasher in 'Infrastructure\Services\PasswordHasher.pas',
  Infrastructure.Persistence.Firebird.UserRepository in 'Infrastructure\Persistence\Firebird\UserRepository.pas';

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
