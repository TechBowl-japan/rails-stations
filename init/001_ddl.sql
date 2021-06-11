CREATE DATABASE IF NOT EXISTS `app_test`;
CREATE DATABASE IF NOT EXISTS `app_development`;
--  Docker buildで環境を全て揃えたいため、ここで必要なテーブルを作成
CREATE TABLE IF NOT EXISTS `app_development`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(160) NOT NULL COMMENT '映画のタイトル。邦題・洋題は一旦考えなくてOK',
  `year` VARCHAR(45) NULL COMMENT '公開年',
  `description` TEXT NULL COMMENT '映画の説明文',
  `image_url` VARCHAR(150) NULL COMMENT '映画のポスター画像が格納されているURL',
  `is_showing` TINYINT(1) NOT NULL COMMENT '上映中かどうか',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE
);
CREATE TABLE IF NOT EXISTS `app_test`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(160) NOT NULL COMMENT '映画のタイトル。邦題・洋題は一旦考えなくてOK',
  `year` VARCHAR(45) NULL COMMENT '公開年',
  `description` TEXT NULL COMMENT '映画の説明文',
  `image_url` VARCHAR(150) NULL COMMENT '映画のポスター画像が格納されているURL',
  `is_showing` TINYINT(1) NOT NULL COMMENT '上映中かどうか',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE
);