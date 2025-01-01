CREATE TABLE IF NOT EXISTS dispatch_bolos (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `type` bit(1) NOT NULL DEFAULT 0,
    `target` varchar(63) NOT NULL,
    `description` varchar(255),
    `priority` tinyint(1) NOT NULL DEFAULT 0,
    `active` bit(1) DEFAULT 1,
    PRIMARY KEY (`id`),
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
