-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-04-2022 a las 06:15:36
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `crud_delphi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cabeza_factura`
--

CREATE TABLE `cabeza_factura` (
  `NUMERO` varchar(20) NOT NULL,
  `FECHA` date NOT NULL,
  `CLIENTE` varchar(20) NOT NULL,
  `TOTAL` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `CLIENTE` varchar(20) NOT NULL,
  `NOMBRE_CLIENTE` varchar(100) NOT NULL,
  `DIRECCION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura`
--

CREATE TABLE `detalle_factura` (
  `NUMERO` varchar(20) NOT NULL,
  `PRODUCTO` varchar(20) NOT NULL,
  `CANTIDAD` varchar(20) NOT NULL,
  `VALOR` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `PRODUCTO` varchar(20) NOT NULL,
  `NOMBRE_PRODUCTO` varchar(50) NOT NULL,
  `VALOR` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cabeza_factura`
--
ALTER TABLE `cabeza_factura`
  ADD KEY `CLIENTE` (`CLIENTE`),
  ADD KEY `NUMERO` (`NUMERO`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`CLIENTE`),
  ADD UNIQUE KEY `CLIENTE` (`CLIENTE`);

--
-- Indices de la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD KEY `NUMERO` (`NUMERO`),
  ADD KEY `PRODUCTO` (`PRODUCTO`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`PRODUCTO`),
  ADD KEY `PRODUCTO` (`PRODUCTO`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cabeza_factura`
--
ALTER TABLE `cabeza_factura`
  ADD CONSTRAINT `cabeza_factura_ibfk_1` FOREIGN KEY (`CLIENTE`) REFERENCES `clientes` (`CLIENTE`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cabeza_factura_ibfk_2` FOREIGN KEY (`NUMERO`) REFERENCES `detalle_factura` (`NUMERO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD CONSTRAINT `detalle_factura_ibfk_1` FOREIGN KEY (`PRODUCTO`) REFERENCES `productos` (`PRODUCTO`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
