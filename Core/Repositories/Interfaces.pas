unit Core.Repositories.Interfaces;

interface

uses
  System.SysUtils,
  Core.Entities.User;

type
  {
    IUserRepository
    Define las operaciones de persistencia para la entidad TUser.
    Cualquier clase que implemente esta interfaz será responsable
    de guardar, recuperar y modificar los datos de los usuarios
    en una fuente de datos (ej: base de datos, archivo, etc.).
  }
  IUserRepository = interface(IInterface)
    ['{B8A3D84E-3C6D-4C1F-A4A2-7E2D3B9F1A0C}']

    // Busca un usuario por su Identificador Único (GUID).
    // Retorna nil si no se encuentra.
    function FindById(const AId: TGuid): TUser;

    // Busca un usuario por su nombre de usuario.
    // Retorna nil si no se encuentra.
    function FindByUsername(const AUsername: string): TUser;

    // Busca un usuario por su dirección de email.
    // Retorna nil si no se encuentra.
    function FindByEmail(const AEmail: string): TUser;

    // Guarda un nuevo usuario en la persistencia.
    procedure Add(const AUser: TUser);

    // Actualiza los datos de un usuario existente.
    procedure Update(const AUser: TUser);

    // Elimina un usuario por su ID.
    procedure Delete(const AId: TGuid);

    // Verifica si un nombre de usuario ya existe.
    function UsernameExists(const AUsername: string): Boolean;

    // Verifica si un email ya existe.
    function EmailExists(const AEmail:string): Boolean;
  end;

implementation

end.