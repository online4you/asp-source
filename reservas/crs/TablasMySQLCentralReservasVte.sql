CREATE TABLE Categorias (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,Nombre_es nvarchar(50) NULL,Nombre_it nvarchar(50) NULL,Nombre_en nvarchar(50) NULL,Nombre_de nvarchar(50) NULL,Nombre_fr nvarchar(50) NULL,IdTipo int ZEROFILL);

CREATE TABLE Colectivos (CodigoColec int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int NOT NULL, 
Orde int ZEROFILL NULL,Nombre_es nvarchar(50) NULL,
Nombre_it nvarchar(50) NULL,Nombre_en nvarchar(50) NULL,
Nombre_de nvarchar(50) NULL,Nombre_fr nvarchar(50) NULL);

CREATE INDEX IndiIDColec ON Colectivos (CodigoEsta);

CREATE TABLE ColectivosNomres (ColectivoId INT ZEROFILL,
Idioma nvarchar(2),Nombre nvarchar(50));

CREATE TABLE CondicionesHotel (CodigoEsta INT ZEROFILL,
Texto1_es TEXT NULL,Texto1_it TEXT NULL,Texto1_en TEXT NULL,Texto1_de TEXT NULL,Texto1_fr TEXT NULL);

CREATE INDEX CONDICIONESHOTEL_CodigoEsta ON CONDICIONESHOTEL (CodigoEsta);

CREATE TABLE Cupos(CodigoHab int ZEROFILL NOT NULL,
CodigoEsta int ZEROFILL,Dia datetime,Cupo int ZEROFILL,
Precio real ZEROFILL,DiasMinimos int default(1),Release int ZEROFILL);

CREATE INDEX CUPOS_CODIGOHAB ON CUPOS (CodigoHab);
CREATE INDEX CUPOS_Dia ON CUPOS (dia);

CREATE TABLE DatosHotel(CodigoEsta int ZEROFILL,EMail nvarchar(100),Direccion nvarchar(50),
CP nvarchar(15),Poblacion nvarchar(50),Telefono nvarchar(25),PID nvarchar(30),PID2 nvarchar(30),
FAX nvarchar(25),AVISO bit ZEROFILL,URL nvarchar(100),Zona int ZEROFILL,TipoAlojamiento int ZEROFILL,
Categoria int ZEROFILL,NombrePagina nvarchar(25));

CREATE INDEX DATOSHOTEL_CodigoEsta ON DATOSHOTEL (CodigoEsta);

CREATE TABLE DescuentosColectivos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,CodigoColec int ZEROFILL,Temporada int ZEROFILL,TipoHab int ZEROFILL,Prebase int ZEROFILL,Precio real ZEROFILL,Anyo int ZEROFILL);

CREATE INDEX DESCUENTOSCOLECTIVOS_CODIGOCOLEC ON DescuentosColectivos (CodigoColec);
CREATE INDEX DESCUENTOSCOLECTIVOS_Hab ON DescuentosColectivos (TipoHab);
CREATE INDEX DESCUENTOSCOLECTIVOS_Tempo ON DescuentosColectivos (Temporada);

CREATE TABLE Establecimientos(CodigoEsta int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Orde int ZEROFILL,PorCiento real ZEROFILL,
PrepagoMinimo int ZEROFILL,MinDias int ZEROFILL, DiasAnulacion int ZEROFILL,
Estado int ZEROFILL,OBS TEXT NULL,Moneda int ZEROFILL);

CREATE INDEX ESTABLECIMIENTOS_CodigoEsta ON Establecimientos (CodigoEsta);

CREATE TABLE Extras (ID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int ZEROFILL,Extra_es nvarchar(100),Extra_it nvarchar(100),
Extra_en nvarchar(100),Extra_de nvarchar(100),Extra_fr nvarchar(100),
FInicio Datetime,FFinal Datetime,Importe real ZEROFILL,PorPersona bit ZEROFILL,
Colectivo int ZEROFILL,Descuento real ZEROFILL,ImporteDto real ZEROFILL,
Colectivo2 int ZEROFILL,Descuento2 real ZEROFILL,ImporteDto2 real ZEROFILL,
TipoSuple nvarchar(50),TipoHabi nvarchar(50));

CREATE INDEX EXTRAS_CodigoEsta ON EXTRAS (CodigoEsta);
CREATE INDEX EXTRAS_Fechas ON EXTRAS (FInicio,FFinal);

CREATE TABLE Fichas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Apellidos nvarchar(50),Nombre nvarchar(50),Telefono nvarchar(25),FAX nvarchar(25),
Direccion nvarchar(50),CP nvarchar(15),Poblacion nvarchar(50),Provincia nvarchar(50),
Pais nvarchar(2),EMail nvarchar(75),Sexo nvarchar(10),FechaLlegada Datetime,
FechaSalida Datetime,FechaAlta Datetime,FechaNac Datetime,FechaImpor Datetime,
Hotel int ZEROFILL,CodReserva int ZEROFILL,Suplementos nvarchar(50),
Servicios nvarchar(50),MotivoEstancia int ZEROFILL,ComoContacto int ZEROFILL,
IdiomaWeb nvarchar(2),Informacion bit ZEROFILL,Confirmado bit ZEROFILL,
Observaciones TEXT NULL,NombrePais nvarchar(50));

CREATE INDEX FICHAS_CODRESERVA ON FICHAS (Id);

CREATE TABLE Ofertas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int ZEROFILL,IdHabitacion int ZEROFILL,AplicarEn int ZEROFILL,
CodigoSuple int ZEROFILL,PorPersona bit ZEROFILL,Colectivo int ZEROFILL,
Texto1_es TEXT NULL,Texto1_it TEXT NULL,Texto1_en TEXT NULL,Texto1_de TEXT NULL,
Texto1_fr TEXT NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int ZEROFILL,Dto real ZEROFILL,Precio real ZEROFILL,
Titulo_es nvarchar(100),Titulo_it nvarchar(100),Titulo_en nvarchar(100),
Titulo_de nvarchar(100),Titulo_fr nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada bit ZEROFILL,Activa bit DEFAULT(1),
Calcula bit DEFAULT(1),FechaReserva bit ZEROFILL,DiasSemana nvarchar(20),
NochesGratis int ZEROFILL);

CREATE INDEX OFERTAS_CodigoEsta ON Ofertas (CodigoEsta);
CREATE INDEX OFERTAS_Fechas ON Ofertas (FechaInicio,FechaFin);

CREATE TABLE PermisosPorEsta (IdUsuario int ZEROFILL,CodigoEsta int ZEROFILL);

CREATE INDEX PERMISOSPORESTA_CodigoEsta ON PERMISOSPORESTA (IdUsuario);

CREATE TABLE Regimen (Id int IDENTITY (1,1) NOT NULL PRIMARY KEY,
Nombre_es nvarchar(50),Nombre_it nvarchar(50),Nombre_en nvarchar(50),
Nombre_de nvarchar(50),Nombre_fr nvarchar(50));

CREATE TABLE RegimenHotel (Id int IDENTITY (1,1) NOT NULL PRIMARY KEY,
IdRegimen int ZEROFILL,CodigoEsta int ZEROFILL,CodigoHab int ZEROFILL,
CodigoTempo int ZEROFILL,Precio real ZEROFILL,Defecto bit ZEROFILL,
ANYO int ZEROFILL);

CREATE INDEX REGIMENHOTEL_IdRegimen ON REGIMENHOTEL (IdRegimen);
CREATE INDEX REGIMENHOTEL_CodigoEsta ON REGIMENHOTEL (CodigoEsta);
CREATE INDEX REGIMENHOTEL_CODIGOHAB ON REGIMENHOTEL (CODIGOHAB);
CREATE INDEX REGIMENHOTEL_CODIGOTEMPO ON REGIMENHOTEL (CODIGOTEMPO);


CREATE TABLE RegimenDtos (Id int IDENTITY (1,1) NOT NULL PRIMARY KEY,
IdRegimenHotel int ZEROFILL,CodigoColec int ZEROFILL,Descuento real ZEROFILL,
Precio real ZEROFILL);

CREATE INDEX REGIMENDTOS_RegiHotel ON REGIMENDTOS (IdRegimenHotel);



CREATE TABLE Registro (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdUsuario int ZEROFILL,Nombre nvarchar(50),Fecha Datetime,CodigoEsta int ZEROFILL,
Anyo int ZEROFILL,Proceso TEXT NULL,Modulo nvarchar(50));

CREATE INDEX REGISTRO_CodigoEsta ON REGISTRO (CodigoEsta);
CREATE INDEX REGISTRO_User ON REGISTRO (IdUsuario);
CREATE INDEX REGISTRO_Fecha ON REGISTRO (Fecha);

CREATE TABLE Reservas (Cod_Res int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int ZEROFILL,FechaIni Datetime,FechaFin Datetime,
FechaReserva Datetime,NumDias int ZEROFILL,Servicios nvarchar(50),
Importe real ZEROFILL,ImportePag real ZEROFILL,Activa bit ZEROFILL,
Comentarios TEXT NULL,Idi nvarchar(2),TPVFecha nvarchar(50),
TPVCodAprobacion nvarchar(50),TPVIdTrans nvarchar(50),TPVCodError nvarchar(50),
CodOferta nvarchar(50),PelasOferta nvarchar(50),IdCliente int ZEROFILL,
TipoVenta int ZEROFILL);

CREATE INDEX RESERVAS_CodigoEsta ON RESERVAS (CodigoEsta);
CREATE INDEX RESERVAS_FechaRes ON RESERVAS (FechaReserva);
CREATE INDEX RESERVAS_FechaIn ON RESERVAS (FechaIni,FechaFin);
CREATE INDEX RESERVAS_Cliente ON RESERVAS (IdCliente);

CREATE TABLE Temporadas (CodigoTemp int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int ZEROFILL,FInicio Datetime,FFinal Datetime,Release int DEFAULT(1),
Minimo int DEFAULT(1));

CREATE INDEX TEMPORADAS_CodigoEsta ON TEMPORADAS (CodigoEsta);
CREATE INDEX TEMPORADAS_Fechas ON TEMPORADAS (FInicio,FFinal);

CREATE TABLE TemporadasNomres (TempIdi int ZEROFILL,Idioma nvarchar(2),Nombre nvarchar(50));

CREATE INDEX TEMPORADASNomres_Id ON TemporadasNomres (TempIdi);

CREATE TABLE TipoAlojamiento (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre_es nvarchar(50),Nombre_it nvarchar(50),Nombre_en nvarchar(50),Nombre_de nvarchar(50),
Nombre_fr nvarchar(50),IdTipo int ZEROFILL);

CREATE TABLE TipoHabita (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Orden int ZEROFILL,ParaCapMax int ZEROFILL,ParaCapMin int ZEROFILL,
ParaAdultMax int ZEROFILL,ParaNiMax int ZEROFILL,ParaCapNormal int ZEROFILL,
ParaAdultMin int ZEROFILL,Nombre_es nvarchar(50),Nombre_it nvarchar(50),
Nombre_en nvarchar(50),Nombre_de nvarchar(50),Nombre_fr nvarchar(50));

CREATE TABLE TipoHabitaNombres (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
TipoHabitacion int ZEROFILL,CodigoEsta int ZEROFILL,Nombre_es nvarchar(50),
Nombre_it nvarchar(50),Nombre_en nvarchar(50),Nombre_de nvarchar(50),Nombre_fr nvarchar(50),
ParaCapMax int ZEROFILL,ParaCapMin int ZEROFILL,
ParaAdultMax int ZEROFILL,ParaNiMax int ZEROFILL,ParaCapNormal int ZEROFILL,
ParaAdultMin int ZEROFILL,Orden int ZEROFILL,
CunaOcupa bit ZEROFILL);

CREATE INDEX TIPOHABITANOMBRES_CodigoEsta ON TIPOHABITANOMBRES (CodigoEsta);
CREATE INDEX TIPOHABITANOMBRES_Habita ON TIPOHABITANOMBRES (TipoHabitacion);

CREATE TABLE TipoHabitaPrecios (IdHabita int ZEROFILL,Temporada int ZEROFILL,
PrePreBase real ZEROFILL,PrePerHab bit ZEROFILL);

CREATE INDEX TIPOHABITAPrecios_Habita ON TipoHabitaPrecios (IdHabita);
CREATE INDEX TIPOHABITAPrecios_Tempo ON TipoHabitaPrecios (Temporada);

CREATE TABLE TipoReserva (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdReserva int ZEROFILL,IdTipoHabitacion int ZEROFILL,
CodigoEsta int ZEROFILL,CuantasHabis int DEFAULT(1),
FechaInicio Datetime,FechaFinal Datetime,FechaReserva Datetime,
NumAdultos int ZEROFILL,NumBebes int ZEROFILL,NumNinos1 int ZEROFILL,
NumNinos2 int ZEROFILL,Suplementos nvarchar(50));

CREATE INDEX TIPORESERVA_Res ON TIPORESERVA (IdReserva);
CREATE INDEX TIPORESERVA_Fechas ON TIPORESERVA (FechaInicio,FechaFinal);

CREATE TABLE TiposServicio (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre_es nvarchar(50),Nombre_it nvarchar(50),Nombre_en nvarchar(50),
Nombre_de nvarchar(50),Nombre_fr nvarchar(50),Foto nvarchar(75));

CREATE TABLE Usuaris (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
UserName nvarchar(25),Pass nvarchar(25),Nom nvarchar(50));

CREATE TABLE Zonas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Zona_es nvarchar(50),Zona_it nvarchar(50),Zona_en nvarchar(50),Zona_de nvarchar(50),
Zona_fr nvarchar(50),PosTop int ZEROFILL,PosLeft int ZEROFILL,Foto nvarchar(50));

