CREATE TABLE IF NOT EXISTS `wlabs_tablet_email_accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `citizenid` VARCHAR(64) NOT NULL,
  `email_address` VARCHAR(96) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `display_name` VARCHAR(64) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_email_address` (`email_address`),
  KEY `ix_citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_tablet_email_messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_email` VARCHAR(96) NOT NULL,
  `recipient_email` VARCHAR(96) NOT NULL,
  `subject` VARCHAR(120) NOT NULL DEFAULT '',
  `body` LONGTEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_recipient_email` (`recipient_email`),
  KEY `ix_sender_email` (`sender_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_tablet_email_contacts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `citizenid` VARCHAR(64) NOT NULL,
  `owner_email` VARCHAR(96) NULL,
  `contact_name` VARCHAR(64) NOT NULL,
  `contact_email` VARCHAR(96) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_citizenid_owner_email_contact_email` (`citizenid`, `owner_email`, `contact_email`),
  KEY `ix_citizenid` (`citizenid`),
  KEY `ix_owner_email` (`owner_email`),
  KEY `ix_contact_email` (`contact_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_yap_profiles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `citizenid` VARCHAR(64) NOT NULL,
  `email_address` VARCHAR(96) NOT NULL,
  `yap_username` VARCHAR(32) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `display_name` VARCHAR(64) NOT NULL,
  `profile_pic_url` VARCHAR(512) NOT NULL DEFAULT '',
  `wall_bg_url` VARCHAR(512) NOT NULL DEFAULT '',
  `wall_accent` VARCHAR(16) NOT NULL DEFAULT '#8b5cf6',
  `wall_bio` VARCHAR(500) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_yap_citizenid` (`citizenid`),
  UNIQUE KEY `ux_yap_username` (`yap_username`),
  KEY `ix_yap_email` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_yap_posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `citizenid` VARCHAR(64) NOT NULL,
  `wall_citizenid` VARCHAR(64) NOT NULL,
  `body` VARCHAR(2000) NOT NULL DEFAULT '',
  `media_url` VARCHAR(2048) NULL,
  `media_inline` LONGTEXT NULL,
  `media_mime` VARCHAR(64) NULL,
  `media_json` LONGTEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_yap_posts_author_time` (`citizenid`, `created_at`),
  KEY `ix_yap_posts_wall_time` (`wall_citizenid`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_yap_reactions` (
  `post_id` INT NOT NULL,
  `reactor_citizenid` VARCHAR(64) NOT NULL,
  `value` TINYINT NOT NULL,
  PRIMARY KEY (`post_id`, `reactor_citizenid`),
  KEY `ix_yap_reactions_reactor` (`reactor_citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_yap_comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `citizenid` VARCHAR(64) NOT NULL,
  `parent_comment_id` INT NULL,
  `body` VARCHAR(1000) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_yap_comments_post_time` (`post_id`, `created_at`),
  KEY `ix_yap_comments_parent_time` (`parent_comment_id`, `created_at`),
  KEY `ix_yap_comments_citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wlabs_yap_comment_reactions` (
  `comment_id` INT NOT NULL,
  `reactor_citizenid` VARCHAR(64) NOT NULL,
  `value` TINYINT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`, `reactor_citizenid`),
  KEY `ix_yap_comment_reactions_reactor` (`reactor_citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
