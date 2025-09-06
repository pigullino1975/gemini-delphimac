unit Core.Exceptions;

interface

uses System.SysUtils;

// Excepción base para errores de validación de datos de entrada.
EValidationException = class(Exception);

// Excepción específica para cuando un recurso ya existe (ej. email o usuario duplicado).
EResourceAlreadyExistsException = class(Exception);

implementation

end.
