-- MySQL Workbench Forward Engineering
DROP DATABASE IF EXISTS spr;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spr` DEFAULT CHARACTER SET utf8 ;
USE `spr` ;

-- -----------------------------------------------------
-- Table `spr`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`rol` (
  `id_rol` INT NOT NULL,
  `nombre_rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`usuario` (
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` VARCHAR(45) NOT NULL,
  `foto` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `rol_id_rol` INT NOT NULL,
  PRIMARY KEY (`cedula`, `rol_id_rol`),
  INDEX `fk_usuario_rol_idx` (`rol_id_rol` ASC),
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`rol_id_rol`)
    REFERENCES `spr`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`categoria_servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`categoria_servicios` (
  `id_categoria` INT NOT NULL,
  `nombre_categoria` VARCHAR(45) NOT NULL,
  `nombre_servicio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`portafolio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`portafolio` (
  `id_portafolio` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagenes` VARCHAR(45) NOT NULL,
  `usuario_cedula` INT NOT NULL,
  PRIMARY KEY (`id_portafolio`, `usuario_cedula`),
  INDEX `fk_portafolio_usuario1_idx` (`usuario_cedula` ASC),
  CONSTRAINT `fk_portafolio_usuario1`
    FOREIGN KEY (`usuario_cedula`)
    REFERENCES `spr`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`reserva` (
  `id_reserva` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` VARCHAR(45) NOT NULL,
  `usuario_cedula` INT NOT NULL,
  `categoria_servicios_id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_reserva`, `usuario_cedula`, `categoria_servicios_id_categoria`),
  INDEX `fk_reserva_usuario1_idx` (`usuario_cedula` ASC),
  INDEX `fk_reserva_categoria_servicios1_idx` (`categoria_servicios_id_categoria` ASC),
  CONSTRAINT `fk_reserva_usuario1`
    FOREIGN KEY (`usuario_cedula`)
    REFERENCES `spr`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_categoria_servicios1`
    FOREIGN KEY (`categoria_servicios_id_categoria`)
    REFERENCES `spr`.`categoria_servicios` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`historial` (
  `id_historial` INT NOT NULL,
  `reserva_id_reserva` INT NOT NULL,
  PRIMARY KEY (`id_historial`, `reserva_id_reserva`),
  INDEX `fk_historial_reserva1_idx` (`reserva_id_reserva` ASC),
  CONSTRAINT `fk_historial_reserva1`
    FOREIGN KEY (`reserva_id_reserva`)
    REFERENCES `spr`.`reserva` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`estado_servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`estado_servicio` (
  `id_estado_servicio` INT NOT NULL,
  `estado_pago` VARCHAR(45) NOT NULL,
  `reporte` VARCHAR(45) NULL,
  `reserva_id_reserva` INT NOT NULL,
  PRIMARY KEY (`id_estado_servicio`, `reserva_id_reserva`),
  INDEX `fk_estado_servicio_reserva1_idx` (`reserva_id_reserva` ASC),
  CONSTRAINT `fk_estado_servicio_reserva1`
    FOREIGN KEY (`reserva_id_reserva`)
    REFERENCES `spr`.`reserva` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`mensajeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`mensajeria` (
  `id_mensaje` INT NOT NULL,
  `mensajes` VARCHAR(45) NULL,
  PRIMARY KEY (`id_mensaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`usuario_has_categoria_servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`usuario_has_categoria_servicios` (
  `usuario_cedula` INT NOT NULL,
  `categoria_servicios_id_categoria` INT NOT NULL,
  PRIMARY KEY (`usuario_cedula`, `categoria_servicios_id_categoria`),
  INDEX `fk_usuario_has_categoria_servicios_categoria_servicios1_idx` (`categoria_servicios_id_categoria` ASC),
  INDEX `fk_usuario_has_categoria_servicios_usuario1_idx` (`usuario_cedula` ASC),
  CONSTRAINT `fk_usuario_has_categoria_servicios_usuario1`
    FOREIGN KEY (`usuario_cedula`)
    REFERENCES `spr`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_categoria_servicios_categoria_servicios1`
    FOREIGN KEY (`categoria_servicios_id_categoria`)
    REFERENCES `spr`.`categoria_servicios` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`mensajes_x_porta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`mensajes_x_porta` (
  `portafolio_id_portafolio` INT NOT NULL,
  `portafolio_usuario_cedula` INT NOT NULL,
  `mensajeria_id_mensaje` INT NOT NULL,
  PRIMARY KEY (`portafolio_id_portafolio`, `portafolio_usuario_cedula`, `mensajeria_id_mensaje`),
  INDEX `fk_portafolio_has_mensajeria_mensajeria1_idx` (`mensajeria_id_mensaje` ASC),
  INDEX `fk_portafolio_has_mensajeria_portafolio1_idx` (`portafolio_id_portafolio` ASC, `portafolio_usuario_cedula` ASC),
  CONSTRAINT `fk_portafolio_has_mensajeria_portafolio1`
    FOREIGN KEY (`portafolio_id_portafolio` , `portafolio_usuario_cedula`)
    REFERENCES `spr`.`portafolio` (`id_portafolio` , `usuario_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_portafolio_has_mensajeria_mensajeria1`
    FOREIGN KEY (`mensajeria_id_mensaje`)
    REFERENCES `spr`.`mensajeria` (`id_mensaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`calificacion` (
  `id_calificacion` INT NOT NULL,
  `calificacion` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_calificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spr`.`usuarios_x_calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spr`.`usuarios_x_calificacion` (
  `usuario_cedula` INT NOT NULL,
  `calificacion_id_calificacion` INT NOT NULL,
  PRIMARY KEY (`usuario_cedula`, `calificacion_id_calificacion`),
  INDEX `fk_usuario_has_calificacion_calificacion1_idx` (`calificacion_id_calificacion` ASC),
  INDEX `fk_usuario_has_calificacion_usuario1_idx` (`usuario_cedula` ASC),
  CONSTRAINT `fk_usuario_has_calificacion_usuario1`
    FOREIGN KEY (`usuario_cedula`)
    REFERENCES `spr`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_calificacion_calificacion1`
    FOREIGN KEY (`calificacion_id_calificacion`)
    REFERENCES `spr`.`calificacion` (`id_calificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
