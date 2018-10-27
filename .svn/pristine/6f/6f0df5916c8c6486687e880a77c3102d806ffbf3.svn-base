CREATE TABLE Categorias (Id int NOT NULL PRIMARY KEY,Nombre nvarchar(50),IdTipo int default(0));

CREATE TABLE Colectivos (CodigoColec int NOT NULL PRIMARY KEY, CodigoEsta int NOT NULL, 
Orde int DEFAULT(0) NULL,Nombre nvarchar(50) NULL);
CREATE INDEX IndiIDColec ON Colectivos (CodigoEsta);

CREATE TABLE CondicionesHotel (CodigoEsta INT DEFAULT(0),
Texto nvarchar(MAX) NULL);
CREATE INDEX CONDICIONESHOTEL_CodigoEsta ON CONDICIONESHOTEL (CodigoEsta);

CREATE TABLE Cupos(CodigoHab int DEFAULT(0) NOT NULL,
CodigoEsta int DEFAULT(0),Dia datetime,Cupo int DEFAULT(0),Precio real default(0),
DiasMinimos int default(1),Release int default(0),Estado int default(2),Tarifa int default(1),
LimiteCheckIn int default(-1));

CREATE INDEX CUPOS_CODIGOHAB ON CUPOS (CodigoHab);
CREATE INDEX CUPOS_Tarifa ON CUPOS (Tarifa);
CREATE INDEX CUPOS_Dia ON CUPOS (dia,CodigoHab);

CREATE TABLE DatosHotel(CodigoEsta int DEFAULT(0),EMail nvarchar(100),Direccion nvarchar(50),
CP nvarchar(15),Poblacion nvarchar(50),Telefono nvarchar(25),PID nvarchar(30),PID2 nvarchar(30),
FAX nvarchar(25),AVISO bit DEFAULT(0),URL nvarchar(100),Zona int DEFAULT(0),TipoAlojamiento int DEFAULT(0),
Categoria int DEFAULT(0),NombrePagina nvarchar(25),Foto nvarchar(100));

CREATE INDEX DATOSHOTEL_CodigoEsta ON DATOSHOTEL (CodigoEsta);

CREATE TABLE DescuentosColectivos (Id int NOT NULL PRIMARY KEY,CodigoColec int DEFAULT(0),Temporada int DEFAULT(0),TipoHab int DEFAULT(0),Prebase int DEFAULT(0),Precio real DEFAULT(0),Anyo int DEFAULT(0),Tarifa int default(1));

CREATE INDEX DESCUENTOSCOLECTIVOS_CODIGOCOLEC ON DescuentosColectivos (CodigoColec);
CREATE INDEX DESCUENTOSCOLECTIVOS_Hab ON DescuentosColectivos (TipoHab);
CREATE INDEX DESCUENTOSCOLECTIVOS_Tempo ON DescuentosColectivos (Temporada);

CREATE TABLE Establecimientos(CodigoEsta int NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Orde int DEFAULT(0),PorCiento real DEFAULT(0),
PrepagoMinimo int DEFAULT(0),MinDias int DEFAULT(0), DiasAnulacion int DEFAULT(0),
Estado int DEFAULT(0),OBS nvarchar(MAX) NULL,Moneda int DEFAULT(0));

CREATE TABLE Extras (ID int NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT(0),Extra nvarchar(100),
FInicio Datetime,FFinal Datetime,Importe real DEFAULT(0),PorPersona bit DEFAULT(0),
Colectivo int DEFAULT(0),Descuento real DEFAULT(0),ImporteDto real DEFAULT(0),
Colectivo2 int DEFAULT(0),Descuento2 real DEFAULT(0),ImporteDto2 real DEFAULT(0),
TipoSuple nvarchar(50),TipoHabi nvarchar(50),Tarifa int default(1));

CREATE INDEX EXTRAS_CodigoEsta ON EXTRAS (CodigoEsta);
CREATE INDEX EXTRAS_Fechas ON EXTRAS (FInicio,FFinal);

CREATE TABLE Fichas (Id int NOT NULL PRIMARY KEY,
Apellidos nvarchar(50),Nombre nvarchar(50),Telefono nvarchar(25),FAX nvarchar(25),
Direccion nvarchar(50),CP nvarchar(15),Poblacion nvarchar(50),Provincia nvarchar(50),
Pais nvarchar(2),EMail nvarchar(75),Sexo nvarchar(10),FechaLlegada Datetime,
FechaSalida Datetime,FechaAlta Datetime,FechaNac Datetime,FechaImpor Datetime,
Hotel int DEFAULT(0),CodReserva int DEFAULT(0),Suplementos nvarchar(50),
Servicios nvarchar(50),MotivoEstancia int DEFAULT(0),ComoContacto int DEFAULT(0),
IdiomaWeb nvarchar(2),Informacion bit DEFAULT(0),Confirmado bit DEFAULT(0),
Observaciones nvarchar(MAX) NULL,NombrePais nvarchar(50),CodigoVIP nvarchar(25),Activo bit DEFAULT(0));

CREATE INDEX FICHAS_CODRESERVA ON FICHAS (Id);
CREATE INDEX FICHAS_VIP ON FICHAS (CodigoVIP);

CREATE TABLE Ofertas (Id int NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT(0),IdHabitacion int DEFAULT(0),AplicarEn int DEFAULT(0),
CodigoSuple int DEFAULT(0),PorPersona bit DEFAULT(0),Colectivo int DEFAULT(0),
Texto nvarchar(MAX) NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int DEFAULT(0),Dto real DEFAULT(0),Precio real DEFAULT(0),
Titulo nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada bit DEFAULT(0),Activa bit DEFAULT(1),
Calcula bit DEFAULT(1),FechaReserva bit DEFAULT(0),DiasSemana nvarchar(20),
NochesGratis int DEFAULT(0),CodigoPromocion nvarchar(25),Tarifa int default(1));

CREATE INDEX OFERTAS_CodigoEsta ON Ofertas (CodigoEsta);
CREATE INDEX OFERTAS_Fechas ON Ofertas (FechaInicio,FechaFin);
CREATE INDEX OFERTAS_Promo ON Ofertas (CodigoPromocion);


CREATE TABLE OfertasVIP (Id int NOT NULL PRIMARY KEY,
IdHabitacion int DEFAULT(0),AplicarEn int DEFAULT(0),
CodigoSuple int DEFAULT(0),PorPersona bit DEFAULT(0),Colectivo int DEFAULT(0),
Texto nvarchar(MAX) NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int DEFAULT(0),Dto real DEFAULT(0),Precio real DEFAULT(0),
Titulo nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada bit DEFAULT(0),Activa bit DEFAULT(1),
Calcula bit DEFAULT(1),FechaReserva bit DEFAULT(0),DiasSemana nvarchar(20),
NochesGratis int DEFAULT(0),CodigoPromocion nvarchar(25),Tarifa int default(1));

CREATE INDEX OFERVIP_Fechas ON OfertasVIP (FechaInicio,FechaFin);
CREATE INDEX OFERVIP_Promo ON OfertasVIP (CodigoPromocion);

CREATE TABLE VisitasVIP (Id int NOT NULL PRIMARY KEY,
IdFicha int DEFAULT(0),CodigoEsta int DEFAULT(0),
CodReserva int DEFAULT(0),Habitacion nvarchar(25) NULL,
Comentario nvarchar(MAX) NULL);

CREATE INDEX Visitas_reserva ON VisitasVIP (CodReserva);
CREATE INDEX Visitas_ficha ON VisitasVIP (IdFicha);
CREATE INDEX Visitas_hotel ON VisitasVIP (CodigoEsta);

CREATE TABLE PermisosPorEsta (IdUsuario int DEFAULT(0),CodigoEsta int DEFAULT(0));
CREATE INDEX PermisosPorEsta_CodigoEsta ON PERMISOSPORESTA (IdUsuario);

CREATE TABLE Regimen (Id int NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Breve nvarchar(15));

CREATE TABLE RegimenHotel (Id int NOT NULL PRIMARY KEY,
IdRegimen int DEFAULT(0),CodigoEsta int DEFAULT(0),CodigoHab int DEFAULT(0),
CodigoTempo int DEFAULT(0),Precio real DEFAULT(0),Defecto bit DEFAULT(0),
ANYO int DEFAULT(0),Tarifa int default(1));

CREATE INDEX RegimenHotel_IdRegimen ON REGIMENHOTEL (IdRegimen);
CREATE INDEX RegimenHotel_CodigoEsta ON REGIMENHOTEL (CodigoEsta);
CREATE INDEX RegimenHotel_CodigoHab ON REGIMENHOTEL (CODIGOHAB);
CREATE INDEX RegimenHotel_CodigoTempo ON REGIMENHOTEL (CODIGOTEMPO);


CREATE TABLE RegimenDtos (Id int NOT NULL PRIMARY KEY,
IdRegimenHotel int DEFAULT(0),CodigoColec int DEFAULT(0),Descuento real DEFAULT(0),
Precio real DEFAULT(0),Tarifa int default(1));

CREATE INDEX RegimenDtos_RegiHotel ON RegimenDtos (IdRegimenHotel);


CREATE TABLE Registro (Id int IDENTITY (1,1) NOT NULL PRIMARY KEY,
IdUsuario int DEFAULT(0),Nombre nvarchar(50),Fecha Datetime,CodigoEsta int DEFAULT(0),
Anyo int DEFAULT(0),Proceso nvarchar(MAX) NULL,Modulo nvarchar(50));

CREATE INDEX Registro_CodigoEsta ON REGISTRO (CodigoEsta);
CREATE INDEX Registro_User ON REGISTRO (IdUsuario);
CREATE INDEX Registro_Fecha ON REGISTRO (Fecha);

CREATE TABLE Reservas (Cod_Res int NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT(0),FechaIni Datetime,FechaFin Datetime,
FechaReserva Datetime,NumDias int DEFAULT(0),Servicios nvarchar(50),
Importe real DEFAULT(0),ImportePag real DEFAULT(0),Activa bit DEFAULT(0),
Comentarios nvarchar(MAX) NULL,Idi nvarchar(2),TPVFecha nvarchar(50),
TPVCodAprobacion nvarchar(50),TPVIdTrans nvarchar(50),TPVCodError nvarchar(50),
CodOferta nvarchar(50),PelasOferta nvarchar(50),IdCliente int DEFAULT(0),
TipoVenta int DEFAULT(0),CodAgencia int DEFAULT(0) NOT NULL,CodigoVIP nvarchar(25),
TipoVentaAgencia int DEFAULT(0) NOT NULL,Tarifa int default(1), Anulada bit default(0),
FechaModificacion Datetime, ImporteModificado real default(0));

CREATE INDEX RESERVAS_CodigoEsta ON RESERVAS (CodigoEsta);
CREATE INDEX RESERVAS_FechaRes ON RESERVAS (FechaReserva);
CREATE INDEX RESERVAS_FechaIn ON RESERVAS (FechaIni,FechaFin);
CREATE INDEX RESERVAS_Cliente ON RESERVAS (IdCliente);
CREATE INDEX RESERVAS_Tarifa ON RESERVAS (Tarifa);

CREATE TABLE Temporadas (CodigoTemp int NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT(0),FInicio Datetime,FFinal Datetime,Release int DEFAULT(1),
Minimo int DEFAULT(1));

CREATE INDEX TEMPORADAS_CodigoEsta ON TEMPORADAS (CodigoEsta);
CREATE INDEX TEMPORADAS_Fechas ON TEMPORADAS (FInicio,FFinal);

CREATE TABLE TemporadasNomres (TempIdi int DEFAULT(0),Idioma nvarchar(2),Nombre nvarchar(50));

CREATE INDEX TEMPORADASNomres_Id ON TemporadasNomres (TempIdi);

CREATE TABLE TipoAlojamiento (Id int NOT NULL PRIMARY KEY,
Nombre nvarchar(50),IdTipo int DEFAULT(0));

CREATE TABLE TipoHabita (Id int NOT NULL PRIMARY KEY,
Orden int DEFAULT(0),ParaCapMax int DEFAULT(0),ParaCapMin int DEFAULT(0),
ParaAdultMax int DEFAULT(0),ParaNiMax int DEFAULT(0),ParaCapNormal int DEFAULT(0),
ParaAdultMin int DEFAULT(0),Nombre nvarchar(50));

CREATE TABLE TipoHabitaNombres (Id int NOT NULL PRIMARY KEY,
TipoHabitacion int DEFAULT(0),CodigoEsta int DEFAULT(0),Nombre nvarchar(50),
ParaCapMax int DEFAULT(0),ParaCapMin int DEFAULT(0),
ParaAdultMax int DEFAULT(0),ParaNiMax int DEFAULT(0),ParaCapNormal int DEFAULT(0),
ParaAdultMin int DEFAULT(0),Orden int DEFAULT(0),
CunaOcupa bit DEFAULT(0));

CREATE INDEX TIPOHABITANOMBRES_CodigoEsta ON TIPOHABITANOMBRES (CodigoEsta);
CREATE INDEX TIPOHABITANOMBRES_Habita ON TIPOHABITANOMBRES (TipoHabitacion);

CREATE TABLE TipoHabitaPrecios (IdHabita int DEFAULT(0),Temporada int DEFAULT(0),
PrePreBase real DEFAULT(0),PrePerHab bit DEFAULT(0),Tarifa int default(1));

CREATE INDEX TIPOHABITAPrecios_Habita ON TipoHabitaPrecios (IdHabita);
CREATE INDEX TIPOHABITAPrecios_Tempo ON TipoHabitaPrecios (Temporada);

CREATE TABLE TipoReserva (Id int NOT NULL PRIMARY KEY,
IdReserva int DEFAULT(0),IdTipoHabitacion int DEFAULT(0),
CodigoEsta int DEFAULT(0),CuantasHabis int DEFAULT(1),
FechaInicio Datetime,FechaFinal Datetime,FechaReserva Datetime,
NumAdultos int DEFAULT(0),NumBebes int DEFAULT(0),NumNinos1 int DEFAULT(0),
NumNinos2 int DEFAULT(0),Suplementos nvarchar(50),Importe real default(0));

CREATE INDEX TIPORESERVA_Res ON TIPORESERVA (IdReserva);
CREATE INDEX TIPORESERVA_Fechas ON TIPORESERVA (FechaInicio,FechaFinal);

CREATE TABLE TiposServicio (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Foto nvarchar(75));

CREATE TABLE Zonas (Id int NOT NULL PRIMARY KEY,
Zona nvarchar(50),PosTop float DEFAULT(0),PosLeft float DEFAULT(0),Zoom int DEFAULT(0),Foto nvarchar(50));

CREATE TABLE FotosHabitacion (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
IdHabitacion int DEFAULT(0),Orden int DEFAULT(0),Foto nvarchar(100) NULL);
CREATE INDEX FHabi ON FotosHabitacion (IdHabitacion);

CREATE TABLE HabitacionesHotel (CodigoEsta int DEFAULT(0),
IdHabitacion int DEFAULT(0),Texto nvarchar(MAX) NULL);
CREATE INDEX IdHabiHotel ON HabitacionesHotel (IdHabitacion);

create table Agencias (id int NOT NULL PRIMARY KEY,
Nombre nvarchar(75) NULL,
Email nvarchar(75) NULL,
Direccion nvarchar(75) NULL,
CP nvarchar(15) NULL,
Poblacion nvarchar(50) NULL,
Pais nvarchar(50) NULL,
Observaciones nvarchar(MAX) NULL,
Activa bit NOT NULL DEFAULT(0),
Usuario nvarchar(25) NULL,
Clave nvarchar(25) NULL,
Comision real NOT NULL,
BAL nvarchar(25) NULL,
Contacto nvarchar(75) NULL,
Telefono nvarchar(50) NULL,
Fax nvarchar(25) NULL,
Sistema int NULL,Tarifa int default(1));

CREATE TABLE PlantillasNews (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Nombre nvarchar(75) NOT NULL,Plantilla nvarchar(MAX));

CREATE TABLE ErrorEmails (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
IdMensaje int DEFAULT(0),IdCliente Int DEFAULT(0),EMail nvarchar(75),Descripcion nvarchar(150),Tabla nvarchar(50));
CREATE INDEX PolMensaje ON ErrorEMails (IdMensaje);
CREATE INDEX PolCliente ON ErrorEMails (IdCliente);

CREATE TABLE ResumenEmails (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Asunto nvarchar(75),Mensaje nvarchar(MAX),Filtro nvarchar(MAX),Tabla nvarchar(50),Errores int DEFAULT(0),
Correctos int DEFAULT(0),FechaEnvio DateTime);

CREATE TABLE ReservaServicio (CodReserva int NOT NULL,IdServicio int DEFAULT(0) NOT NULL, Cuantas int DEFAULT(0),
Pelas real DEFAULT(0),Tarifa int default(1),IdColectivo int DEFAULT(0),Tipo int DEFAULT(0));
CREATE INDEX laRes ON ReservaServicio (CodReserva);
CREATE INDEX elServi ON ReservaServicio (IdServicio);

CREATE TABLE ServiciosExtras (Id int NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT(0),
URL nvarchar(100), Ancho int DEFAULT(0), Alto int DEFAULT(0), Nombre nvarchar(100),
Texto nvarchar(MAX), Activo bit DEFAULT(0), Orden int default(0));
CREATE INDEX elho ON ServiciosExtras (CodigoEsta);

CREATE TABLE ServiciosPrecios (Id int NOT NULL PRIMARY KEY, IdServicio int DEFAULT(0),
FechaInicio datetime, FechaFinal datetime, IdColectivo int DEFAULT(0), Tipo int DEFAULT(0),
Importe real DEFAULT(0),Tarifa int default(1), Obligatorio bit DEFAULT(0), 
Regimen nvarchar(75), Habitaciones nvarchar(75));
CREATE INDEX laPela ON ServiciosPrecios (IdServicio);

CREATE TABLE ServiciosFotos (Id int NOT NULL PRIMARY KEY,
IdServicio int DEFAULT(0),Orden int DEFAULT(0),Foto nvarchar(100) NULL);
CREATE INDEX FServi ON ServiciosFotos (IdServicio);

CREATE TABLE TiposMoneda (Id int NOT NULL DEFAULT(0), Nombre nvarchar(100), CodigoISO nvarchar(3),Orden int DEFAULT(0),PorDefecto bit DEFAULT(0), Abreviado nvarchar(5));
CREATE INDEX lmoneda ON TiposMoneda (Id);

CREATE TABLE Tarifas (Id int NOT NULL DEFAULT(0), Nombre nvarchar(50));
CREATE INDEX LTari ON Tarifas (Id);

CREATE TABLE OfertasReserva (Id int NOT NULL PRIMARY KEY, IdOferta int DEFAULT(0), 
IdReserva int DEFAULT(0),Importe real DEFAULT(0));

CREATE INDEX IndiOReserva ON OfertasReserva (IdOferta,IdReserva);

CREATE TABLE Caracteristicas (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, Caracteristica nvarchar(100), Icono nvarchar(75), Orden int default(0), Destacada bit default(0));

CREATE TABLE CaracteristicasHotel (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, IdCaracter int default(0),
CodigoEsta int default(0));
CREATE INDEX IndiCaracterH ON CaracteristicasHotel (IdCaracter,CodigoEsta);

CREATE TABLE SeccionesHotel (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT(0), 
Seccion nvarchar(75), Orden int default(0));
CREATE INDEX IndiSecci ON SeccionesHotel (CodigoEsta);

CREATE TABLE TextosHotel (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT(0), 
IdSeccion int default(0), Texto nvarchar(MAX));
CREATE INDEX IndiTHotel ON TextosHotel (CodigoEsta);
CREATE INDEX SecciTHotel ON TextosHotel (IdSeccion);

CREATE TABLE FotosHotel (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT(0), 
IdSeccion int default(0), Foto nvarchar(75), Orden int default(0));
CREATE INDEX IndiFHotel ON FotosHotel (CodigoEsta);
CREATE INDEX SecciFHotel ON FotosHotel (IdSeccion);

CREATE TABLE GmapsHotel (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT(0), 
laX real default(0), laY real default(0), Zoom int default(0), Texto nvarchar(MAX), Icono nvarchar(75));
CREATE INDEX IndiGHotel ON GmapsHotel (CodigoEsta);


CREATE TABLE Traducciones (Id int IDENTITY(1,1) NOT NULL PRIMARY KEY, IdReferencia int default(0),
Idioma char(2), Tabla nvarchar(75), Campo nvarchar(75), Traduccion nvarchar(MAX),CodigoEsta int DEFAULT(0));
CREATE INDEX IndiTradu ON Traducciones (Tabla,Campo,Idioma);
CREATE INDEX IndiTraduId ON Traducciones (IdReferencia);

