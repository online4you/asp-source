CREATE TABLE Categorias (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,Nombre nvarchar(50),IdTipo int default '0');

CREATE TABLE Colectivos (CodigoColec int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int NOT NULL, 
Orde int default '0' NULL,Nombre nvarchar(50) NULL,DesdeEdad int default '0' NOT NULL,HastaEdad int default '0' NOT NULL);
CREATE INDEX IndiIDColec ON Colectivos (CodigoEsta);

CREATE TABLE CondicionesHotel (CodigoEsta INT default '0',
Texto nvarchar(10000) NULL);
CREATE INDEX CONDICIONESHOTEL_CodigoEsta ON CondicionesHotel (CodigoEsta);

CREATE TABLE Cupos(CodigoHab int default '0' NOT NULL,
CodigoEsta int default '0',Dia datetime,Cupo int default '0',Precio real default '0',
DiasMinimos int default '1',ReleaseHab int default '0',Estado int default '2' ,Tarifa int default '1',
LimiteCheckIn int default '-1');

CREATE INDEX CUPOS_CODIGOHAB ON Cupos (CodigoHab);
CREATE INDEX CUPOS_Tarifa ON Cupos (Tarifa);
CREATE INDEX CUPOS_Dia ON Cupos (dia,CodigoHab);

CREATE TABLE DatosHotel(CodigoEsta int default '0',EMail nvarchar(100),Direccion nvarchar(50),
CP nvarchar(15),Poblacion nvarchar(50),Telefono nvarchar(25),PID nvarchar(30),PID2 nvarchar(30),
FAX nvarchar(25),AVISO nvarchar(1) default '0',URL nvarchar(100),Zona int default '0',TipoAlojamiento int default '0',
Categoria int default '0',NombrePagina nvarchar(25),Foto nvarchar(100));

CREATE INDEX DATOSHOTEL_CodigoEsta ON DatosHotel (CodigoEsta);

CREATE TABLE DescuentosColectivos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,CodigoColec int default '0',Temporada int default '0',TipoHab int default '0',Prebase int default '0',Precio real default '0',Anyo int default '0',
Tarifa int default '1',DesdePlazas int default '0',HastaPlazas int default '0');

CREATE INDEX DESCUENTOSCOLECTIVOS_CODIGOCOLEC ON DescuentosColectivos (CodigoColec);
CREATE INDEX DESCUENTOSCOLECTIVOS_Hab ON DescuentosColectivos (TipoHab);
CREATE INDEX DESCUENTOSCOLECTIVOS_Tempo ON DescuentosColectivos (Temporada);

CREATE TABLE Establecimientos(CodigoEsta int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Orde int default '0',PorCiento real default '0',
PrepagoMinimo int default '0',MinDias int default '0', DiasAnulacion int default '0',
Estado int default '0',OBS nvarchar(10000) NULL,Moneda int default '0');

CREATE TABLE Extras (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int default '0',Extra nvarchar(100),
FInicio Datetime,FFinal Datetime,Importe real default '0',PorPersona nvarchar(1) default '0',
Colectivo int default '0',Descuento real default '0',ImporteDto real default '0',
Colectivo2 int default '0',Descuento2 real default '0',ImporteDto2 real default '0',
TipoSuple nvarchar(50),TipoHabi nvarchar(50),Tarifa int default '1');

CREATE INDEX EXTRAS_CodigoEsta ON Extras (CodigoEsta);
CREATE INDEX EXTRAS_Fechas ON Extras (FInicio,FFinal);

CREATE TABLE Fichas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Apellidos nvarchar(50),Nombre nvarchar(50),Telefono nvarchar(25),FAX nvarchar(25),
Direccion nvarchar(50),CP nvarchar(15),Poblacion nvarchar(50),Provincia nvarchar(50),
Pais nvarchar(2),EMail nvarchar(75),Sexo nvarchar(10),FechaLlegada Datetime,
FechaSalida Datetime,FechaAlta Datetime,FechaNac Datetime,FechaImpor Datetime,
Hotel int default '0',CodReserva int default '0',Suplementos nvarchar(50),
Servicios nvarchar(50),MotivoEstancia int default '0',ComoContacto int default '0',
IdiomaWeb nvarchar(2),Informacion nvarchar(1) default '0',Confirmado nvarchar(1) default '0',
Observaciones nvarchar(10000) NULL,NombrePais nvarchar(50),CodigoVIP nvarchar(25),
Tratamiento int default '0',Activo nvarchar(1) default '0');

CREATE INDEX FICHAS_CODRESERVA ON Fichas (Id);
CREATE INDEX FICHAS_VIP ON Fichas (CodigoVIP);

CREATE TABLE Tratamientos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Breve nvarchar(15));
CREATE INDEX IdTrata ON Tratamientos (Id);

CREATE TABLE Ofertas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int default '0',IdHabitacion int default '0',AplicarEn int default '0',
CodigoSuple int default '0',PorPersona nvarchar(1) default '0',Colectivo int default '0',
Texto nvarchar(10000) NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int default '0',Dto real default '0',Precio real default '0',
Titulo nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada nvarchar(1) default '0',Activa nvarchar(1) default '1',
Calcula nvarchar(1) default '1',FechaReserva nvarchar(1) default '0',DiasSemana nvarchar(20),
NochesGratis int default '0',CodigoPromocion nvarchar(25),Tarifa int default '1');

CREATE INDEX OFERTAS_CodigoEsta ON Ofertas (CodigoEsta);
CREATE INDEX OFERTAS_Fechas ON Ofertas (FechaInicio,FechaFin);
CREATE INDEX OFERTAS_Promo ON Ofertas (CodigoPromocion);


CREATE TABLE OfertasVIP (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdHabitacion int default '0',AplicarEn int default '0',
CodigoSuple int default '0',PorPersona nvarchar(1) default '0',Colectivo int default '0',
Texto nvarchar(10000) NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int default '0',Dto real default '0',Precio real default '0',
Titulo nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada nvarchar(1) default '0',Activa nvarchar(1) default '1',
Calcula nvarchar(1) default '1',FechaReserva nvarchar(1) default '0',DiasSemana nvarchar(20),
NochesGratis int default '0',CodigoPromocion nvarchar(25),Tarifa int default '1');

CREATE INDEX OFERVIP_Fechas ON OfertasVIP (FechaInicio,FechaFin);
CREATE INDEX OFERVIP_Promo ON OfertasVIP (CodigoPromocion);

CREATE TABLE VisitasVIP (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdFicha int default '0',CodigoEsta int default '0',
CodReserva int default '0',Habitacion nvarchar(25) NULL,
Comentario nvarchar(10000) NULL);

CREATE INDEX Visitas_reserva ON VisitasVIP (CodReserva);
CREATE INDEX Visitas_ficha ON VisitasVIP (IdFicha);
CREATE INDEX Visitas_hotel ON VisitasVIP (CodigoEsta);

CREATE TABLE PermisosPorEsta (IdUsuario int default '0',CodigoEsta int default '0');
CREATE INDEX PermisosPorEsta_CodigoEsta ON PermisosPorEsta (IdUsuario);

CREATE TABLE Regimen (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Breve nvarchar(15));

CREATE TABLE RegimenHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdRegimen int default '0',CodigoEsta int default '0',CodigoHab int default '0',
CodigoTempo int default '0',Precio real default '0',Defecto nvarchar(1) default '0',
ANYO int default '0',Tarifa int default '1');

CREATE INDEX RegimenHotel_IdRegimen ON RegimenHotel (IdRegimen);
CREATE INDEX RegimenHotel_CodigoEsta ON RegimenHotel (CodigoEsta);
CREATE INDEX RegimenHotel_CodigoHab ON RegimenHotel (CODIGOHAB);
CREATE INDEX RegimenHotel_CodigoTempo ON RegimenHotel (CODIGOTEMPO);


CREATE TABLE RegimenDtos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdRegimenHotel int default '0',CodigoColec int default '0',Descuento real default '0',
Precio real default '0',Tarifa int default '1',DesdePlazas int default '0',HastaPlazas int default '0');

CREATE INDEX RegimenDtos_RegiHotel ON RegimenDtos (IdRegimenHotel);


CREATE TABLE Registro (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdUsuario int default '0',Nombre nvarchar(50),Fecha Datetime,CodigoEsta int default '0',
Anyo int default '0',Proceso nvarchar(10000) NULL,Modulo nvarchar(50));

CREATE INDEX Registro_CodigoEsta ON Registro (CodigoEsta);
CREATE INDEX Registro_User ON Registro (IdUsuario);
CREATE INDEX Registro_Fecha ON Registro (Fecha);

CREATE TABLE Reservas (Cod_Res int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int default '0',FechaIni Datetime,FechaFin Datetime,
FechaReserva Datetime,NumDias int default '0',Servicios nvarchar(50),
Importe real default '0',ImportePag real default '0',Activa nvarchar(1) default '0',
Comentarios nvarchar(10000) NULL,Idi nvarchar(2),TPVFecha nvarchar(50),
TPVCodAprobacion nvarchar(50),TPVIdTrans nvarchar(50),TPVCodError nvarchar(50),
CodOferta nvarchar(50),PelasOferta nvarchar(50),IdCliente int default '0',
TipoVenta int default '0',CodAgencia int default '0' NOT NULL,CodigoVIP nvarchar(25),
TipoVentaAgencia int default '0' NOT NULL,Tarifa int default '1', Anulada nvarchar(1) default '0',
FechaModificacion Datetime, ImporteModificado real default '0');

CREATE INDEX RESERVAS_CodigoEsta ON Reservas (CodigoEsta);
CREATE INDEX RESERVAS_FechaRes ON Reservas (FechaReserva);
CREATE INDEX RESERVAS_FechaIn ON Reservas (FechaIni,FechaFin);
CREATE INDEX RESERVAS_Cliente ON Reservas (IdCliente);
CREATE INDEX RESERVAS_Tarifa ON Reservas (Tarifa);

CREATE TABLE Temporadas (CodigoTemp int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int default '0',FInicio Datetime,FFinal Datetime,ReleaseHab int default '1',
Minimo int default '1');

CREATE INDEX TEMPORADAS_CodigoEsta ON Temporadas (CodigoEsta);
CREATE INDEX TEMPORADAS_Fechas ON Temporadas (FInicio,FFinal);

CREATE TABLE TemporadasNomres (TempIdi int default '0',Idioma nvarchar(2),Nombre nvarchar(50));

CREATE INDEX TEMPORADASNomres_Id ON TemporadasNomres (TempIdi);

CREATE TABLE TipoAlojamiento (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),IdTipo int default '0');

CREATE TABLE TipoHabita (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Orden int default '0',ParaCapMax int default '0',ParaCapMin int default '0',
ParaAdultMax int default '0',ParaNiMax int default '0',ParaCapNormal int default '0',
ParaAdultMin int default '0',Nombre nvarchar(50));

CREATE TABLE TipoHabitaNombres (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
TipoHabitacion int default '0',CodigoEsta int default '0',Nombre nvarchar(50),
ParaCapMax int default '0',ParaCapMin int default '0',
ParaAdultMax int default '0',ParaNiMax int default '0',ParaCapNormal int default '0',
ParaAdultMin int default '0',Orden int default '0',
CunaOcupa nvarchar(1) default '0');

CREATE INDEX TIPOHabitaNOMBRES_CodigoEsta ON TipoHabitaNombres (CodigoEsta);
CREATE INDEX TIPOHabitaNOMBRES_Habita ON TipoHabitaNombres (TipoHabitacion);

CREATE TABLE TipoHabitaPrecios (IdHabita int default '0',Temporada int default '0',
PrePreBase real default '0',PrePerHab nvarchar(1) default '0',Anyo int default '0',Tarifa int default '1');

CREATE INDEX TIPOHabitaPrecios_Habita ON TipoHabitaPrecios (IdHabita);
CREATE INDEX TIPOHabitaPrecios_Tempo ON TipoHabitaPrecios (Temporada);

CREATE TABLE TipoReserva (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdReserva int default '0',IdTipoHabitacion int default '0',
CodigoEsta int default '0',CuantasHabis int default '1',
FechaInicio Datetime,FechaFinal Datetime,FechaReserva Datetime,
NumAdultos int default '0',NumBebes int default '0',NumNinos1 int default '0',
NumNinos2 int default '0',Suplementos nvarchar(50),Importe real default '0');

CREATE INDEX TIPORESERVA_Res ON TipoReserva (IdReserva);
CREATE INDEX TIPORESERVA_Fechas ON TipoReserva (FechaInicio,FechaFinal);

CREATE TABLE TiposServicio (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Foto nvarchar(75));

CREATE TABLE Zonas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Zona nvarchar(50),PosTop float default '0',PosLeft float default '0',Zoom int default '0',Foto nvarchar(50));

CREATE TABLE FotosHabitacion (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdHabitacion int default '0',Orden int default '0',Foto nvarchar(100) NULL);
CREATE INDEX FHabi ON FotosHabitacion (IdHabitacion);

CREATE TABLE HabitacionesHotel (CodigoEsta int default '0',
IdHabitacion int default '0',Texto nvarchar(10000) NULL);
CREATE INDEX IdHabiHotel ON HabitacionesHotel (IdHabitacion);

create table Agencias (id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(75) NULL,
Email nvarchar(75) NULL,
Direccion nvarchar(75) NULL,
CP nvarchar(15) NULL,
Poblacion nvarchar(50) NULL,
Pais nvarchar(50) NULL,
Observaciones nvarchar(10000) NULL,
Activa nvarchar(1) NOT NULL default '0',
Usuario nvarchar(25) NULL,
Clave nvarchar(25) NULL,
Comision real NOT NULL,
BAL nvarchar(25) NULL,
IATA nvarchar(25) NULL,
Contacto nvarchar(75) NULL,
Telefono nvarchar(50) NULL,
Fax nvarchar(25) NULL,
Sistema int NULL,Tarifa int default '1');

CREATE TABLE PlantillasNews (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(75) NOT NULL,Plantilla nvarchar(10000));

CREATE TABLE ErrorEmails (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdMensaje int default '0',IdCliente Int default '0',EMail nvarchar(75),Descripcion nvarchar(150),Tabla nvarchar(50));
CREATE INDEX PolMensaje ON ErrorEmails (IdMensaje);
CREATE INDEX PolCliente ON ErrorEmails (IdCliente);

CREATE TABLE ResumenEmails (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Asunto nvarchar(75),Mensaje nvarchar(10000),Filtro nvarchar(10000),Tabla nvarchar(50),Errores int default '0',
Correctos int default '0',FechaEnvio DateTime);

CREATE TABLE ReservaServicio (CodReserva int NOT NULL,IdServicio int default '0' NOT NULL, Cuantas int default '0',
Pelas real default '0',Tarifa int default '1',IdColectivo int default '0', Tipo int default '0');
CREATE INDEX laRes ON ReservaServicio (CodReserva);
CREATE INDEX elServi ON ReservaServicio (IdServicio);

CREATE TABLE ServiciosExtras (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int default '0',
URL nvarchar(100), Ancho int default '0', Alto int default '0', Nombre nvarchar(100),
Texto nvarchar(10000), Activo nvarchar(1) default '0', Orden int default '0');
CREATE INDEX elho ON ServiciosExtras (CodigoEsta);

CREATE TABLE ServiciosPrecios (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdServicio int default '0',
FechaInicio datetime, FechaFinal datetime, IdColectivo int default '0', Tipo int default '0',
Importe real default '0',Tarifa int default '1', Obligatorio nvarchar(1) default '0', 
Regimen nvarchar(75), Habitaciones nvarchar(75));
CREATE INDEX laPela ON ServiciosPrecios (IdServicio);

CREATE TABLE ServiciosFotos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdServicio int default '0',Orden int default '0',Foto nvarchar(100) NULL);
CREATE INDEX FServi ON ServiciosFotos (IdServicio);

CREATE TABLE TiposMoneda (Id int NOT NULL default '0', Nombre nvarchar(100), CodigoISO nvarchar(3),Orden int default '0',PorDefecto nvarchar(1) default '0', Abreviado nvarchar(5));
CREATE INDEX lmoneda ON TiposMoneda (Id);

CREATE TABLE Tarifas (Id int NOT NULL default '0', Nombre nvarchar(50));
CREATE INDEX LTari ON Tarifas (Id);

CREATE TABLE OfertasReserva (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdOferta int default '0', 
IdReserva int default '0',Importe real default '0');

CREATE INDEX IndiOReserva ON OfertasReserva (IdOferta,IdReserva);

CREATE TABLE Caracteristicas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, Caracteristica nvarchar(100), Icono nvarchar(75), Orden int default '0', Destacada nvarchar(1) default '0');

CREATE TABLE CaracteristicasHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdCaracter int default '0',
CodigoEsta int default '0');
CREATE INDEX IndiCaracterH ON CaracteristicasHotel (IdCaracter,CodigoEsta);

CREATE TABLE SeccionesHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int default '0', 
Seccion nvarchar(75), Orden int default '0');
CREATE INDEX IndiSecci ON SeccionesHotel (CodigoEsta);

CREATE TABLE TextosHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int default '0', 
IdSeccion int default '0', Texto nvarchar(10000));
CREATE INDEX IndiTHotel ON TextosHotel (CodigoEsta);
CREATE INDEX SecciTHotel ON TextosHotel (IdSeccion);

CREATE TABLE FotosHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int default '0', 
IdSeccion int default '0', Foto nvarchar(75), Orden int default '0');
CREATE INDEX IndiFHotel ON FotosHotel (CodigoEsta);
CREATE INDEX SecciFHotel ON FotosHotel (IdSeccion);

CREATE TABLE GmapsHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int default '0', 
laX real default '0', laY real default '0', Zoom int default '0', Texto nvarchar(10000), Icono nvarchar(75));
CREATE INDEX IndiGHotel ON GmapsHotel (CodigoEsta);


CREATE TABLE Traducciones (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdReferencia int default '0',
Idioma char(2), Tabla nvarchar(75), Campo nvarchar(75), Traduccion nvarchar(10000),CodigoEsta int default '0');
CREATE INDEX IndiTradu ON Traducciones (Tabla,Campo,Idioma);
CREATE INDEX IndiTraduId ON Traducciones (IdReferencia);

CREATE TABLE FPagoHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int default '0', 
tipoFPago int default '0', CodComercio nvarchar(50), Terminal nvarchar(50), Clave nvarchar(100),
claveXor nvarchar(100),Produccion nvarchar(1) default '0');
CREATE INDEX IndiFPHotel ON FPagoHotel (CodigoEsta);





