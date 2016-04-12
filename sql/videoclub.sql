SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "-06:00";

CREATE DATABASE IF NOT EXISTS `videoclub` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `videoclub`;

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `cedula` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido1` varchar(255) NOT NULL,
  `apellido2` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `direccion` longtext NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `uqCedula` (`cedula`),
  UNIQUE KEY `uqEmail` (`email`),
  UNIQUE KEY `uqTelefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE `configuracion` (
  `idPar` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `valor` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idPar`),
  UNIQUE KEY `uqNombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `configuracion`
VALUES
(1,'LIMITE_PELICULAS','int','1000','Máximo de películas en el sistema.'),
(2,'COSTO_RENTA','int','1000','Costo de la renta de una película.'),
(3,'MULTA','int','300','El costo de la multa por día extra sin devolver la película.'),
(4,'MAX_PELICULAS_CLIENTE','int','5','Máximo películas que puede tener en renta un cliente.'),
(5,'MAX_DIAS_RENTA','int','8','La cantidad máxima de dias antes de comenzar a cobrarse multa.');

DROP TABLE IF EXISTS `peliculas`;
CREATE TABLE `peliculas` (
  `idPelicula` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `produccion` varchar(255) NOT NULL,
  `ano` int(11) NOT NULL,
  `genero` varchar(255) NOT NULL,
  `duracion` int(11) NOT NULL,
  `sinopsis` longtext NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`idPelicula`),
  UNIQUE KEY `uqTitulo` (`titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE `prestamos` (
  `idPrestamo` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `idPelicula` int(11) NOT NULL,
  `salida` date NOT NULL,
  `devolucion` date NOT NULL,
  `devuelta` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`idPrestamo`),
  KEY `fkClientes` (`idCliente`),
  KEY `fkPeliculas` (`idPelicula`),
  CONSTRAINT `prestamos_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON UPDATE CASCADE,
  CONSTRAINT `prestamos_ibfk_3` FOREIGN KEY (`idPelicula`) REFERENCES `peliculas` (`idPelicula`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;



DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `addCliente`(IN `pcedula` INT, IN `pnombre` VARCHAR(255), IN `papellido1` VARCHAR(255), IN `papellido2` VARCHAR(255), IN `ptelefono` INT, IN `pemail` VARCHAR(255), IN `pdireccion` LONGTEXT)
BEGIN
	INSERT INTO clientes(cedula, nombre, apellido1, apellido2, telefono, email, direccion)
	values (pcedula, pnombre, papellido1, papellido2, ptelefono, pemail, pdireccion);
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `addConfiguracion`(IN `pnombre` VARCHAR(255), IN `pvalor` VARCHAR(255), IN `ptipo` VARCHAR(255), IN `pdescripcion` VARCHAR(255))
BEGIN
    INSERT INTO configuracion(nombre, valor, tipo, descripcion)
    VALUES (pnombre, pvalor, ptipo, pdescripcion);
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `addPelicula`(IN `ptitulo` VARCHAR(255), IN `pdireccion` VARCHAR(255), IN `pproduccion` VARCHAR(255), IN `pano` INT, IN `pgenero` VARCHAR(255), IN `pduracion` INT, IN `psinopsis` LONGTEXT, IN `pcantidad` INT)
BEGIN
	INSERT INTO peliculas(titulo, direccion, produccion, ano, genero, duracion, sinopsis, cantidad)
	VALUES (ptitulo, pdireccion, pproduccion, pano, pgenero, pduracion, psinopsis, pcantidad);
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `addPrestamo`(IN `pidCliente` INT, IN `pidPelicula` INT, IN `psalida` VARCHAR(255), IN `pdevolucion` VARCHAR(255))
BEGIN
	DECLARE puedeRentar INT;
    DECLARE rentasActivasCliente INT;
    DECLARE totalPeliculas INT;
    DECLARE peliculasActivas INT;
    DECLARE maximoPeliculas INT;

    DECLARE resultado INT DEFAULT 0;

    SET puedeRentar = 0;

   	SELECT COUNT(*) INTO rentasActivasCliente
    FROM prestamos
    INNER JOIN clientes ON prestamos.idCliente = clientes.idCliente
    WHERE prestamos.devuelta = 0 AND prestamos.idCliente = pidCliente
    ;

    SELECT COUNT(*) INTO peliculasActivas
    FROM prestamos
    INNER JOIN peliculas ON prestamos.idPelicula = peliculas.idPelicula
    WHERE prestamos.devuelta = 0 AND prestamos.idPelicula = pidPelicula
    ;

    SELECT cantidad INTO totalPeliculas
    FROM peliculas
    WHERE idPelicula = pidPelicula
    ;

    SELECT valor INTO maximoPeliculas
    FROM configuracion
    WHERE nombre = 'MAX_PELICULAS_CLIENTE'
    ;

    IF rentasActivasCliente < maximoPeliculas && (totalPeliculas - peliculasActivas) > 0 THEN
		INSERT INTO prestamos(idCliente, idPelicula, salida, devolucion)
		VALUES (pidCliente, pidPelicula, psalida, pdevolucion);
        SET resultado = 1;
	END IF;
    SELECT resultado AS agregado;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `contarPrestamosCliente`(IN `pidCliente` INT)
BEGIN
	SELECT COUNT(*) AS prestamos
    FROM prestamos
    INNER JOIN clientes ON prestamos.idCliente = clientes.idCliente
    WHERE prestamos.devuelta = 0 AND prestamos.idCliente = pidCliente;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `deleteCliente`(IN `pidCliente` INT)
BEGIN
	DECLARE cantprestamos INT DEFAULT 0;
	SELECT COUNT(*) INTO cantprestamos FROM prestamos
    INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
    WHERE clientes.idCliente = pidCliente AND prestamos.devuelta = 0;

    IF cantprestamos = 0 THEN
    	DELETE FROM prestamos
        WHERE idCliente = pidCliente;

        DELETE FROM clientes
    	WHERE idCliente = pidCliente;
        SELECT 1 AS eliminado;
    ELSE
    	SELECT 0 AS eliminado;
    END IF;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `deletePelicula`(IN `pidPelicula` INT)
BEGIN
	DECLARE cantprestamos INT DEFAULT 0;
	SELECT COUNT(*) INTO cantprestamos FROM prestamos
    INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
    WHERE peliculas.idPelicula = pidPelicula AND prestamos.devuelta = 0;

    IF cantprestamos = 0 THEN
    	DELETE FROM prestamos
        WHERE idPelicula = pidPelicula;

        DELETE FROM peliculas
    	WHERE idPelicula = pidPelicula;
    	SELECT 1 AS eliminado;
    ELSE
    	SELECT 0 AS eliminado;
    END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `esMoroso`(IN `pidCliente` INT)
BEGIN
	DECLARE moras INT DEFAULT 0;
	SELECT COUNT(*)
    INTO moras
    FROM prestamos
    INNER JOIN clientes ON prestamos.idCliente = clientes.idCliente
    WHERE clientes.idCliente = pidCLiente AND CURDATE() > prestamos.devolucion;
	SELECT moras;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `finalizarPrestamo`(IN `pidPrestamo` INT)
BEGIN
	UPDATE prestamos
    SET devuelta = 1
    WHERE idPrestamo = pidPrestamo;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getCliente`(IN `pidCliente` INT)
BEGIN
	SELECT * FROM clientes WHERE idCliente = pidCliente LIMIT 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getClientes`(IN `cant` INT, IN `pag` INT)
BEGIN
	                                    DECLARE minLim INT DEFAULT 0;
    SET cant = ABS(cant);
    SET pag = ABS(pag);

    IF cant = 0 AND pag = 0 THEN
		SELECT * FROM clientes;
	END IF;

    IF cant != 0 AND pag != 0 THEN
		SET minLim = cant*(pag-1);
		SELECT * FROM clientes LIMIT cant OFFSET minLim ;
	END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getClientesMorosos`()
BEGIN
	SELECT * FROM clientes
    INNER JOIN prestamos ON clientes.idCliente = prestamos.idCliente
    WHERE prestamos.devolucion < CURDATE()
    AND devuelta = 0
    GROUP BY clientes.idCliente;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getConfiguracion`(IN `pnombre` VARCHAR(255))
BEGIN
		SELECT valor, tipo, descripcion FROM configuracion
    WHERE nombre = pnombre LIMIT 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getIdFromCedula`(IN `pcedula` INT)
BEGIN
	SELECT idCliente FROM clientes WHERE cedula = pcedula LIMIT 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getNombrePeliclas`()
BEGIN
	SELECT nombre FROM peliculas;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPelicula`(IN `pidPelicula` INT)
BEGIN
	SELECT * FROM peliculas WHERE idPelicula=pidPelicula LIMIT 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPeliculaPorTitulo`(IN `ptitulo` VARCHAR(255))
BEGIN
	SELECT * FROM peliculas WHERE titulo=ptitulo LIMIT 1;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPeliculas`(IN `cant` INT, IN `pag` INT)
BEGIN
	                                    DECLARE minLim INT DEFAULT 0;
    SET cant = ABS(cant);
    SET pag = ABS(pag);

    IF cant = 0 AND pag = 0 THEN
		SELECT * FROM peliculas;
	END IF;

    IF cant != 0 AND pag != 0 THEN
		SET minLim = cant*(pag-1);
		SELECT * FROM peliculas LIMIT cant OFFSET minLim;
	END IF;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPeliculasEnMora`()
BEGIN
	SELECT * FROM peliculas
    INNER JOIN prestamos ON peliculas.idPelicula = prestamos.idPelicula
    WHERE prestamos.devolucion < CURDATE() AND prestamos.devuelta = 0
    GROUP BY peliculas.titulo;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPrestamo`(IN `pidPrestamo` INT)
BEGIN
	SELECT * FROM prestamos WHERE idPrestamo = pidPrestamo LIMIT 1;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPrestamos`()
BEGIN
		SELECT
		prestamos.idPrestamo, prestamos.salida, prestamos.devolucion, prestamos.devuelta,
		clientes.idCliente, clientes.cedula, clientes.nombre, clientes.apellido1,
        clientes.apellido2, clientes.telefono, clientes.email,
		peliculas.idPelicula, peliculas.titulo, peliculas.direccion, peliculas.produccion,
        peliculas.ano
        FROM prestamos

		INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
        INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPrestamosCliente`(IN `pcedula` INT)
BEGIN

    SELECT
	prestamos.idPrestamo, prestamos.idCliente, prestamos.idPelicula,  prestamos.salida, prestamos.devolucion, prestamos.devuelta,
	clientes.cedula, clientes.nombre, clientes.apellido1, clientes.apellido2, clientes.telefono, clientes.email,
	peliculas.titulo, peliculas.direccion, peliculas.produccion, peliculas.ano
    FROM prestamos
    INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
    RIGHT OUTER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
    WHERE clientes.cedula = pcedula;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPrestamosClientePelicula`(IN `pidCliente` INT, `pidPelicula` INT)
BEGIN
	        	SELECT
		prestamos.salida, prestamos.devolucion,
        cliente.cedula, cliente.nombre, cliente.apellido1, cliente.apellido2, cliente.telefono, cliente.email,
        pelicula.titulo, pelicula.direccion, pelicula.produccion, pelicula.ano
    FROM prestamos
    INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
    INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
    WHERE
		peliculas.idPelicula = pidPelicula AND
        prestamos.idCliente = pidCliente AND
        prestamos.devuelto = 1
	ORDER BY salida DESC;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPrestamosConMora`()
BEGIN
	SELECT
	prestamos.idPrestamo, prestamos.salida, prestamos.devolucion, prestamos.devuelta,
	clientes.idCliente, clientes.cedula, clientes.nombre, clientes.apellido1, clientes.apellido2, clientes.telefono, clientes.email,
	peliculas.idPelicula, peliculas.titulo, peliculas.direccion, peliculas.produccion, peliculas.ano
	FROM prestamos
	INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
	INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
	WHERE devuelta = 0 AND prestamos.devolucion < CURDATE();
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `getPrestamosPelicula`(IN `ptitulo` VARCHAR(255))
BEGIN

	DECLARE pidPelicula INT;
    SELECT idPelicula INTO pidPelicula FROM peliculas WHERE titulo = ptitulo LIMIT 1 ;

	SELECT * FROM prestamos
	INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
    WHERE prestamos.idPelicula = pidPelicula AND prestamos.devuelta = 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `reactivarPrestamo`(IN `pidPrestamo` INT)
BEGIN
	UPDATE prestamos
    SET devuelta = 0
    WHERE idPrestamo = pidPrestamo;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `updateCliente`(IN `pidCliente` INT, IN `pcedula` INT, IN `pnombre` VARCHAR(255), IN `papellido1` VARCHAR(255), IN `papellido2` VARCHAR(255), IN `ptelefono` INT, IN `pemail` VARCHAR(255), IN `pdireccion` LONGTEXT)
BEGIN
	UPDATE clientes
	SET
		cedula = pcedula,
        nombre = pnombre,
        apellido1 = papellido1,
        apellido2 = papellido2,
        telefono = ptelefono,
        email = pemail,
        direccion = pdireccion
	WHERE idCliente = pidCliente;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `updateConfiguracion`(IN `pnombre` VARCHAR(255), IN `pvalor` VARCHAR(255), IN `ptipo` VARCHAR(255), IN `pdescripcion` VARCHAR(255))
BEGIN
	UPDATE configuracion
	SET
        valor = pvalor,
        tipo = ptipo,
        descripcion = pdescripcion
	WHERE nombre = pnombre;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`emilio`@`%` PROCEDURE `updatePelicula`(IN `pidPelicula` INT, IN `ptitulo` VARCHAR(255), IN `pdireccion` VARCHAR(255), IN `pproduccion` VARCHAR(255), IN `pano` INT, IN `pgenero` VARCHAR(255), IN `pduracion` INT, IN `psinopsis` LONGTEXT, IN `pcantidad` INT)
BEGIN
	UPDATE peliculas
	SET
		idPelicula = pidPelicula,
		titulo = ptitulo,
		direccion = pdireccion,
		produccion = pproduccion,
		ano = pano,
		genero = pgenero,
		duracion = pduracion,
		sinopsis = psinopsis,
		cantidad = pcantidad
	WHERE idPelicula = pidPelicula;
END ;;
DELIMITER ;
