-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BetterConnexionG1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BetterConnexionG1` ;

-- -----------------------------------------------------
-- Schema BetterConnexionG1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BetterConnexionG1` DEFAULT CHARACTER SET utf8 ;
USE `BetterConnexionG1` ;

-- -----------------------------------------------------
-- Table `BetterConnexionG1`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BetterConnexionG1`.`user` ;

CREATE TABLE IF NOT EXISTS `BetterConnexionG1`.`user` (
  `iduser` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' NOT NULL COMMENT 'sensible à la casse ',
  `thename` VARCHAR(120) NULL,
  `theemail` VARCHAR(150) NOT NULL,
  `useruniqid` VARCHAR(30) NOT NULL,
  `thestatus` TINYINT NULL DEFAULT 0 COMMENT '0 => non validé\n1 => en fonction \n2 => banni',
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `login_UNIQUE` ON `BetterConnexionG1`.`user` (`login` ASC) VISIBLE;

CREATE UNIQUE INDEX `theemail_UNIQUE` ON `BetterConnexionG1`.`user` (`theemail` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BetterConnexionG1`.`news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BetterConnexionG1`.`news` ;

CREATE TABLE IF NOT EXISTS `BetterConnexionG1`.`news` (
  `idnews` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(120) NOT NULL,
  `slug` VARCHAR(121) NOT NULL,
  `content` TEXT NOT NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_published` DATETIME NULL,
  `is_published` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 => attente de validation \n1 => est affiché\n2 => est banni ',
  `user_iduser` INT UNSIGNED NULL,
  PRIMARY KEY (`idnews`),
  CONSTRAINT `fk_news_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `BetterConnexionG1`.`user` (`iduser`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `slug_UNIQUE` ON `BetterConnexionG1`.`news` (`slug` ASC) VISIBLE;

CREATE INDEX `fk_news_user1_idx` ON `BetterConnexionG1`.`news` (`user_iduser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BetterConnexionG1`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BetterConnexionG1`.`category` ;

CREATE TABLE IF NOT EXISTS `BetterConnexionG1`.`category` (
  `idcategory` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `slug` VARCHAR(101) NULL,
  `description` VARCHAR(400) NULL,
  PRIMARY KEY (`idcategory`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `slug_UNIQUE` ON `BetterConnexionG1`.`category` (`slug` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BetterConnexionG1`.`news_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BetterConnexionG1`.`news_has_category` ;

CREATE TABLE IF NOT EXISTS `BetterConnexionG1`.`news_has_category` (
  `news_idnews` INT UNSIGNED NOT NULL,
  `category_idcategory` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`news_idnews`, `category_idcategory`),
  CONSTRAINT `fk_news_has_category_news`
    FOREIGN KEY (`news_idnews`)
    REFERENCES `BetterConnexionG1`.`news` (`idnews`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_news_has_category_category1`
    FOREIGN KEY (`category_idcategory`)
    REFERENCES `BetterConnexionG1`.`category` (`idcategory`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_news_has_category_category1_idx` ON `BetterConnexionG1`.`news_has_category` (`category_idcategory` ASC) VISIBLE;

CREATE INDEX `fk_news_has_category_news_idx` ON `BetterConnexionG1`.`news_has_category` (`news_idnews` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
