-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema valco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema valco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `valco` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `valco` ;

-- -----------------------------------------------------
-- Table `valco`.`TIPO_PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`TIPO_PRODUCTO` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(100) NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`UNIDADES_DE_MEDIDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`UNIDADES_DE_MEDIDA` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(50) NOT NULL,
  `ABREVIACION` VARCHAR(5) NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `DESCRIPCION_UNIQUE` (`DESCRIPCION` ASC),
  UNIQUE INDEX `ABREVIACION_UNIQUE` (`ABREVIACION` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`PRODUCTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`PRODUCTOS` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(45) NOT NULL,
  `TIPO_PRODUCTO_CODIGO` INT NOT NULL,
  `UNIDADES_DE_MEDIDA_CODIGO` INT NOT NULL,
  `INCLUYE_VICERA` TINYINT(1) NOT NULL,
  `GENERAR_SUBPRODUCTO` TINYINT(1) NOT NULL,
  `APLICA_INVENTARIO_FISICO` TINYINT(1) NOT NULL,
  `ESTATUS` VARCHAR(20) NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `DESCRIPCION_UNIQUE` (`DESCRIPCION` ASC),
  INDEX `fk_PRODUCTOS_TIPO_PRODUCTO1_idx` (`TIPO_PRODUCTO_CODIGO` ASC),
  INDEX `fk_PRODUCTOS_UNIDADES_DE_MEDIDA1_idx` (`UNIDADES_DE_MEDIDA_CODIGO` ASC),
  CONSTRAINT `fk_PRODUCTOS_TIPO_PRODUCTO1`
    FOREIGN KEY (`TIPO_PRODUCTO_CODIGO`)
    REFERENCES `valco`.`TIPO_PRODUCTO` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_UNIDADES_DE_MEDIDA1`
    FOREIGN KEY (`UNIDADES_DE_MEDIDA_CODIGO`)
    REFERENCES `valco`.`UNIDADES_DE_MEDIDA` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`CLIENTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`CLIENTES` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `RAZON_SOCIAL` VARCHAR(200) NOT NULL,
  `APELLIDO_PATERNO` VARCHAR(100) NOT NULL,
  `APELLIDO_MATERNO` VARCHAR(100) NULL,
  `NOMBRES` VARCHAR(100) NOT NULL,
  `DIRECCION` VARCHAR(300) NOT NULL,
  `COLONIA` VARCHAR(100) NULL,
  `NUMERO_INTERIOR` VARCHAR(30) NULL,
  `NUMERO_EXTERIOR` INT NOT NULL,
  `CODIGO_POSTAL` INT NULL,
  `CIUDAD` VARCHAR(100) NOT NULL,
  `ESTADO` VARCHAR(100) NOT NULL,
  `PAIS` VARCHAR(100) NOT NULL,
  `LIMITE_CREDITO` INT NULL,
  `RFC` VARCHAR(50) NULL,
  `CORREO_ELECTRONICO` VARCHAR(200) NULL,
  `INCOBRABLE` TINYINT(1) NULL,
  `FOREANO` TINYINT(1) NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  `CUENTA_BANCARIA` INT NULL,
  `BANCO` VARCHAR(100) NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `RAZON_SOCIAL_UNIQUE` (`RAZON_SOCIAL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`PROVEEDORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`PROVEEDORES` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `RAZON_SOCIAL` VARCHAR(200) NOT NULL,
  `APELLIDO_PATERNO` VARCHAR(100) NOT NULL,
  `APELLIDO_MATERNO` VARCHAR(100) NULL,
  `NOMBRES` VARCHAR(100) NOT NULL,
  `DIRECCION` VARCHAR(300) NOT NULL,
  `CIUDAD` VARCHAR(100) NOT NULL,
  `ESTADO` VARCHAR(100) NOT NULL,
  `CODIGO_POSTAL` INT NULL,
  `RFC` VARCHAR(50) NULL,
  `POSICION_PESO_INICIAL` INT NOT NULL,
  `POSICION_PESO_FINAL` INT NOT NULL,
  `POSICION_CODIGO_INICIAL` INT NOT NULL,
  `POSICION_CODIGO_FINAL` INT NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `RAZON_SOCIAL_UNIQUE` (`RAZON_SOCIAL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`CUENTAS_CONTABLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`CUENTAS_CONTABLES` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `NO_DE_CUENTA` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(100) NOT NULL,
  `ES_BANCO` TINYINT(1) NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `NO_DE_CUENTA_UNIQUE` (`NO_DE_CUENTA` ASC),
  UNIQUE INDEX `DESCRIPCION_UNIQUE` (`DESCRIPCION` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`REPARTIDORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`REPARTIDORES` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `APELLIDO_PATERNO` VARCHAR(100) NOT NULL,
  `APELLIDO_MATERNO` VARCHAR(100) NULL,
  `NOMBRES` VARCHAR(100) NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`PRODUCTOS_has_PROVEEDORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`PRODUCTOS_has_PROVEEDORES` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `PRODUCTOS_CODIGO` INT NOT NULL,
  `PROVEEDORES_CODIGO` INT NOT NULL,
  `CODIGO_PROVEEDOR` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_PRODUCTOS_has_PROVEEDORES_PROVEEDORES1_idx` (`PROVEEDORES_CODIGO` ASC),
  INDEX `fk_PRODUCTOS_has_PROVEEDORES_PRODUCTOS_idx` (`PRODUCTOS_CODIGO` ASC),
  CONSTRAINT `fk_PRODUCTOS_has_PROVEEDORES_PRODUCTOS`
    FOREIGN KEY (`PRODUCTOS_CODIGO`)
    REFERENCES `valco`.`PRODUCTOS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_has_PROVEEDORES_PROVEEDORES1`
    FOREIGN KEY (`PROVEEDORES_CODIGO`)
    REFERENCES `valco`.`PROVEEDORES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`FACTURAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`FACTURAS` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATE NOT NULL,
  `SUBTOTAL` DECIMAL(7,2) NOT NULL,
  `IVA` DECIMAL(7,2) NOT NULL,
  `TOTAL` DECIMAL(7,2) NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`UBICACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`UBICACIONES` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `ESTADO` VARCHAR(45) NOT NULL,
  `CIUDAD` VARCHAR(45) NOT NULL,
  `OFICINA` VARCHAR(45) NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `INDICE UNICO` (`ESTADO` ASC, `CIUDAD` ASC, `OFICINA` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`USUARIOS` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `CORREO` VARCHAR(100) NOT NULL,
  `NOMBRE` VARCHAR(100) NOT NULL,
  `APELLIDO_PATERNO` VARCHAR(100) NOT NULL,
  `APELLIDO_MATERNO` VARCHAR(100) NULL,
  `PASSWORD` VARCHAR(100) NOT NULL,
  `ESTATUS` VARCHAR(20) NULL,
  `UBICACIONES_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `CORREO_UNIQUE` (`CORREO` ASC),
  INDEX `fk_USUARIOS_UBICACIONES1_idx` (`UBICACIONES_CODIGO` ASC),
  CONSTRAINT `fk_USUARIOS_UBICACIONES1`
    FOREIGN KEY (`UBICACIONES_CODIGO`)
    REFERENCES `valco`.`UBICACIONES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`NOTAS_DE_VENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`NOTAS_DE_VENTA` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FOLIO` INT NOT NULL,
  `FECHA_DE_VENTA` DATE NULL,
  `FLETE` INT NULL,
  `ESTATUS` VARCHAR(20) NULL,
  `REPARTIDORES_CODIGO` INT NOT NULL,
  `CLIENTES_CODIGO` INT NOT NULL,
  `FACTURAS_CODIGO` INT NOT NULL,
  `USUARIOS_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `FOLIO_UNIQUE` (`FOLIO` ASC),
  INDEX `fk_NOTAS_DE_VENTA_REPARTIDORES1_idx` (`REPARTIDORES_CODIGO` ASC),
  INDEX `fk_NOTAS_DE_VENTA_CLIENTES1_idx` (`CLIENTES_CODIGO` ASC),
  INDEX `fk_NOTAS_DE_VENTA_FACTURAS1_idx` (`FACTURAS_CODIGO` ASC),
  INDEX `fk_NOTAS_DE_VENTA_USUARIOS1_idx` (`USUARIOS_CODIGO` ASC),
  CONSTRAINT `fk_NOTAS_DE_VENTA_REPARTIDORES1`
    FOREIGN KEY (`REPARTIDORES_CODIGO`)
    REFERENCES `valco`.`REPARTIDORES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOTAS_DE_VENTA_CLIENTES1`
    FOREIGN KEY (`CLIENTES_CODIGO`)
    REFERENCES `valco`.`CLIENTES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOTAS_DE_VENTA_FACTURAS1`
    FOREIGN KEY (`FACTURAS_CODIGO`)
    REFERENCES `valco`.`FACTURAS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOTAS_DE_VENTA_USUARIOS1`
    FOREIGN KEY (`USUARIOS_CODIGO`)
    REFERENCES `valco`.`USUARIOS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`ORDENES_COMPRA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`ORDENES_COMPRA` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATE NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `TOTAL` DECIMAL(7,2) NOT NULL,
  `PROVEEDORES_CODIGO` INT NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  `USUARIOS_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_ORDENES_COMPRA_PROVEEDORES1_idx` (`PROVEEDORES_CODIGO` ASC),
  INDEX `fk_ORDENES_COMPRA_USUARIOS1_idx` (`USUARIOS_CODIGO` ASC),
  CONSTRAINT `fk_ORDENES_COMPRA_PROVEEDORES1`
    FOREIGN KEY (`PROVEEDORES_CODIGO`)
    REFERENCES `valco`.`PROVEEDORES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDENES_COMPRA_USUARIOS1`
    FOREIGN KEY (`USUARIOS_CODIGO`)
    REFERENCES `valco`.`USUARIOS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`TRANFERENCIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`TRANFERENCIAS` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `ESTATUS` VARCHAR(20) NOT NULL,
  `SALIDA` INT NOT NULL,
  `DESTINO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_TRANFERENCIAS_UBICACIONES1_idx` (`SALIDA` ASC),
  INDEX `fk_TRANFERENCIAS_UBICACIONES2_idx` (`DESTINO` ASC),
  CONSTRAINT `fk_TRANFERENCIAS_UBICACIONES1`
    FOREIGN KEY (`SALIDA`)
    REFERENCES `valco`.`UBICACIONES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRANFERENCIAS_UBICACIONES2`
    FOREIGN KEY (`DESTINO`)
    REFERENCES `valco`.`UBICACIONES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`PRODUCTOS_INVENTARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`PRODUCTOS_INVENTARIO` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `PESO` DECIMAL(4,2) NOT NULL,
  `PRECIO` DECIMAL(4,2) NOT NULL,
  `NOTAS_DE_VENTA_CODIGO` INT NOT NULL,
  `PRODUCTOS_has_PROVEEDORES_CODIGO` INT NOT NULL,
  `ORDENES_COMPRA_CODIGO` INT NOT NULL,
  `TRANFERENCIAS_CODIGO` INT NOT NULL,
  `CODIGO_BARRAS` VARCHAR(100) NULL,
  `UBICACIONES_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_PRODUCTOS_INVENTARIO_NOTAS_DE_VENTA1_idx` (`NOTAS_DE_VENTA_CODIGO` ASC),
  INDEX `fk_PRODUCTOS_INVENTARIO_PRODUCTOS_has_PROVEEDORES1_idx` (`PRODUCTOS_has_PROVEEDORES_CODIGO` ASC),
  INDEX `fk_PRODUCTOS_INVENTARIO_ORDENES_COMPRA1_idx` (`ORDENES_COMPRA_CODIGO` ASC),
  INDEX `fk_PRODUCTOS_INVENTARIO_TRANFERENCIAS1_idx` (`TRANFERENCIAS_CODIGO` ASC),
  INDEX `fk_PRODUCTOS_INVENTARIO_UBICACIONES1_idx` (`UBICACIONES_CODIGO` ASC),
  CONSTRAINT `fk_PRODUCTOS_INVENTARIO_NOTAS_DE_VENTA1`
    FOREIGN KEY (`NOTAS_DE_VENTA_CODIGO`)
    REFERENCES `valco`.`NOTAS_DE_VENTA` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_INVENTARIO_PRODUCTOS_has_PROVEEDORES1`
    FOREIGN KEY (`PRODUCTOS_has_PROVEEDORES_CODIGO`)
    REFERENCES `valco`.`PRODUCTOS_has_PROVEEDORES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_INVENTARIO_ORDENES_COMPRA1`
    FOREIGN KEY (`ORDENES_COMPRA_CODIGO`)
    REFERENCES `valco`.`ORDENES_COMPRA` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_INVENTARIO_TRANFERENCIAS1`
    FOREIGN KEY (`TRANFERENCIAS_CODIGO`)
    REFERENCES `valco`.`TRANFERENCIAS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_INVENTARIO_UBICACIONES1`
    FOREIGN KEY (`UBICACIONES_CODIGO`)
    REFERENCES `valco`.`UBICACIONES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`CUENTAS_X_PAGAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`CUENTAS_X_PAGAR` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NOT NULL,
  `IMPORTE` DECIMAL(7,2) NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  `ORDENES_COMPRA_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_CUENTAS_X_PAGAR_ORDENES_COMPRA1_idx` (`ORDENES_COMPRA_CODIGO` ASC),
  UNIQUE INDEX `ORDENES_COMPRA_CODIGO_UNIQUE` (`ORDENES_COMPRA_CODIGO` ASC),
  CONSTRAINT `fk_CUENTAS_X_PAGAR_ORDENES_COMPRA1`
    FOREIGN KEY (`ORDENES_COMPRA_CODIGO`)
    REFERENCES `valco`.`ORDENES_COMPRA` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`ABONOS_CUENTAS_X_PAGAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`ABONOS_CUENTAS_X_PAGAR` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATE NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  `IMPORTE` DECIMAL(7,2) NOT NULL,
  `CUENTAS_X_PAGAR_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_ABONOS_CUENTAS_X_PAGAR_CUENTAS_X_PAGAR1_idx` (`CUENTAS_X_PAGAR_CODIGO` ASC),
  CONSTRAINT `fk_ABONOS_CUENTAS_X_PAGAR_CUENTAS_X_PAGAR1`
    FOREIGN KEY (`CUENTAS_X_PAGAR_CODIGO`)
    REFERENCES `valco`.`CUENTAS_X_PAGAR` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`NOTAS_CREDITO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`NOTAS_CREDITO` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATE NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NULL,
  `CLIENTES_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_NOTAS_CREDITO_CLIENTES1_idx` (`CLIENTES_CODIGO` ASC),
  CONSTRAINT `fk_NOTAS_CREDITO_CLIENTES1`
    FOREIGN KEY (`CLIENTES_CODIGO`)
    REFERENCES `valco`.`CLIENTES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`CUENTAS_X_COBRAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`CUENTAS_X_COBRAR` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NOT NULL,
  `IMPORTE` DECIMAL(7,2) NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NULL,
  `NOTAS_DE_VENTA_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_CUENTAS_X_COBRAR_NOTAS_DE_VENTA1_idx` (`NOTAS_DE_VENTA_CODIGO` ASC),
  UNIQUE INDEX `NOTAS_DE_VENTA_CODIGO_UNIQUE` (`NOTAS_DE_VENTA_CODIGO` ASC),
  CONSTRAINT `fk_CUENTAS_X_COBRAR_NOTAS_DE_VENTA1`
    FOREIGN KEY (`NOTAS_DE_VENTA_CODIGO`)
    REFERENCES `valco`.`NOTAS_DE_VENTA` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`ABONOS_CUENTAS_X_COBRAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`ABONOS_CUENTAS_X_COBRAR` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NOT NULL,
  `IMPORTE` DECIMAL(7,2) NULL,
  `CUENTAS_X_COBRAR_CODIGO` INT NOT NULL,
  `OBSERVACIONES` TEXT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_ABONOS_CUENTAS_X_COBRAR_CUENTAS_X_COBRAR1_idx` (`CUENTAS_X_COBRAR_CODIGO` ASC),
  CONSTRAINT `fk_ABONOS_CUENTAS_X_COBRAR_CUENTAS_X_COBRAR1`
    FOREIGN KEY (`CUENTAS_X_COBRAR_CODIGO`)
    REFERENCES `valco`.`CUENTAS_X_COBRAR` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`PRODUCTOS_has_PRODUCTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`PRODUCTOS_has_PRODUCTOS` (
  `PRODUCTOS_CODIGO_PADRE` INT NOT NULL,
  `PRODUCTOS_CODIGO_HIJO` INT NOT NULL,
  PRIMARY KEY (`PRODUCTOS_CODIGO_PADRE`, `PRODUCTOS_CODIGO_HIJO`),
  INDEX `fk_PRODUCTOS_has_PRODUCTOS_PRODUCTOS2_idx` (`PRODUCTOS_CODIGO_HIJO` ASC),
  INDEX `fk_PRODUCTOS_has_PRODUCTOS_PRODUCTOS1_idx` (`PRODUCTOS_CODIGO_PADRE` ASC),
  CONSTRAINT `fk_PRODUCTOS_has_PRODUCTOS_PRODUCTOS1`
    FOREIGN KEY (`PRODUCTOS_CODIGO_PADRE`)
    REFERENCES `valco`.`PRODUCTOS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_has_PRODUCTOS_PRODUCTOS2`
    FOREIGN KEY (`PRODUCTOS_CODIGO_HIJO`)
    REFERENCES `valco`.`PRODUCTOS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`TELEFONOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`TELEFONOS` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `TIPO` VARCHAR(40) NOT NULL,
  `LADA` INT NOT NULL,
  `NUMERO` INT NOT NULL,
  `CLIENTES_CODIGO` INT NOT NULL,
  `PROVEEDORES_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_TELEFONOS_CLIENTES1_idx` (`CLIENTES_CODIGO` ASC),
  INDEX `fk_TELEFONOS_PROVEEDORES1_idx` (`PROVEEDORES_CODIGO` ASC),
  CONSTRAINT `fk_TELEFONOS_CLIENTES1`
    FOREIGN KEY (`CLIENTES_CODIGO`)
    REFERENCES `valco`.`CLIENTES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TELEFONOS_PROVEEDORES1`
    FOREIGN KEY (`PROVEEDORES_CODIGO`)
    REFERENCES `valco`.`PROVEEDORES` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`MOVIMIENTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`MOVIMIENTOS` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(100) NOT NULL,
  `FECHA` DATE NOT NULL,
  `USUARIOS_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_MOVIMIENTOS_USUARIOS1_idx` (`USUARIOS_CODIGO` ASC),
  CONSTRAINT `fk_MOVIMIENTOS_USUARIOS1`
    FOREIGN KEY (`USUARIOS_CODIGO`)
    REFERENCES `valco`.`USUARIOS` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valco`.`METODOS_PAGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valco`.`METODOS_PAGO` (
  `CODIGO` INT NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(50) NOT NULL,
  `ESTATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CODIGO`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
