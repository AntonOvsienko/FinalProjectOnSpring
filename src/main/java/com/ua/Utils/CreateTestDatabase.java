package com.ua.Utils;

public class CreateTestDatabase {
    public static final String PATH_DB="-- MySQL Workbench Forward Engineering\n" +
            "\n" +
            "SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;\n" +
            "SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n" +
            "SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Schema mydb\n" +
            "-- -----------------------------------------------------\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Schema mydb\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE SCHEMA IF NOT EXISTS `mydb_test` DEFAULT CHARACTER SET utf8 ;\n" +
            "USE `mydb` ;\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`login_password`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`login_password` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `login` VARCHAR(45) NOT NULL,\n" +
            "  `password` VARCHAR(45) NOT NULL,\n" +
            "  `role` VARCHAR(45) NOT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,\n" +
            "  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 52\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`administrator`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`administrator` (\n" +
            "  `id` INT NOT NULL,\n" +
            "  `login_password_id` INT NOT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `_id_UNIQUE` (`id` ASC) VISIBLE,\n" +
            "  INDEX `fk_Administartor_login_password_idx` (`login_password_id` ASC) VISIBLE,\n" +
            "  CONSTRAINT `fk_Administartor_login_password`\n" +
            "    FOREIGN KEY (`login_password_id`)\n" +
            "    REFERENCES `mydb_test`.`login_password` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE)\n" +
            "ENGINE = InnoDB\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`case_record`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`case_record` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `initial_diagnosis` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `final_diagnosis` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 34\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`doctor`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`doctor` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `name` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `surname` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `login_password_id` INT NOT NULL,\n" +
            "  `department` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `passport` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `telephone` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `_id_UNIQUE` (`id` ASC) VISIBLE,\n" +
            "  UNIQUE INDEX `login_password_id_UNIQUE` (`login_password_id` ASC) VISIBLE,\n" +
            "  UNIQUE INDEX `passport№_UNIQUE` (`passport` ASC) VISIBLE,\n" +
            "  INDEX `fk_Administartor_login_password_idx` (`login_password_id` ASC) VISIBLE,\n" +
            "  CONSTRAINT `fk_Administartor_login_password0`\n" +
            "    FOREIGN KEY (`login_password_id`)\n" +
            "    REFERENCES `mydb_test`.`login_password` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 382\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test.`doctor_appointment`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`doctor_appointment` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `case_record_id` INT NOT NULL,\n" +
            "  `type` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `description` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `complete` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `name_staff_complete` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,\n" +
            "  INDEX `fk_id_case_records_idx` (`case_record_id` ASC) VISIBLE,\n" +
            "  CONSTRAINT `fk_id_case_records`\n" +
            "    FOREIGN KEY (`case_record_id`)\n" +
            "    REFERENCES `mydb_test`.`case_record` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 86\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`nurse`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`nurse` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `name` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `surname` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `login_password_id` INT NOT NULL,\n" +
            "  `passport` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `telephone` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `_id_UNIQUE` (`id` ASC) VISIBLE,\n" +
            "  UNIQUE INDEX `passport№_UNIQUE` (`passport` ASC) VISIBLE,\n" +
            "  INDEX `fk_Administartor_login_password_idx` (`login_password_id` ASC) VISIBLE,\n" +
            "  CONSTRAINT `fk_Administartor_login_password1`\n" +
            "    FOREIGN KEY (`login_password_id`)\n" +
            "    REFERENCES `mydb_test`.`login_password` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 5\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`nurse_has_case_record`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`nurse_has_case_record` (\n" +
            "  `nurse_id` INT NOT NULL,\n" +
            "  `case_record_id` INT NOT NULL,\n" +
            "  PRIMARY KEY (`nurse_id`, `case_record_id`),\n" +
            "  INDEX `fk_nurse_has_case-record_case-record1_idx` (`case_record_id` ASC) VISIBLE,\n" +
            "  INDEX `fk_nurse_has_case-record_nurse1_idx` (`nurse_id` ASC) VISIBLE,\n" +
            "  CONSTRAINT `fk_nurse_has_case-record_case-record1`\n" +
            "    FOREIGN KEY (`case_record_id`)\n" +
            "    REFERENCES `mydb_test`.`case_record` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE,\n" +
            "  CONSTRAINT `fk_nurse_has_case-record_nurse1`\n" +
            "    FOREIGN KEY (`nurse_id`)\n" +
            "    REFERENCES `mydb`.`nurse` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE)\n" +
            "ENGINE = InnoDB\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`patient`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`patient` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `name` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `passport` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `surname` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `telephone` VARCHAR(45) NULL DEFAULT NULL,\n" +
            "  `birthday` DATE NULL DEFAULT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  UNIQUE INDEX `_id_UNIQUE` (`id` ASC) VISIBLE,\n" +
            "  UNIQUE INDEX `passport№_UNIQUE` (`passport` ASC) VISIBLE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 29\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "-- -----------------------------------------------------\n" +
            "-- Table `mydb_test`.`patient_has_case_records`\n" +
            "-- -----------------------------------------------------\n" +
            "CREATE TABLE IF NOT EXISTS `mydb_test`.`patient_has_case_records` (\n" +
            "  `id` INT NOT NULL AUTO_INCREMENT,\n" +
            "  `patient_id` INT NOT NULL,\n" +
            "  `case_record_id` INT NOT NULL,\n" +
            "  `doctor_id` INT NULL DEFAULT NULL,\n" +
            "  PRIMARY KEY (`id`),\n" +
            "  INDEX `fk_patient_has_case-records_doctor1_idx` (`doctor_id` ASC) VISIBLE,\n" +
            "  INDEX `p_patient_idx` (`patient_id` ASC) INVISIBLE,\n" +
            "  INDEX `fk_patient_has_case_records_case_record1_idx` (`case_record_id` ASC) VISIBLE,\n" +
            "  CONSTRAINT `fk_patient_has_case-records_doctor1`\n" +
            "    FOREIGN KEY (`doctor_id`)\n" +
            "    REFERENCES `mydb_test`.`doctor` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE,\n" +
            "  CONSTRAINT `fk_patient_has_case_records_case_record1`\n" +
            "    FOREIGN KEY (`case_record_id`)\n" +
            "    REFERENCES `mydb_test`.`case_record` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE,\n" +
            "  CONSTRAINT `p_patient_idx`\n" +
            "    FOREIGN KEY (`patient_id`)\n" +
            "    REFERENCES `mydb_test`.`patient` (`id`)\n" +
            "    ON DELETE CASCADE\n" +
            "    ON UPDATE CASCADE)\n" +
            "ENGINE = InnoDB\n" +
            "AUTO_INCREMENT = 27\n" +
            "DEFAULT CHARACTER SET = utf8mb3;\n" +
            "\n" +
            "\n" +
            "SET SQL_MODE=@OLD_SQL_MODE;\n" +
            "SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;\n" +
            "SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;\n";
}
