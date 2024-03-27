-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `library` ;

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8 ;
USE `library` ;

-- -----------------------------------------------------
-- Table `library`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`subject` ;

CREATE TABLE IF NOT EXISTS `library`.`subject` (
  `subject_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject_name` VARCHAR(45) NOT NULL,
  `subject_code` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`subject_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`common_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`common_lookup` ;

CREATE TABLE IF NOT EXISTS `library`.`common_lookup` (
  `common_lookup_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`common_lookup_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`member` ;

CREATE TABLE IF NOT EXISTS `library`.`member` (
  `member_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_fname` VARCHAR(45) NOT NULL,
  `member_mname` VARCHAR(45) NULL,
  `member_lname` VARCHAR(45) NOT NULL,
  `member_dob` DATE NOT NULL,
  `member_membership_id` VARCHAR(11) NOT NULL,
  `common_lookup_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk1_member_common_lookup_idx` (`common_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk1_member_common_lookup`
    FOREIGN KEY (`common_lookup_id`)
    REFERENCES `library`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`reservation` ;

CREATE TABLE IF NOT EXISTS `library`.`reservation` (
  `reservation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` INT UNSIGNED NOT NULL,
  `reservation_start` DATE NOT NULL,
  `reservation_end` DATE NOT NULL,
  PRIMARY KEY (`reservation_id`),
  INDEX `fk_reservation_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk1_reservation_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `library`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`continent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`continent` ;

CREATE TABLE IF NOT EXISTS `library`.`continent` (
  `continent_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `continent_name` VARCHAR(15) NOT NULL,
  `continent_code` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`continent_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`country` ;

CREATE TABLE IF NOT EXISTS `library`.`country` (
  `country_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `continent_continent_id` INT UNSIGNED NOT NULL,
  `country_name` VARCHAR(56) NOT NULL,
  `country_code` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `fk_country_continent1_idx` (`continent_continent_id` ASC) VISIBLE,
  CONSTRAINT `fk1_country_continent`
    FOREIGN KEY (`continent_continent_id`)
    REFERENCES `library`.`continent` (`continent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`lang`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`lang` ;

CREATE TABLE IF NOT EXISTS `library`.`lang` (
  `lang_id` CHAR(2) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  `display_language` CHAR(2) NOT NULL,
  `display` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lang_id`),
  INDEX `fk1_lang_idx` (`display_language` ASC) VISIBLE,
  CONSTRAINT `fk1_lang`
    FOREIGN KEY (`display_language`)
    REFERENCES `library`.`lang` (`lang_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book` ;

CREATE TABLE IF NOT EXISTS `library`.`book` (
  `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject_id` INT UNSIGNED NOT NULL,
  `member_id` INT UNSIGNED NULL,
  `reservation_id` INT UNSIGNED NULL,
  `country_id` INT UNSIGNED NOT NULL,
  `book_title` VARCHAR(100) NOT NULL,
  `book_isbn` INT UNSIGNED NULL,
  `book_isbn_new` BIGINT(13) UNSIGNED NULL,
  `lang_lang_id` CHAR(2) NOT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_book_subject1_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_book_member1_idx` (`member_id` ASC) VISIBLE,
  INDEX `fk_book_reservation1_idx` (`reservation_id` ASC) VISIBLE,
  INDEX `fk_book_country1_idx` (`country_id` ASC) VISIBLE,
  UNIQUE INDEX `uk_book_isbn` (`book_isbn` ASC, `book_isbn_new` ASC) VISIBLE,
  UNIQUE INDEX `uk_book_isbn_new` (`book_isbn_new` ASC, `book_isbn` ASC) VISIBLE,
  INDEX `fk_book_lang1_idx` (`lang_lang_id` ASC) VISIBLE,
  CONSTRAINT `fk1_book_subject`
    FOREIGN KEY (`subject_id`)
    REFERENCES `library`.`subject` (`subject_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2_book_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `library`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk3_book_reservation`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `library`.`reservation` (`reservation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk4_book_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `library`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_lang1`
    FOREIGN KEY (`lang_lang_id`)
    REFERENCES `library`.`lang` (`lang_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`author` ;

CREATE TABLE IF NOT EXISTS `library`.`author` (
  `author_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` INT UNSIGNED NOT NULL,
  `author_fname` VARCHAR(45) NOT NULL,
  `author_mname` VARCHAR(45) NULL,
  `author_lname` VARCHAR(45) NOT NULL,
  `author_dob` DATE NOT NULL,
  `author_dod` DATE NULL,
  PRIMARY KEY (`author_id`),
  INDEX `fk_author_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk1_author_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `library`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`genre` ;

CREATE TABLE IF NOT EXISTS `library`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`publisher` ;

CREATE TABLE IF NOT EXISTS `library`.`publisher` (
  `publisher_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `publisher_name` VARCHAR(100) NOT NULL,
  `publisher_codename` VARCHAR(8) NOT NULL,
  `country_id` INT UNSIGNED NOT NULL,
  `publisher_contact` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`publisher_id`),
  INDEX `fk_publisher_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk1_publisher_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `library`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_author` ;

CREATE TABLE IF NOT EXISTS `library`.`book_author` (
  `book_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `author_id`),
  INDEX `fk_book_author_author1_idx` (`author_id` ASC) VISIBLE,
  INDEX `fk_book_author_book_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk1_book_author_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2_book_author_author`
    FOREIGN KEY (`author_id`)
    REFERENCES `library`.`author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_publisher` ;

CREATE TABLE IF NOT EXISTS `library`.`book_publisher` (
  `book_id` INT UNSIGNED NOT NULL,
  `publisher_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `publisher_id`),
  INDEX `fk_book_publisher_publisher1_idx` (`publisher_id` ASC) VISIBLE,
  INDEX `fk_book_publisher_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk1_book_publisher_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2_book_publisher_publisher`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `library`.`publisher` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_genre` ;

CREATE TABLE IF NOT EXISTS `library`.`book_genre` (
  `book_id` INT UNSIGNED NOT NULL,
  `genre_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `genre_id`),
  INDEX `fk_book_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_book_genre_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk1_book_genre_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2_book_genre_genre`
    FOREIGN KEY (`genre_id`)
    REFERENCES `library`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
