# --------------------------------------------------------
# Host:                         lldf444.servidoresdns.net
# Database:                     qgq828
# Server version:               5.0.77
# Server OS:                    redhat-linux-gnu
# HeidiSQL version:             5.0.0.3272
# Date/time:                    2010-09-28 17:54:58
# --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
# Dumping database structure for qgq828
CREATE DATABASE IF NOT EXISTS `qgq828` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `qgq828`;


# Dumping structure for table qgq828.jos_crs_Agencias
DROP TABLE IF EXISTS `jos_crs_Agencias`;
CREATE TABLE IF NOT EXISTS `jos_crs_Agencias` (
  `id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(75) character set utf8 default NULL,
  `Email` varchar(75) character set utf8 default NULL,
  `Direccion` varchar(75) character set utf8 default NULL,
  `CP` varchar(15) character set utf8 default NULL,
  `Poblacion` varchar(50) character set utf8 default NULL,
  `Pais` varchar(50) character set utf8 default NULL,
  `Observaciones` varchar(10000) character set utf8 default NULL,
  `Activa` varchar(1) character set utf8 NOT NULL default '0',
  `Usuario` varchar(25) character set utf8 default NULL,
  `Clave` varchar(25) character set utf8 default NULL,
  `Comision` double NOT NULL,
  `BAL` varchar(25) character set utf8 default NULL,
  `IATA` varchar(25) character set utf8 default NULL,
  `Contacto` varchar(75) character set utf8 default NULL,
  `Telefono` varchar(50) character set utf8 default NULL,
  `Fax` varchar(25) character set utf8 default NULL,
  `Sistema` int(11) default NULL,
  `Tarifa` int(11) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Agencias: 0 rows
/*!40000 ALTER TABLE `jos_crs_Agencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Agencias` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Caracteristicas
DROP TABLE IF EXISTS `jos_crs_Caracteristicas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Caracteristicas` (
  `Id` int(11) NOT NULL auto_increment,
  `Caracteristica` varchar(100) character set utf8 default NULL,
  `Icono` varchar(75) character set utf8 default NULL,
  `Orden` int(11) default '0',
  `Destacada` varchar(1) character set utf8 default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Caracteristicas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Caracteristicas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Caracteristicas` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_CaracteristicasHotel
DROP TABLE IF EXISTS `jos_crs_CaracteristicasHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_CaracteristicasHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `IdCaracter` int(11) default '0',
  `CodigoEsta` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `IndiCaracterH` (`IdCaracter`,`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_CaracteristicasHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_CaracteristicasHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_CaracteristicasHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Categorias
DROP TABLE IF EXISTS `jos_crs_Categorias`;
CREATE TABLE IF NOT EXISTS `jos_crs_Categorias` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(50) character set utf8 default NULL,
  `IdTipo` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Categorias: 0 rows
/*!40000 ALTER TABLE `jos_crs_Categorias` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Categorias` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Colectivos
DROP TABLE IF EXISTS `jos_crs_Colectivos`;
CREATE TABLE IF NOT EXISTS `jos_crs_Colectivos` (
  `CodigoColec` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) NOT NULL,
  `Orde` int(11) default '0',
  `Nombre` varchar(50) character set utf8 default NULL,
  `DesdeEdad` int(11) NOT NULL default '0',
  `HastaEdad` int(11) NOT NULL default '0',
  PRIMARY KEY  (`CodigoColec`),
  KEY `IndiIDColec` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Colectivos: 0 rows
/*!40000 ALTER TABLE `jos_crs_Colectivos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Colectivos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_CondicionesHotel
DROP TABLE IF EXISTS `jos_crs_CondicionesHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_CondicionesHotel` (
  `CodigoEsta` int(11) default '0',
  `Texto` varchar(10000) character set utf8 default NULL,
  KEY `CONDICIONESHOTEL_CodigoEsta` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_CondicionesHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_CondicionesHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_CondicionesHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Cupos
DROP TABLE IF EXISTS `jos_crs_Cupos`;
CREATE TABLE IF NOT EXISTS `jos_crs_Cupos` (
  `CodigoHab` int(11) NOT NULL default '0',
  `CodigoEsta` int(11) default '0',
  `Dia` datetime default NULL,
  `Cupo` int(11) default '0',
  `Precio` double default '0',
  `DiasMinimos` int(11) default '1',
  `ReleaseHab` int(11) default '0',
  `Estado` int(11) default '2',
  `Tarifa` int(11) default '1',
  `LimiteCheckIn` int(11) default '-1',
  KEY `CUPOS_CODIGOHAB` (`CodigoHab`),
  KEY `CUPOS_Tarifa` (`Tarifa`),
  KEY `CUPOS_Dia` (`Dia`,`CodigoHab`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Cupos: 0 rows
/*!40000 ALTER TABLE `jos_crs_Cupos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Cupos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_DatosHotel
DROP TABLE IF EXISTS `jos_crs_DatosHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_DatosHotel` (
  `CodigoEsta` int(11) default '0',
  `EMail` varchar(100) character set utf8 default NULL,
  `Direccion` varchar(50) character set utf8 default NULL,
  `CP` varchar(15) character set utf8 default NULL,
  `Poblacion` varchar(50) character set utf8 default NULL,
  `Telefono` varchar(25) character set utf8 default NULL,
  `PID` varchar(30) character set utf8 default NULL,
  `PID2` varchar(30) character set utf8 default NULL,
  `FAX` varchar(25) character set utf8 default NULL,
  `AVISO` varchar(1) character set utf8 default '0',
  `URL` varchar(100) character set utf8 default NULL,
  `Zona` int(11) default '0',
  `TipoAlojamiento` int(11) default '0',
  `Categoria` int(11) default '0',
  `NombrePagina` varchar(25) character set utf8 default NULL,
  `Foto` varchar(100) character set utf8 default NULL,
  KEY `DATOSHOTEL_CodigoEsta` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_DatosHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_DatosHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_DatosHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_DescuentosColectivos
DROP TABLE IF EXISTS `jos_crs_DescuentosColectivos`;
CREATE TABLE IF NOT EXISTS `jos_crs_DescuentosColectivos` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoColec` int(11) default '0',
  `Temporada` int(11) default '0',
  `TipoHab` int(11) default '0',
  `Prebase` int(11) default '0',
  `Precio` double default '0',
  `Anyo` int(11) default '0',
  `Tarifa` int(11) default '1',
  `DesdePlazas` int(11) default '0',
  `HastaPlazas` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `DESCUENTOSCOLECTIVOS_CODIGOCOLEC` (`CodigoColec`),
  KEY `DESCUENTOSCOLECTIVOS_Hab` (`TipoHab`),
  KEY `DESCUENTOSCOLECTIVOS_Tempo` (`Temporada`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_DescuentosColectivos: 0 rows
/*!40000 ALTER TABLE `jos_crs_DescuentosColectivos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_DescuentosColectivos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_ErrorEmails
DROP TABLE IF EXISTS `jos_crs_ErrorEmails`;
CREATE TABLE IF NOT EXISTS `jos_crs_ErrorEmails` (
  `Id` int(11) NOT NULL auto_increment,
  `IdMensaje` int(11) default '0',
  `IdCliente` int(11) default '0',
  `EMail` varchar(75) character set utf8 default NULL,
  `Descripcion` varchar(150) character set utf8 default NULL,
  `Tabla` varchar(50) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `PolMensaje` (`IdMensaje`),
  KEY `PolCliente` (`IdCliente`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_ErrorEmails: 0 rows
/*!40000 ALTER TABLE `jos_crs_ErrorEmails` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_ErrorEmails` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Establecimientos
DROP TABLE IF EXISTS `jos_crs_Establecimientos`;
CREATE TABLE IF NOT EXISTS `jos_crs_Establecimientos` (
  `CodigoEsta` int(11) NOT NULL auto_increment,
  `Nombre` varchar(50) character set utf8 default NULL,
  `Orde` int(11) default '0',
  `PorCiento` double default '0',
  `PrepagoMinimo` int(11) default '0',
  `MinDias` int(11) default '0',
  `DiasAnulacion` int(11) default '0',
  `Estado` int(11) default '0',
  `OBS` varchar(10000) character set utf8 default NULL,
  `Moneda` int(11) default '0',
  PRIMARY KEY  (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Establecimientos: 0 rows
/*!40000 ALTER TABLE `jos_crs_Establecimientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Establecimientos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Extras
DROP TABLE IF EXISTS `jos_crs_Extras`;
CREATE TABLE IF NOT EXISTS `jos_crs_Extras` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `Extra` varchar(100) character set utf8 default NULL,
  `FInicio` datetime default NULL,
  `FFinal` datetime default NULL,
  `Importe` double default '0',
  `PorPersona` varchar(1) character set utf8 default '0',
  `Colectivo` int(11) default '0',
  `Descuento` double default '0',
  `ImporteDto` double default '0',
  `Colectivo2` int(11) default '0',
  `Descuento2` double default '0',
  `ImporteDto2` double default '0',
  `TipoSuple` varchar(50) character set utf8 default NULL,
  `TipoHabi` varchar(50) character set utf8 default NULL,
  `Tarifa` int(11) default '1',
  PRIMARY KEY  (`Id`),
  KEY `EXTRAS_CodigoEsta` (`CodigoEsta`),
  KEY `EXTRAS_Fechas` (`FInicio`,`FFinal`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Extras: 0 rows
/*!40000 ALTER TABLE `jos_crs_Extras` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Extras` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Fichas
DROP TABLE IF EXISTS `jos_crs_Fichas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Fichas` (
  `Id` int(11) NOT NULL auto_increment,
  `Apellidos` varchar(50) character set utf8 default NULL,
  `Nombre` varchar(50) character set utf8 default NULL,
  `Telefono` varchar(25) character set utf8 default NULL,
  `FAX` varchar(25) character set utf8 default NULL,
  `Direccion` varchar(50) character set utf8 default NULL,
  `CP` varchar(15) character set utf8 default NULL,
  `Poblacion` varchar(50) character set utf8 default NULL,
  `Provincia` varchar(50) character set utf8 default NULL,
  `Pais` varchar(2) character set utf8 default NULL,
  `EMail` varchar(75) character set utf8 default NULL,
  `Sexo` varchar(10) character set utf8 default NULL,
  `FechaLlegada` datetime default NULL,
  `FechaSalida` datetime default NULL,
  `FechaAlta` datetime default NULL,
  `FechaNac` datetime default NULL,
  `FechaImpor` datetime default NULL,
  `Hotel` int(11) default '0',
  `CodReserva` int(11) default '0',
  `Suplementos` varchar(50) character set utf8 default NULL,
  `Servicios` varchar(50) character set utf8 default NULL,
  `MotivoEstancia` int(11) default '0',
  `ComoContacto` int(11) default '0',
  `IdiomaWeb` varchar(2) character set utf8 default NULL,
  `Informacion` varchar(1) character set utf8 default '0',
  `Confirmado` varchar(1) character set utf8 default '0',
  `Observaciones` varchar(10000) character set utf8 default NULL,
  `NombrePais` varchar(50) character set utf8 default NULL,
  `CodigoVIP` varchar(25) character set utf8 default NULL,
  `Tratamiento` int(11) default '0',
  `Activo` varchar(1) character set utf8 default '0',
  PRIMARY KEY  (`Id`),
  KEY `FICHAS_CODRESERVA` (`Id`),
  KEY `FICHAS_VIP` (`CodigoVIP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Fichas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Fichas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Fichas` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_FotosHabitacion
DROP TABLE IF EXISTS `jos_crs_FotosHabitacion`;
CREATE TABLE IF NOT EXISTS `jos_crs_FotosHabitacion` (
  `Id` int(11) NOT NULL auto_increment,
  `IdHabitacion` int(11) default '0',
  `Orden` int(11) default '0',
  `Foto` varchar(100) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `FHabi` (`IdHabitacion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_FotosHabitacion: 0 rows
/*!40000 ALTER TABLE `jos_crs_FotosHabitacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_FotosHabitacion` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_FotosHotel
DROP TABLE IF EXISTS `jos_crs_FotosHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_FotosHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `IdSeccion` int(11) default '0',
  `Foto` varchar(75) character set utf8 default NULL,
  `Orden` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `IndiFHotel` (`CodigoEsta`),
  KEY `SecciFHotel` (`IdSeccion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_FotosHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_FotosHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_FotosHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_FPagoHotel
DROP TABLE IF EXISTS `jos_crs_FPagoHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_FPagoHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `tipoFPago` int(11) default '0',
  `CodComercio` varchar(50) character set utf8 default NULL,
  `Terminal` varchar(50) character set utf8 default NULL,
  `Clave` varchar(100) character set utf8 default NULL,
  `claveXor` varchar(100) character set utf8 default NULL,
  `Produccion` varchar(1) character set utf8 default '0',
  PRIMARY KEY  (`Id`),
  KEY `IndiFPHotel` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_FPagoHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_FPagoHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_FPagoHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_GmapsHotel
DROP TABLE IF EXISTS `jos_crs_GmapsHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_GmapsHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `laX` double default '0',
  `laY` double default '0',
  `Zoom` int(11) default '0',
  `Texto` varchar(10000) character set utf8 default NULL,
  `Icono` varchar(75) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `IndiGHotel` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_GmapsHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_GmapsHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_GmapsHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_HabitacionesHotel
DROP TABLE IF EXISTS `jos_crs_HabitacionesHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_HabitacionesHotel` (
  `CodigoEsta` int(11) default '0',
  `IdHabitacion` int(11) default '0',
  `Texto` varchar(10000) character set utf8 default NULL,
  KEY `IdHabiHotel` (`IdHabitacion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_HabitacionesHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_HabitacionesHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_HabitacionesHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Ofertas
DROP TABLE IF EXISTS `jos_crs_Ofertas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Ofertas` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `IdHabitacion` int(11) default '0',
  `AplicarEn` int(11) default '0',
  `CodigoSuple` int(11) default '0',
  `PorPersona` varchar(1) character set utf8 default '0',
  `Colectivo` int(11) default '0',
  `Texto` varchar(10000) character set utf8 default NULL,
  `FechaInicio` datetime default NULL,
  `FechaFin` datetime default NULL,
  `Caduca` datetime default NULL,
  `TotalNoches` int(11) default '0',
  `Dto` double default '0',
  `Precio` double default '0',
  `Titulo` varchar(100) character set utf8 default NULL,
  `Foto1` varchar(50) character set utf8 default NULL,
  `Foto2` varchar(50) character set utf8 default NULL,
  `Destacada` varchar(1) character set utf8 default '0',
  `Activa` varchar(1) character set utf8 default '1',
  `Calcula` varchar(1) character set utf8 default '1',
  `FechaReserva` varchar(1) character set utf8 default '0',
  `DiasSemana` varchar(20) character set utf8 default NULL,
  `NochesGratis` int(11) default '0',
  `CodigoPromocion` varchar(25) character set utf8 default NULL,
  `Tarifa` int(11) default '1',
  PRIMARY KEY  (`Id`),
  KEY `OFERTAS_CodigoEsta` (`CodigoEsta`),
  KEY `OFERTAS_Fechas` (`FechaInicio`,`FechaFin`),
  KEY `OFERTAS_Promo` (`CodigoPromocion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Ofertas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Ofertas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Ofertas` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_OfertasReserva
DROP TABLE IF EXISTS `jos_crs_OfertasReserva`;
CREATE TABLE IF NOT EXISTS `jos_crs_OfertasReserva` (
  `Id` int(11) NOT NULL auto_increment,
  `IdOferta` int(11) default '0',
  `IdReserva` int(11) default '0',
  `Importe` double default '0',
  PRIMARY KEY  (`Id`),
  KEY `IndiOReserva` (`IdOferta`,`IdReserva`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_OfertasReserva: 0 rows
/*!40000 ALTER TABLE `jos_crs_OfertasReserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_OfertasReserva` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_OfertasVIP
DROP TABLE IF EXISTS `jos_crs_OfertasVIP`;
CREATE TABLE IF NOT EXISTS `jos_crs_OfertasVIP` (
  `Id` int(11) NOT NULL auto_increment,
  `IdHabitacion` int(11) default '0',
  `AplicarEn` int(11) default '0',
  `CodigoSuple` int(11) default '0',
  `PorPersona` varchar(1) character set utf8 default '0',
  `Colectivo` int(11) default '0',
  `Texto` varchar(10000) character set utf8 default NULL,
  `FechaInicio` datetime default NULL,
  `FechaFin` datetime default NULL,
  `Caduca` datetime default NULL,
  `TotalNoches` int(11) default '0',
  `Dto` double default '0',
  `Precio` double default '0',
  `Titulo` varchar(100) character set utf8 default NULL,
  `Foto1` varchar(50) character set utf8 default NULL,
  `Foto2` varchar(50) character set utf8 default NULL,
  `Destacada` varchar(1) character set utf8 default '0',
  `Activa` varchar(1) character set utf8 default '1',
  `Calcula` varchar(1) character set utf8 default '1',
  `FechaReserva` varchar(1) character set utf8 default '0',
  `DiasSemana` varchar(20) character set utf8 default NULL,
  `NochesGratis` int(11) default '0',
  `CodigoPromocion` varchar(25) character set utf8 default NULL,
  `Tarifa` int(11) default '1',
  PRIMARY KEY  (`Id`),
  KEY `OFERVIP_Fechas` (`FechaInicio`,`FechaFin`),
  KEY `OFERVIP_Promo` (`CodigoPromocion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_OfertasVIP: 0 rows
/*!40000 ALTER TABLE `jos_crs_OfertasVIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_OfertasVIP` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_PermisosPorEsta
DROP TABLE IF EXISTS `jos_crs_PermisosPorEsta`;
CREATE TABLE IF NOT EXISTS `jos_crs_PermisosPorEsta` (
  `IdUsuario` int(11) default '0',
  `CodigoEsta` int(11) default '0',
  KEY `PermisosPorEsta_CodigoEsta` (`IdUsuario`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_PermisosPorEsta: 0 rows
/*!40000 ALTER TABLE `jos_crs_PermisosPorEsta` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_PermisosPorEsta` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_PlantillasNews
DROP TABLE IF EXISTS `jos_crs_PlantillasNews`;
CREATE TABLE IF NOT EXISTS `jos_crs_PlantillasNews` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(75) character set utf8 NOT NULL,
  `Plantilla` varchar(10000) character set utf8 default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_PlantillasNews: 0 rows
/*!40000 ALTER TABLE `jos_crs_PlantillasNews` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_PlantillasNews` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Regimen
DROP TABLE IF EXISTS `jos_crs_Regimen`;
CREATE TABLE IF NOT EXISTS `jos_crs_Regimen` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(50) character set utf8 default NULL,
  `Breve` varchar(15) character set utf8 default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Regimen: 0 rows
/*!40000 ALTER TABLE `jos_crs_Regimen` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Regimen` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_RegimenDtos
DROP TABLE IF EXISTS `jos_crs_RegimenDtos`;
CREATE TABLE IF NOT EXISTS `jos_crs_RegimenDtos` (
  `Id` int(11) NOT NULL auto_increment,
  `IdRegimenHotel` int(11) default '0',
  `CodigoColec` int(11) default '0',
  `Descuento` double default '0',
  `Precio` double default '0',
  `Tarifa` int(11) default '1',
  `DesdePlazas` int(11) default '0',
  `HastaPlazas` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `RegimenDtos_RegiHotel` (`IdRegimenHotel`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_RegimenDtos: 0 rows
/*!40000 ALTER TABLE `jos_crs_RegimenDtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_RegimenDtos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_RegimenHotel
DROP TABLE IF EXISTS `jos_crs_RegimenHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_RegimenHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `IdRegimen` int(11) default '0',
  `CodigoEsta` int(11) default '0',
  `CodigoHab` int(11) default '0',
  `CodigoTempo` int(11) default '0',
  `Precio` double default '0',
  `Defecto` varchar(1) character set utf8 default '0',
  `ANYO` int(11) default '0',
  `Tarifa` int(11) default '1',
  PRIMARY KEY  (`Id`),
  KEY `RegimenHotel_IdRegimen` (`IdRegimen`),
  KEY `RegimenHotel_CodigoEsta` (`CodigoEsta`),
  KEY `RegimenHotel_CodigoHab` (`CodigoHab`),
  KEY `RegimenHotel_CodigoTempo` (`CodigoTempo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_RegimenHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_RegimenHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_RegimenHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Registro
DROP TABLE IF EXISTS `jos_crs_Registro`;
CREATE TABLE IF NOT EXISTS `jos_crs_Registro` (
  `Id` int(11) NOT NULL auto_increment,
  `IdUsuario` int(11) default '0',
  `Nombre` varchar(50) character set utf8 default NULL,
  `Fecha` datetime default NULL,
  `CodigoEsta` int(11) default '0',
  `Anyo` int(11) default '0',
  `Proceso` varchar(10000) character set utf8 default NULL,
  `Modulo` varchar(50) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `Registro_CodigoEsta` (`CodigoEsta`),
  KEY `Registro_User` (`IdUsuario`),
  KEY `Registro_Fecha` (`Fecha`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Registro: 0 rows
/*!40000 ALTER TABLE `jos_crs_Registro` DISABLE KEYS */;
INSERT INTO `jos_crs_Registro` (`Id`, `IdUsuario`, `Nombre`, `Fecha`, `CodigoEsta`, `Anyo`, `Proceso`, `Modulo`) VALUES (1, 6, 'admin', '2010-09-28 17:51:00', 0, 2010, 'INSERT INTO jos_crs_TipoAlojamiento (Nombre,IdTipo) VALUES (&#39;ww&#39;,1)', NULL), (2, 6, 'admin', '2010-09-28 17:51:00', 0, 2010, 'DELETE FROM jos_crs_TipoAlojamiento WHERE (Id=7)', NULL);
/*!40000 ALTER TABLE `jos_crs_Registro` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Reservas
DROP TABLE IF EXISTS `jos_crs_Reservas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Reservas` (
  `Cod_Res` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `FechaIni` datetime default NULL,
  `FechaFin` datetime default NULL,
  `FechaReserva` datetime default NULL,
  `NumDias` int(11) default '0',
  `Servicios` varchar(50) character set utf8 default NULL,
  `Importe` double default '0',
  `ImportePag` double default '0',
  `Activa` varchar(1) character set utf8 default '0',
  `Comentarios` varchar(10000) character set utf8 default NULL,
  `Idi` varchar(2) character set utf8 default NULL,
  `TPVFecha` varchar(50) character set utf8 default NULL,
  `TPVCodAprobacion` varchar(50) character set utf8 default NULL,
  `TPVIdTrans` varchar(50) character set utf8 default NULL,
  `TPVCodError` varchar(50) character set utf8 default NULL,
  `CodOferta` varchar(50) character set utf8 default NULL,
  `PelasOferta` varchar(50) character set utf8 default NULL,
  `IdCliente` int(11) default '0',
  `TipoVenta` int(11) default '0',
  `CodAgencia` int(11) NOT NULL default '0',
  `CodigoVIP` varchar(25) character set utf8 default NULL,
  `TipoVentaAgencia` int(11) NOT NULL default '0',
  `Tarifa` int(11) default '1',
  `Anulada` varchar(1) character set utf8 default '0',
  `FechaModificacion` datetime default NULL,
  `ImporteModificado` double default '0',
  PRIMARY KEY  (`Cod_Res`),
  KEY `RESERVAS_CodigoEsta` (`CodigoEsta`),
  KEY `RESERVAS_FechaRes` (`FechaReserva`),
  KEY `RESERVAS_FechaIn` (`FechaIni`,`FechaFin`),
  KEY `RESERVAS_Cliente` (`IdCliente`),
  KEY `RESERVAS_Tarifa` (`Tarifa`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Reservas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Reservas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Reservas` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_ReservaServicio
DROP TABLE IF EXISTS `jos_crs_ReservaServicio`;
CREATE TABLE IF NOT EXISTS `jos_crs_ReservaServicio` (
  `CodReserva` int(11) NOT NULL,
  `IdServicio` int(11) NOT NULL default '0',
  `Cuantas` int(11) default '0',
  `Pelas` double default '0',
  `Tarifa` int(11) default '1',
  `IdColectivo` int(11) default '0',
  `Tipo` int(11) default '0',
  KEY `laRes` (`CodReserva`),
  KEY `elServi` (`IdServicio`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_ReservaServicio: 0 rows
/*!40000 ALTER TABLE `jos_crs_ReservaServicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_ReservaServicio` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_ResumenEmails
DROP TABLE IF EXISTS `jos_crs_ResumenEmails`;
CREATE TABLE IF NOT EXISTS `jos_crs_ResumenEmails` (
  `Id` int(11) NOT NULL auto_increment,
  `Asunto` varchar(75) character set utf8 default NULL,
  `Mensaje` varchar(10000) character set utf8 default NULL,
  `Filtro` varchar(10000) character set utf8 default NULL,
  `Tabla` varchar(50) character set utf8 default NULL,
  `Errores` int(11) default '0',
  `Correctos` int(11) default '0',
  `FechaEnvio` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_ResumenEmails: 0 rows
/*!40000 ALTER TABLE `jos_crs_ResumenEmails` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_ResumenEmails` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_SeccionesHotel
DROP TABLE IF EXISTS `jos_crs_SeccionesHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_SeccionesHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `Seccion` varchar(75) character set utf8 default NULL,
  `Orden` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `IndiSecci` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_SeccionesHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_SeccionesHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_SeccionesHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_ServiciosExtras
DROP TABLE IF EXISTS `jos_crs_ServiciosExtras`;
CREATE TABLE IF NOT EXISTS `jos_crs_ServiciosExtras` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `URL` varchar(100) character set utf8 default NULL,
  `Ancho` int(11) default '0',
  `Alto` int(11) default '0',
  `Nombre` varchar(100) character set utf8 default NULL,
  `Texto` varchar(10000) character set utf8 default NULL,
  `Activo` varchar(1) character set utf8 default '0',
  `Orden` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `elho` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_ServiciosExtras: 0 rows
/*!40000 ALTER TABLE `jos_crs_ServiciosExtras` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_ServiciosExtras` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_ServiciosFotos
DROP TABLE IF EXISTS `jos_crs_ServiciosFotos`;
CREATE TABLE IF NOT EXISTS `jos_crs_ServiciosFotos` (
  `Id` int(11) NOT NULL auto_increment,
  `IdServicio` int(11) default '0',
  `Orden` int(11) default '0',
  `Foto` varchar(100) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `FServi` (`IdServicio`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_ServiciosFotos: 0 rows
/*!40000 ALTER TABLE `jos_crs_ServiciosFotos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_ServiciosFotos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_ServiciosPrecios
DROP TABLE IF EXISTS `jos_crs_ServiciosPrecios`;
CREATE TABLE IF NOT EXISTS `jos_crs_ServiciosPrecios` (
  `Id` int(11) NOT NULL auto_increment,
  `IdServicio` int(11) default '0',
  `FechaInicio` datetime default NULL,
  `FechaFinal` datetime default NULL,
  `IdColectivo` int(11) default '0',
  `Tipo` int(11) default '0',
  `Importe` double default '0',
  `Tarifa` int(11) default '1',
  `Obligatorio` varchar(1) character set utf8 default '0',
  `Regimen` varchar(75) character set utf8 default NULL,
  `Habitaciones` varchar(75) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `laPela` (`IdServicio`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_ServiciosPrecios: 0 rows
/*!40000 ALTER TABLE `jos_crs_ServiciosPrecios` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_ServiciosPrecios` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Tarifas
DROP TABLE IF EXISTS `jos_crs_Tarifas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Tarifas` (
  `Id` int(11) NOT NULL default '0',
  `Nombre` varchar(50) character set utf8 default NULL,
  KEY `LTari` (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Tarifas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Tarifas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Tarifas` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Temporadas
DROP TABLE IF EXISTS `jos_crs_Temporadas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Temporadas` (
  `CodigoTemp` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `FInicio` datetime default NULL,
  `FFinal` datetime default NULL,
  `ReleaseHab` int(11) default '1',
  `Minimo` int(11) default '1',
  PRIMARY KEY  (`CodigoTemp`),
  KEY `TEMPORADAS_CodigoEsta` (`CodigoEsta`),
  KEY `TEMPORADAS_Fechas` (`FInicio`,`FFinal`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Temporadas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Temporadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Temporadas` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TemporadasNomres
DROP TABLE IF EXISTS `jos_crs_TemporadasNomres`;
CREATE TABLE IF NOT EXISTS `jos_crs_TemporadasNomres` (
  `TempIdi` int(11) default '0',
  `Idioma` varchar(2) character set utf8 default NULL,
  `Nombre` varchar(50) character set utf8 default NULL,
  KEY `TEMPORADASNomres_Id` (`TempIdi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TemporadasNomres: 0 rows
/*!40000 ALTER TABLE `jos_crs_TemporadasNomres` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TemporadasNomres` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TextosHotel
DROP TABLE IF EXISTS `jos_crs_TextosHotel`;
CREATE TABLE IF NOT EXISTS `jos_crs_TextosHotel` (
  `Id` int(11) NOT NULL auto_increment,
  `CodigoEsta` int(11) default '0',
  `IdSeccion` int(11) default '0',
  `Texto` varchar(10000) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `IndiTHotel` (`CodigoEsta`),
  KEY `SecciTHotel` (`IdSeccion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TextosHotel: 0 rows
/*!40000 ALTER TABLE `jos_crs_TextosHotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TextosHotel` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TipoAlojamiento
DROP TABLE IF EXISTS `jos_crs_TipoAlojamiento`;
CREATE TABLE IF NOT EXISTS `jos_crs_TipoAlojamiento` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(50) character set utf8 default NULL,
  `IdTipo` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TipoAlojamiento: 0 rows
/*!40000 ALTER TABLE `jos_crs_TipoAlojamiento` DISABLE KEYS */;
INSERT INTO `jos_crs_TipoAlojamiento` (`Id`, `Nombre`, `IdTipo`) VALUES (1, 'Apartamentos', 2), (2, 'Aparthotel', 2), (3, 'Agroturismo', 1), (4, 'Hotel', 1);
/*!40000 ALTER TABLE `jos_crs_TipoAlojamiento` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TipoHabita
DROP TABLE IF EXISTS `jos_crs_TipoHabita`;
CREATE TABLE IF NOT EXISTS `jos_crs_TipoHabita` (
  `Id` int(11) NOT NULL auto_increment,
  `Orden` int(11) default '0',
  `ParaCapMax` int(11) default '0',
  `ParaCapMin` int(11) default '0',
  `ParaAdultMax` int(11) default '0',
  `ParaNiMax` int(11) default '0',
  `ParaCapNormal` int(11) default '0',
  `ParaAdultMin` int(11) default '0',
  `Nombre` varchar(50) character set utf8 default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TipoHabita: 0 rows
/*!40000 ALTER TABLE `jos_crs_TipoHabita` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TipoHabita` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TipoHabitaNombres
DROP TABLE IF EXISTS `jos_crs_TipoHabitaNombres`;
CREATE TABLE IF NOT EXISTS `jos_crs_TipoHabitaNombres` (
  `Id` int(11) NOT NULL auto_increment,
  `TipoHabitacion` int(11) default '0',
  `CodigoEsta` int(11) default '0',
  `Nombre` varchar(50) character set utf8 default NULL,
  `ParaCapMax` int(11) default '0',
  `ParaCapMin` int(11) default '0',
  `ParaAdultMax` int(11) default '0',
  `ParaNiMax` int(11) default '0',
  `ParaCapNormal` int(11) default '0',
  `ParaAdultMin` int(11) default '0',
  `Orden` int(11) default '0',
  `CunaOcupa` varchar(1) character set utf8 default '0',
  PRIMARY KEY  (`Id`),
  KEY `TIPOHabitaNOMBRES_CodigoEsta` (`CodigoEsta`),
  KEY `TIPOHabitaNOMBRES_Habita` (`TipoHabitacion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TipoHabitaNombres: 0 rows
/*!40000 ALTER TABLE `jos_crs_TipoHabitaNombres` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TipoHabitaNombres` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TipoHabitaPrecios
DROP TABLE IF EXISTS `jos_crs_TipoHabitaPrecios`;
CREATE TABLE IF NOT EXISTS `jos_crs_TipoHabitaPrecios` (
  `IdHabita` int(11) default '0',
  `Temporada` int(11) default '0',
  `PrePreBase` double default '0',
  `PrePerHab` varchar(1) character set utf8 default '0',
  `Anyo` int(11) default '0',
  `Tarifa` int(11) default '1',
  KEY `TIPOHabitaPrecios_Habita` (`IdHabita`),
  KEY `TIPOHabitaPrecios_Tempo` (`Temporada`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TipoHabitaPrecios: 0 rows
/*!40000 ALTER TABLE `jos_crs_TipoHabitaPrecios` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TipoHabitaPrecios` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TipoReserva
DROP TABLE IF EXISTS `jos_crs_TipoReserva`;
CREATE TABLE IF NOT EXISTS `jos_crs_TipoReserva` (
  `Id` int(11) NOT NULL auto_increment,
  `IdReserva` int(11) default '0',
  `IdTipoHabitacion` int(11) default '0',
  `CodigoEsta` int(11) default '0',
  `CuantasHabis` int(11) default '1',
  `FechaInicio` datetime default NULL,
  `FechaFinal` datetime default NULL,
  `FechaReserva` datetime default NULL,
  `NumAdultos` int(11) default '0',
  `NumBebes` int(11) default '0',
  `NumNinos1` int(11) default '0',
  `NumNinos2` int(11) default '0',
  `Suplementos` varchar(50) character set utf8 default NULL,
  `Importe` double default '0',
  PRIMARY KEY  (`Id`),
  KEY `TIPORESERVA_Res` (`IdReserva`),
  KEY `TIPORESERVA_Fechas` (`FechaInicio`,`FechaFinal`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TipoReserva: 0 rows
/*!40000 ALTER TABLE `jos_crs_TipoReserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TipoReserva` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TiposMoneda
DROP TABLE IF EXISTS `jos_crs_TiposMoneda`;
CREATE TABLE IF NOT EXISTS `jos_crs_TiposMoneda` (
  `Id` int(11) NOT NULL default '0',
  `Nombre` varchar(100) character set utf8 default NULL,
  `CodigoISO` varchar(3) character set utf8 default NULL,
  `Orden` int(11) default '0',
  `PorDefecto` varchar(1) character set utf8 default '0',
  `Abreviado` varchar(5) character set utf8 default NULL,
  KEY `lmoneda` (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TiposMoneda: 0 rows
/*!40000 ALTER TABLE `jos_crs_TiposMoneda` DISABLE KEYS */;
INSERT INTO `jos_crs_TiposMoneda` (`Id`, `Nombre`, `CodigoISO`, `Orden`, `PorDefecto`, `Abreviado`) VALUES (1, 'Eur', 'EUR', 0, '1', NULL), (2, 'Libra Esterlina', 'GBP', 1, '0', NULL);
/*!40000 ALTER TABLE `jos_crs_TiposMoneda` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_TiposServicio
DROP TABLE IF EXISTS `jos_crs_TiposServicio`;
CREATE TABLE IF NOT EXISTS `jos_crs_TiposServicio` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(50) character set utf8 default NULL,
  `Foto` varchar(75) character set utf8 default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_TiposServicio: 0 rows
/*!40000 ALTER TABLE `jos_crs_TiposServicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_TiposServicio` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Traducciones
DROP TABLE IF EXISTS `jos_crs_Traducciones`;
CREATE TABLE IF NOT EXISTS `jos_crs_Traducciones` (
  `Id` int(11) NOT NULL auto_increment,
  `IdReferencia` int(11) default '0',
  `Idioma` char(2) collate latin1_spanish_ci default NULL,
  `Tabla` varchar(75) character set utf8 default NULL,
  `Campo` varchar(75) character set utf8 default NULL,
  `Traduccion` varchar(10000) character set utf8 default NULL,
  `CodigoEsta` int(11) default '0',
  PRIMARY KEY  (`Id`),
  KEY `IndiTradu` (`Tabla`,`Campo`,`Idioma`),
  KEY `IndiTraduId` (`IdReferencia`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Traducciones: 0 rows
/*!40000 ALTER TABLE `jos_crs_Traducciones` DISABLE KEYS */;
INSERT INTO `jos_crs_Traducciones` (`Id`, `IdReferencia`, `Idioma`, `Tabla`, `Campo`, `Traduccion`, `CodigoEsta`) VALUES (1, 1, 'en', 'TiposMoneda', 'Nombre', 'Eur', 0), (2, 2, 'en', 'TiposMoneda', 'Nombre', 'Pounds Esterling', 0), (3, 1, 'en', 'TipoAlojamiento', 'Nombre', 'Apartments ', 0), (4, 2, 'en', 'TipoAlojamiento', 'Nombre', 'Aparthotel ', 0), (5, 3, 'en', 'TipoAlojamiento', 'Nombre', 'Rural Tourism ', 0), (6, 4, 'en', 'TipoAlojamiento', 'Nombre', 'Hotel ', 0), (7, 5, 'en', 'TipoAlojamiento', 'Nombre', 'aaaaaaa', 0), (8, 6, 'en', 'TipoAlojamiento', 'Nombre', 'a', 0);
/*!40000 ALTER TABLE `jos_crs_Traducciones` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Tratamientos
DROP TABLE IF EXISTS `jos_crs_Tratamientos`;
CREATE TABLE IF NOT EXISTS `jos_crs_Tratamientos` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(50) character set utf8 default NULL,
  `Breve` varchar(15) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `IdTrata` (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Tratamientos: 0 rows
/*!40000 ALTER TABLE `jos_crs_Tratamientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Tratamientos` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_VisitasVIP
DROP TABLE IF EXISTS `jos_crs_VisitasVIP`;
CREATE TABLE IF NOT EXISTS `jos_crs_VisitasVIP` (
  `Id` int(11) NOT NULL auto_increment,
  `IdFicha` int(11) default '0',
  `CodigoEsta` int(11) default '0',
  `CodReserva` int(11) default '0',
  `Habitacion` varchar(25) character set utf8 default NULL,
  `Comentario` varchar(10000) character set utf8 default NULL,
  PRIMARY KEY  (`Id`),
  KEY `Visitas_reserva` (`CodReserva`),
  KEY `Visitas_ficha` (`IdFicha`),
  KEY `Visitas_hotel` (`CodigoEsta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_VisitasVIP: 0 rows
/*!40000 ALTER TABLE `jos_crs_VisitasVIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_VisitasVIP` ENABLE KEYS */;


# Dumping structure for table qgq828.jos_crs_Zonas
DROP TABLE IF EXISTS `jos_crs_Zonas`;
CREATE TABLE IF NOT EXISTS `jos_crs_Zonas` (
  `Id` int(11) NOT NULL auto_increment,
  `IdPadre` int(11) NOT NULL,
  `Zona` varchar(50) character set utf8 default NULL,
  `PosTop` float default '0',
  `PosLeft` float default '0',
  `Zoom` int(11) default '0',
  `Foto` varchar(50) character set utf8 default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq828.jos_crs_Zonas: 0 rows
/*!40000 ALTER TABLE `jos_crs_Zonas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crs_Zonas` ENABLE KEYS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
