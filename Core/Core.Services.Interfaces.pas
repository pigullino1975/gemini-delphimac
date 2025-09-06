unit Core.Services.Interfaces;

interface

type
  IPasswordHasher = interface(IInterface)
    ['{F2C3B4A1-4D5E-4F6A-8A1B-3C2D1E0F9A8B}']
    function Hash(const APassword: string): string;
    function Verify(const APassword, AHash: string): Boolean;
  end;

implementation

end.
