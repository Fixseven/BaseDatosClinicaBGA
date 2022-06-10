-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ClinicaBGA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ClinicaBGA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ClinicaBGA` DEFAULT CHARACTER SET utf8 ;
USE `ClinicaBGA` ;

-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Paciente` (
  `DocumentoDeIdentidad` INT NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Contacto emergencia` VARCHAR(45) NOT NULL,
  `Telefono emergencia` INT NOT NULL,
  PRIMARY KEY (`DocumentoDeIdentidad`),
  UNIQUE INDEX `DocumentoDeIdentidad_UNIQUE` (`DocumentoDeIdentidad` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Servicios` (
  `Codigo servicio` INT NOT NULL AUTO_INCREMENT,
  `Descripcion Servicio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo servicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Citas` (
  `Codigo cita` INT NOT NULL AUTO_INCREMENT,
  `Dia` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `Asistencia` VARCHAR(2) NOT NULL,
  `Paciente_DocumentoDeIdentidad` INT NOT NULL,
  `Servicios_Codigo servicio` INT NOT NULL,
  PRIMARY KEY (`Codigo cita`, `Servicios_Codigo servicio`),
  INDEX `fk_Citas_Paciente_idx` (`Paciente_DocumentoDeIdentidad` ASC) VISIBLE,
  INDEX `fk_Citas_Servicios1_idx` (`Servicios_Codigo servicio` ASC) VISIBLE,
  CONSTRAINT `fk_Citas_Paciente`
    FOREIGN KEY (`Paciente_DocumentoDeIdentidad`)
    REFERENCES `ClinicaBGA`.`Paciente` (`DocumentoDeIdentidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Servicios1`
    FOREIGN KEY (`Servicios_Codigo servicio`)
    REFERENCES `ClinicaBGA`.`Servicios` (`Codigo servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Historia Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Historia Clinica` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Peso` INT NOT NULL,
  `Estatura` INT NOT NULL,
  `Presion` INT NOT NULL,
  `Sintomas` VARCHAR(1000) NOT NULL,
  `Tratamiento` VARCHAR(1000) NOT NULL,
  `Paciente_DocumentoDeIdentidad` INT NOT NULL,
  PRIMARY KEY (`Codigo`, `Paciente_DocumentoDeIdentidad`),
  INDEX `fk_Historia Clinica_Paciente1_idx` (`Paciente_DocumentoDeIdentidad` ASC) VISIBLE,
  CONSTRAINT `fk_Historia Clinica_Paciente1`
    FOREIGN KEY (`Paciente_DocumentoDeIdentidad`)
    REFERENCES `ClinicaBGA`.`Paciente` (`DocumentoDeIdentidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Cobros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Cobros` (
  `Numero` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `valor` INT NOT NULL DEFAULT 0,
  `observaciones` VARCHAR(45) NOT NULL,
  `Paciente_DocumentoDeIdentidad` INT NOT NULL,
  `Servicios_Codigo servicio` INT NOT NULL,
  PRIMARY KEY (`Numero`, `Paciente_DocumentoDeIdentidad`, `Servicios_Codigo servicio`),
  UNIQUE INDEX `Numero_UNIQUE` (`Numero` ASC) VISIBLE,
  INDEX `fk_Cobros_Paciente1_idx` (`Paciente_DocumentoDeIdentidad` ASC) VISIBLE,
  INDEX `fk_Cobros_Servicios1_idx` (`Servicios_Codigo servicio` ASC) VISIBLE,
  CONSTRAINT `fk_Cobros_Paciente1`
    FOREIGN KEY (`Paciente_DocumentoDeIdentidad`)
    REFERENCES `ClinicaBGA`.`Paciente` (`DocumentoDeIdentidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cobros_Servicios1`
    FOREIGN KEY (`Servicios_Codigo servicio`)
    REFERENCES `ClinicaBGA`.`Servicios` (`Codigo servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Medicos` (
  `Codigo medico` INT NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Especialidad` VARCHAR(45) NOT NULL,
  `Tarjeta profesional` INT NULL,
  PRIMARY KEY (`Codigo medico`),
  UNIQUE INDEX `DocumentoDeIdentidad_UNIQUE` (`Codigo medico` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Medicos_has_Historia Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Medicos_has_Historia Clinica` (
  `Medicos_Codigo medico` INT NOT NULL,
  `Historia Clinica_Codigo` INT NOT NULL,
  PRIMARY KEY (`Medicos_Codigo medico`, `Historia Clinica_Codigo`),
  INDEX `fk_Medicos_has_Historia Clinica_Historia Clinica1_idx` (`Historia Clinica_Codigo` ASC) VISIBLE,
  INDEX `fk_Medicos_has_Historia Clinica_Medicos1_idx` (`Medicos_Codigo medico` ASC) VISIBLE,
  CONSTRAINT `fk_Medicos_has_Historia Clinica_Medicos1`
    FOREIGN KEY (`Medicos_Codigo medico`)
    REFERENCES `ClinicaBGA`.`Medicos` (`Codigo medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medicos_has_Historia Clinica_Historia Clinica1`
    FOREIGN KEY (`Historia Clinica_Codigo`)
    REFERENCES `ClinicaBGA`.`Historia Clinica` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBGA`.`Servicios_has_Medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBGA`.`Servicios_has_Medicos` (
  `Servicios_Codigo servicio` INT NOT NULL,
  `Medicos_Codigo medico` INT NOT NULL,
  PRIMARY KEY (`Servicios_Codigo servicio`, `Medicos_Codigo medico`),
  INDEX `fk_Servicios_has_Medicos_Medicos1_idx` (`Medicos_Codigo medico` ASC) VISIBLE,
  INDEX `fk_Servicios_has_Medicos_Servicios1_idx` (`Servicios_Codigo servicio` ASC) VISIBLE,
  CONSTRAINT `fk_Servicios_has_Medicos_Servicios1`
    FOREIGN KEY (`Servicios_Codigo servicio`)
    REFERENCES `ClinicaBGA`.`Servicios` (`Codigo servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servicios_has_Medicos_Medicos1`
    FOREIGN KEY (`Medicos_Codigo medico`)
    REFERENCES `ClinicaBGA`.`Medicos` (`Codigo medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
