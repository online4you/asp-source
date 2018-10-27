CREATE TABLE Categorias (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,Nombre_es nvarchar(50) NULL,Nombre_it nvarchar(50) NULL,
Nombre_en nvarchar(50) NULL,Nombre_de nvarchar(50) NULL,Nombre_fr nvarchar(50) NULL,IdTipo int default '0');

CREATE TABLE Colectivos (CodigoColec int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int NOT NULL, 
Orde int DEFAULT '0' NULL,Nombre_es nvarchar(50) NULL,
Nombre_it nvarchar(50) NULL,Nombre_en nvarchar(50) NULL,
Nombre_de nvarchar(50) NULL,Nombre_fr nvarchar(50) NULL);

CREATE INDEX IndiIDColec ON Colectivos (CodigoEsta);

CREATE TABLE CondicionesHotel (CodigoEsta INT DEFAULT '0',
Texto1_es nvarchar(1000) NULL,Texto1_it nvarchar(1000) NULL,Texto1_en nvarchar(1000) NULL,Texto1_de nvarchar(1000) NULL,Texto1_fr nvarchar(1000) NULL);

CREATE INDEX CONDICIONESHOTEL_CodigoEsta ON CondicionesHotel (CodigoEsta);

CREATE TABLE Cupos(CodigoHab int DEFAULT '0' NOT NULL,
CodigoEsta int DEFAULT '0',Dia datetime,Cupo int DEFAULT '0',Precio real DEFAULT '0',
DiasMinimos int DEFAULT '1',ReleaseHab int DEFAULT '0',Estado int default '2',Tarifa int DEFAULT '1',
LimiteCheckIn int default '-1');

CREATE INDEX CUPOS_CODIGOHAB ON Cupos (CodigoHab);
CREATE INDEX CUPOS_Tarifa ON Cupos (Tarifa);
CREATE INDEX CUPOS_Dia ON Cupos (dia);

CREATE TABLE DatosHotel(CodigoEsta int DEFAULT '0',EMail nvarchar(100),Direccion nvarchar(50),
CP nvarchar(15),Poblacion nvarchar(50),Telefono nvarchar(25),PID nvarchar(30),PID2 nvarchar(30),
FAX nvarchar(25),AVISO nvarchar(1) DEFAULT '0',URL nvarchar(100),Zona int DEFAULT '0',TipoAlojamiento int DEFAULT '0',
Categoria int DEFAULT '0',NombrePagina nvarchar(25),Foto nvarchar(100));

CREATE INDEX DATOSHOTEL_CodigoEsta ON DatosHotel (CodigoEsta);

CREATE TABLE DescuentosColectivos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,CodigoColec int DEFAULT '0',Temporada int DEFAULT '0',TipoHab int DEFAULT '0',Prebase int DEFAULT '0',Precio real DEFAULT '0',Anyo int DEFAULT '0',Tarifa int DEFAULT '1');

CREATE INDEX DESCUENTOSCOLECTIVOS_CODIGOCOLEC ON DescuentosColectivos (CodigoColec);
CREATE INDEX DESCUENTOSCOLECTIVOS_Hab ON DescuentosColectivos (TipoHab);
CREATE INDEX DESCUENTOSCOLECTIVOS_Tempo ON DescuentosColectivos (Temporada);

CREATE TABLE Establecimientos(CodigoEsta int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(50),Orde int DEFAULT '0',PorCiento real DEFAULT '0',
PrepagoMinimo int DEFAULT '0',MinDias int DEFAULT '0', DiasAnulacion int DEFAULT '0',
Estado int DEFAULT '0',OBS nvarchar(1000) NULL,Moneda int DEFAULT '0');

CREATE TABLE Extras (ID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT '0',Extra_es nvarchar(100),Extra_it nvarchar(100),
Extra_en nvarchar(100),Extra_de nvarchar(100),Extra_fr nvarchar(100),
FInicio Datetime,FFinal Datetime,Importe real DEFAULT '0',PorPersona nvarchar(1) DEFAULT '0',
Colectivo int DEFAULT '0',Descuento real DEFAULT '0',ImporteDto real DEFAULT '0',
Colectivo2 int DEFAULT '0',Descuento2 real DEFAULT '0',ImporteDto2 real DEFAULT '0',
TipoSuple nvarchar(50),TipoHabi nvarchar(50),Tarifa int DEFAULT '1');

CREATE INDEX EXTRAS_CodigoEsta ON Extras (CodigoEsta);
CREATE INDEX EXTRAS_Fechas ON Extras (FInicio,FFinal);

CREATE TABLE Fichas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Apellidos nvarchar(50),Nombre nvarchar(50),Telefono nvarchar(25),FAX nvarchar(25),
Direccion nvarchar(50),CP nvarchar(15),Poblacion nvarchar(50),Provincia nvarchar(50),
Pais nvarchar(2),EMail nvarchar(75),Sexo nvarchar(10),FechaLlegada Datetime,
FechaSalida Datetime,FechaAlta Datetime,FechaNac Datetime,FechaImpor Datetime,
Hotel int DEFAULT '0',CodReserva int DEFAULT '0',Suplementos nvarchar(50),
Servicios nvarchar(50),MotivoEstancia int DEFAULT '0',ComoContacto int DEFAULT '0',
IdiomaWeb nvarchar(2),Informacion nvarchar(1) DEFAULT '0',Confirmado nvarchar(1) DEFAULT '0',
Observaciones nvarchar(1000) NULL,NombrePais nvarchar(50),CodigoVIP nvarchar(25),Activo nvarchar(1) DEFAULT '0');

CREATE INDEX FICHAS_CODRESERVA ON Fichas (Id);
CREATE INDEX FICHAS_VIP ON Fichas (CodigoVIP);

CREATE TABLE Ofertas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT '0',IdHabitacion int DEFAULT '0',AplicarEn int DEFAULT '0',
CodigoSuple int DEFAULT '0',PorPersona nvarchar(1) DEFAULT '0',Colectivo int DEFAULT '0',
Texto1_es nvarchar(1000) NULL,Texto1_it nvarchar(1000) NULL,Texto1_en nvarchar(1000) NULL,Texto1_de nvarchar(1000) NULL,
Texto1_fr nvarchar(1000) NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int DEFAULT '0',Dto real DEFAULT '0',Precio real DEFAULT '0',
Titulo_es nvarchar(100),Titulo_it nvarchar(100),Titulo_en nvarchar(100),
Titulo_de nvarchar(100),Titulo_fr nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada nvarchar(1) DEFAULT '0',Activa nvarchar(1) DEFAULT '1',
Calcula nvarchar(1) DEFAULT '1',FechaReserva nvarchar(1) DEFAULT '0',DiasSemana nvarchar(20),
NochesGratis int DEFAULT '0',CodigoPromocion nvarchar(25),Tarifa int DEFAULT '1');

CREATE INDEX OFERTAS_CodigoEsta ON Ofertas (CodigoEsta);
CREATE INDEX OFERTAS_Fechas ON Ofertas (FechaInicio,FechaFin);
CREATE INDEX OFERTAS_Promo ON Ofertas (CodigoPromocion);


CREATE TABLE OfertasVIP (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdHabitacion int DEFAULT '0',AplicarEn int DEFAULT '0',
CodigoSuple int DEFAULT '0',PorPersona nvarchar(1) DEFAULT '0',Colectivo int DEFAULT '0',
Texto1_es nvarchar(1000) NULL,Texto1_it nvarchar(1000) NULL,Texto1_en nvarchar(1000) NULL,Texto1_de nvarchar(1000) NULL,
Texto1_fr nvarchar(1000) NULL,FechaInicio Datetime,FechaFin Datetime,Caduca Datetime,
TotalNoches int DEFAULT '0',Dto real DEFAULT '0',Precio real DEFAULT '0',
Titulo_es nvarchar(100),Titulo_it nvarchar(100),Titulo_en nvarchar(100),
Titulo_de nvarchar(100),Titulo_fr nvarchar(100),Foto1 nvarchar(50),
Foto2 nvarchar(50),Destacada nvarchar(1) DEFAULT '0',Activa nvarchar(1) DEFAULT '1',
Calcula nvarchar(1) DEFAULT '1',FechaReserva nvarchar(1) DEFAULT '0',DiasSemana nvarchar(20),
NochesGratis int DEFAULT '0',CodigoPromocion nvarchar(25),Tarifa int DEFAULT '1');

CREATE INDEX OFERVIP_Fechas ON OfertasVIP (FechaInicio,FechaFin);
CREATE INDEX OFERVIP_Promo ON OfertasVIP (CodigoPromocion);

CREATE TABLE VisitasVIP (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdFicha int DEFAULT '0',CodigoEsta int DEFAULT '0',
CodReserva int DEFAULT '0',Habitacion nvarchar(25) NULL,
Comentario nvarchar(1000) NULL);

CREATE INDEX Visitas_reserva ON VisitasVIP (CodReserva);
CREATE INDEX Visitas_ficha ON VisitasVIP (IdFicha);
CREATE INDEX Visitas_hotel ON VisitasVIP (CodigoEsta);

CREATE TABLE PermisosPorEsta (IdUsuario int DEFAULT '0',CodigoEsta int DEFAULT '0');

CREATE INDEX PERMISOSPORESTA_CodigoEsta ON PermisosPorEsta (IdUsuario);

CREATE TABLE Regimen (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre_es nvarchar(50),Nombre_it nvarchar(50),Nombre_en nvarchar(50),
Nombre_de nvarchar(50),Nombre_fr nvarchar(50),Breve_es nvarchar(15),
Breve_it nvarchar(15),Breve_en nvarchar(15),Breve_de nvarchar(15),Breve_fr nvarchar(15));

CREATE TABLE RegimenHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdRegimen int DEFAULT '0',CodigoEsta int DEFAULT '0',CodigoHab int DEFAULT '0',
CodigoTempo int DEFAULT '0',Precio real DEFAULT '0',Defecto nvarchar(1) DEFAULT '0',
ANYO int DEFAULT '0',Tarifa int DEFAULT '1');

CREATE INDEX REGIMENHOTEL_IdRegimen ON RegimenHotel (IdRegimen);
CREATE INDEX REGIMENHOTEL_CodigoEsta ON RegimenHotel (CodigoEsta);
CREATE INDEX REGIMENHOTEL_CODIGOHAB ON RegimenHotel (CODIGOHAB);
CREATE INDEX REGIMENHOTEL_CODIGOTEMPO ON RegimenHotel (CODIGOTEMPO);


CREATE TABLE RegimenDtos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdRegimenHotel int DEFAULT '0',CodigoColec int DEFAULT '0',Descuento real DEFAULT '0',
Precio real DEFAULT '0',Tarifa int DEFAULT '1');

CREATE INDEX REGIMENDTOS_RegiHotel ON RegimenDtos (IdRegimenHotel);


CREATE TABLE Registro (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdUsuario int DEFAULT '0',Nombre nvarchar(50),Fecha Datetime,CodigoEsta int DEFAULT '0',
Anyo int DEFAULT '0',Proceso nvarchar(1000) NULL,Modulo nvarchar(50));

CREATE INDEX REGISTRO_CodigoEsta ON Registro (CodigoEsta);
CREATE INDEX REGISTRO_User ON Registro (IdUsuario);
CREATE INDEX REGISTRO_Fecha ON Registro (Fecha);

CREATE TABLE Reservas (Cod_Res int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT '0',FechaIni Datetime,FechaFin Datetime,
FechaReserva Datetime,NumDias int DEFAULT '0',Servicios nvarchar(50),
Importe real DEFAULT '0',ImportePag real DEFAULT '0',Activa nvarchar(1) DEFAULT '0',
Comentarios nvarchar(1000) NULL,Idi nvarchar(2),TPVFecha nvarchar(50),
TPVCodAprobacion nvarchar(50),TPVIdTrans nvarchar(50),TPVCodError nvarchar(50),
CodOferta nvarchar(50),PelasOferta nvarchar(50),IdCliente int DEFAULT '0',
TipoVenta int DEFAULT '0',CodAgencia int DEFAULT '0' NOT NULL,CodigoVIP nvarchar(25),
TipoVentaAgencia int DEFAULT '0' NOT NULL,Tarifa int DEFAULT '1', Anulada nvarchar(1) DEFAULT '0',
FechaModificacion Datetime, ImporteModificado real DEFAULT '0');

CREATE INDEX RESERVAS_CodigoEsta ON Reservas (CodigoEsta);
CREATE INDEX RESERVAS_FechaRes ON Reservas (FechaReserva);
CREATE INDEX RESERVAS_FechaIn ON Reservas (FechaIni,FechaFin);
CREATE INDEX RESERVAS_Cliente ON Reservas (IdCliente);
CREATE INDEX RESERVAS_Tarifa ON Reservas (Tarifa);

CREATE TABLE Temporadas (CodigoTemp int AUTO_INCREMENT NOT NULL PRIMARY KEY,
CodigoEsta int DEFAULT '0',FInicio Datetime,FFinal Datetime,ReleaseHab int DEFAULT '1',
Minimo int DEFAULT '1');

CREATE INDEX TEMPORADAS_CodigoEsta ON Temporadas (CodigoEsta);
CREATE INDEX TEMPORADAS_Fechas ON Temporadas (FInicio,FFinal);

CREATE TABLE TemporadasNomres (TempIdi int DEFAULT '0',Idioma nvarchar(2),Nombre nvarchar(50));

CREATE INDEX TEMPORADASNomres_Id ON TemporadasNomres (TempIdi);

CREATE TABLE TipoAlojamiento (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre_es nvarchar(50),Nombre_it nvarchar(50),Nombre_en nvarchar(50),Nombre_de nvarchar(50),
Nombre_fr nvarchar(50),IdTipo int DEFAULT '0');

CREATE TABLE TipoHabita (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Orden int DEFAULT '0',ParaCapMax int DEFAULT '0',ParaCapMin int DEFAULT '0',
ParaAdultMax int DEFAULT '0',ParaNiMax int DEFAULT '0',ParaCapNormal int DEFAULT '0',
ParaAdultMin int DEFAULT '0',Nombre_es nvarchar(50),Nombre_it nvarchar(50),
Nombre_en nvarchar(50),Nombre_de nvarchar(50),Nombre_fr nvarchar(50));

CREATE TABLE TipoHabitaNombres (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
TipoHabitacion int DEFAULT '0',CodigoEsta int DEFAULT '0',Nombre_es nvarchar(50),
Nombre_it nvarchar(50),Nombre_en nvarchar(50),Nombre_de nvarchar(50),Nombre_fr nvarchar(50),
ParaCapMax int DEFAULT '0',ParaCapMin int DEFAULT '0',
ParaAdultMax int DEFAULT '0',ParaNiMax int DEFAULT '0',ParaCapNormal int DEFAULT '0',
ParaAdultMin int DEFAULT '0',Orden int DEFAULT '0',
CunaOcupa nvarchar(1) DEFAULT '0');

CREATE INDEX TIPOHABITANOMBRES_CodigoEsta ON TipoHabitaNombres (CodigoEsta);
CREATE INDEX TIPOHABITANOMBRES_Habita ON TipoHabitaNombres (TipoHabitacion);

CREATE TABLE TipoHabitaPrecios (IdHabita int DEFAULT '0',Temporada int DEFAULT '0',
PrePreBase real DEFAULT '0',PrePerHab nvarchar(1) DEFAULT '0',Tarifa int DEFAULT '1');

CREATE INDEX TIPOHABITAPrecios_Habita ON TipoHabitaPrecios (IdHabita);
CREATE INDEX TIPOHABITAPrecios_Tempo ON TipoHabitaPrecios (Temporada);

CREATE TABLE TipoReserva (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdReserva int DEFAULT '0',IdTipoHabitacion int DEFAULT '0',
CodigoEsta int DEFAULT '0',CuantasHabis int DEFAULT '1',
FechaInicio Datetime,FechaFinal Datetime,FechaReserva Datetime,
NumAdultos int DEFAULT '0',NumBebes int DEFAULT '0',NumNinos1 int DEFAULT '0',
NumNinos2 int DEFAULT '0',Suplementos nvarchar(50));

CREATE INDEX TIPORESERVA_Res ON TipoReserva (IdReserva);
CREATE INDEX TIPORESERVA_Fechas ON TipoReserva (FechaInicio,FechaFinal);

CREATE TABLE TiposServicio (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre_es nvarchar(50),Nombre_it nvarchar(50),Nombre_en nvarchar(50),
Nombre_de nvarchar(50),Nombre_fr nvarchar(50),Foto nvarchar(75));

CREATE TABLE Usuaris (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
UserName nvarchar(25),Pass nvarchar(25),Nom nvarchar(50));

CREATE TABLE Zonas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Zona_es nvarchar(50),Zona_it nvarchar(50),Zona_en nvarchar(50),Zona_de nvarchar(50),
Zona_fr nvarchar(50),PosTop int DEFAULT '0',PosLeft int DEFAULT '0',Foto nvarchar(50));

CREATE TABLE FotosHabitacion (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdHabitacion int DEFAULT '0',Orden int DEFAULT '0',Foto nvarchar(100) NULL);
CREATE INDEX FHabi ON FotosHabitacion (IdHabitacion);

CREATE TABLE HabitacionesHotel (CodigoEsta int DEFAULT '0',
IdHabitacion int DEFAULT '0',Texto_es nvarchar(1000) NULL,Texto_en nvarchar(1000) NULL,Texto_de nvarchar(1000) NULL,
Texto_it nvarchar(1000) NULL,Texto_fr nvarchar(1000) NULL);
CREATE INDEX HabiHotel ON HabitacionesHotel (CodigoEsta);
CREATE INDEX IdHabiHotel ON HabitacionesHotel (IdHabitacion);

create table Agencias (id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(75) NULL,
Email nvarchar(75) NULL,
Direccion nvarchar(75) NULL,
CP nvarchar(15) NULL,
Poblacion nvarchar(50) NULL,
Pais nvarchar(50) NULL,
Observaciones nvarchar(1000) NULL,
Activa nvarchar(1) NOT NULL DEFAULT '0',
Usuario nvarchar(25) NULL,
Clave nvarchar(25) NULL,
Comision real NOT NULL,
BAL nvarchar(25) NULL,
Contacto nvarchar(75) NULL,
Telefono nvarchar(50) NULL,
Fax nvarchar(25) NULL,
Sistema int NULL,Tarifa int DEFAULT '1');

CREATE TABLE PlantillasNews (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Nombre nvarchar(75) NOT NULL,Plantilla nvarchar(1000));

CREATE TABLE ErrorEmails (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdMensaje int DEFAULT '0',IdCliente Int DEFAULT '0',EMail nvarchar(75),Descripcion nvarchar(150),Tabla nvarchar(50));
CREATE INDEX PolMensaje ON ErrorEmails (IdMensaje);
CREATE INDEX PolCliente ON ErrorEmails (IdCliente);

CREATE TABLE ResumenEmails (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
Asunto nvarchar(75),Mensaje nvarchar(1000),Filtro nvarchar(1000),Tabla nvarchar(50),Errores int DEFAULT '0',
Correctos int DEFAULT '0',FechaEnvio DateTime);

CREATE TABLE ReservaServicio (CodReserva int NOT NULL,IdServicio int DEFAULT '0' NOT NULL, Cuantas int DEFAULT '0',
Pelas real DEFAULT '0',Tarifa int DEFAULT '1',Tipo int DEFAULT '0');
CREATE INDEX laRes ON ReservaServicio (CodReserva);
CREATE INDEX elServi ON ReservaServicio (IdServicio);

CREATE TABLE ServiciosExtras (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT '0',
URL nvarchar(100), Ancho int DEFAULT '0', Alto int DEFAULT '0', Nombre_es nvarchar(100), Nombre_it nvarchar(100),
Nombre_en nvarchar(100), Nombre_de nvarchar(100), Nombre_fr nvarchar(100), Texto_es nvarchar(1000), Texto_it nvarchar(1000),
Texto_en nvarchar(1000), Texto_de nvarchar(1000),Texto_fr nvarchar(1000), Activo nvarchar(1) DEFAULT '0', Orden int DEFAULT '0');
CREATE INDEX elho ON ServiciosExtras (CodigoEsta);

CREATE TABLE ServiciosPrecios (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdServicio int DEFAULT '0',
FechaInicio datetime, FechaFinal datetime, IdColectivo int DEFAULT '0', Tipo int DEFAULT '0',
Importe real DEFAULT '0',Tarifa int DEFAULT '1', Obligatorio nvarchar(1) DEFAULT '0', 
Regimen nvarchar(75), Habitaciones nvarchar(75));
CREATE INDEX laPela ON ServiciosPrecios (IdServicio);

CREATE TABLE ServiciosFotos (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
IdServicio int DEFAULT '0',Orden int DEFAULT '0',Foto nvarchar(100) NULL);
CREATE INDEX FServi ON ServiciosFotos (IdServicio);

#CREATE VIEW ConsultaHoteles AS SELECT Establecimientos.CodigoEsta,Establecimientos.Nombre, Establecimientos.Estado, DatosHotel.Poblacion, DatosHotel.Zona, DatosHotel.TipoAlojamiento, DatosHotel.Categoria, Establecimientos.Orde FROM Establecimientos INNER JOIN DatosHotel ON Establecimientos.CodigoEsta = DatosHotel.CodigoEsta;

#CREATE VIEW Confirmadas AS SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM TipoReserva INNER JOIN Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res WHERE (Reservas.Activa <> 0 AND Anulada=0) GROUP BY TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal;

#CREATE VIEW Disponibles AS SELECT TOP 100 PERCENT Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Dia, Cupos.Cupo, Cupos.Estado, SUM(Confirmadas.cuantas) AS Confirmadas FROM Cupos LEFT OUTER JOIN Confirmadas ON Cupos.CodigoHab = Confirmadas.IdTipoHabitacion AND Cupos.Dia >= Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal GROUP BY Cupos.Dia, Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Cupo, Cupos.Estado ORDER BY Cupos.Dia;

INSERT INTO TipoAlojamiento (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('Apartamentos','Appartamenti','Apartments','Ferienwohnung','Appartements',2);

INSERT INTO TipoAlojamiento (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('Aparthotel','Aparthotel','Aparthotel','Aparthotel','Aparthotel',2);

INSERT INTO TipoAlojamiento (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('Agroturismo','Agriturismo','Rural Tourism','Agrotourismus','Agroturismo',0);

INSERT INTO TipoAlojamiento (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES  ('Hostal','Pensioni ','Hostel','Gasth�user','Hostal',1);

INSERT INTO TipoAlojamiento (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('Hotel','Hotel','Hotel','Hotel','H�tel',1);

INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('1 Estrella','1 Estrella','1 Star','1 Sterne','1 Star',1);
INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('2 Estrellas','2 Estrellas','2 Stars','2 Sterne','2 Stars',1);
INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('3 Estrellas','3 Estrellas','3 Stars','3 Sterne','3 Stars',1);
INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('4 Estrellas','4 Estrellas','4 Stars','4 Sterne','4 Stars',1);
INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('5 Estrellas','5 Estrellas','5 Stars','5 Sterne','5 Stars',1);

INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('1 Llave','1 Llave','1 Key','1 Schl�ssel','1 Key',2);
INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('2 Llaves','2 Llaves','2 Keys','2 Schl�ssel','2 Keys',2);
INSERT INTO Categorias (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,IdTipo) VALUES ('3 Llaves','3 Llaves','3 Keys','3 Schl�ssel','3 Keys',2);

INSERT INTO Regimen (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr) VALUES ('S�lo alojamiento','Solo aloggio','Room only','Nur Unterkunft','Seulement Logement');
INSERT INTO Regimen (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr) VALUES ('Alojamiento y desayuno','Aloggio con calazione','Bed and breackfast','�bernachtung mit Fr�hst�ck','Logement avec petit d�jeuner');
INSERT INTO Regimen (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr) VALUES ('Media pensi�n','Mezza pensione','Half-board','Halbpension','Demie-pension');
INSERT INTO Regimen (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr) VALUES ('Pensi�n completa','Pensione completa','Fullboard','Vollpension','Pension complete');
INSERT INTO Regimen (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr) VALUES ('Todo incluido','All Iinclusive','All inclusive','Alles Inklusive','Tout inclus');

CREATE TABLE TiposMoneda (Id int NOT NULL DEFAULT '0', Nombre_es nvarchar(100), Nombre_it nvarchar(100),
Nombre_en nvarchar(100), Nombre_de nvarchar(100), Nombre_fr nvarchar(100), CodigoISO nvarchar(3),Orden int DEFAULT '0',PorDefecto nvarchar(1) DEFAULT '0', Abreviado_es nvarchar(5), Abreviado_it nvarchar(5), Abreviado_en nvarchar(5), Abreviado_de nvarchar(5), Abreviado_fr nvarchar(5));
CREATE INDEX lmoneda ON TiposMoneda (Id);

INSERT INTO TiposMoneda (Id,Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,CodigoISO,Orden,PorDefecto) VALUES (0,'Euro','Euro','Euro','Euro','Euro','EUR',0,1);
INSERT INTO TiposMoneda (Id,Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,CodigoISO,Orden,PorDefecto) VALUES (1,'Dolar','Dolar','Dolar','Dolar','Dolar','USD',1,0);

CREATE TABLE Tarifas (Id int NOT NULL DEFAULT '0', Nombre_es nvarchar(50), Nombre_it nvarchar(50),
Nombre_en nvarchar(50), Nombre_de nvarchar(50), Nombre_fr nvarchar(50));
CREATE INDEX LTari ON Tarifas (Id);

INSERT INTO Tarifas (Id,Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr) VALUES (1,'General','General','General','General','General');

CREATE TABLE OfertasReserva (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdOferta int DEFAULT '0', 
IdReserva int DEFAULT '0',Importe real DEFAULT '0');

CREATE INDEX IndiOReserva ON OfertasReserva (IdOferta,IdReserva);

CREATE TABLE Caracteristicas (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, Caracteristica nvarchar(100), Icono nvarchar(75), Orden int DEFAULT '0');

CREATE TABLE CaracteristicasHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdCaracter int DEFAULT '0',
CodigoEsta int DEFAULT '0');
CREATE INDEX IndiCaracterH ON CaracteristicasHotel (IdCaracter,CodigoEsta);

CREATE TABLE SeccionesHotel (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, CodigoEsta int DEFAULT '0', 
Seccion nvarchar(75), Orden int DEFAULT '0');
CREATE INDEX IndiSecci ON SeccionesHotel (CodigoEsta);

CREATE TABLE Traducciones (Id int AUTO_INCREMENT NOT NULL PRIMARY KEY, IdReferencia int DEFAULT '0',
Idioma char(2), Tabla nvarchar(75), Campo nvarchar(75), Traduccion nvarchar(1000));
CREATE INDEX IndiTradu ON Traducciones (Idioma,Tabla,Campo);
CREATE INDEX IndiTraduId ON Traducciones (IdReferencia);


