CREATE TABLE `users`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` CHAR(255) NOT NULL,
    `password` CHAR(255) NOT NULL,
    `role` VARCHAR(255) NULL,
    `registered_at` TIMESTAMP NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `deleted_at` TIMESTAMP NULL,
    `updated_at` TIMESTAMP NOT NULL
);
ALTER TABLE
    `users` ADD UNIQUE `users_email_unique`(`email`);
CREATE TABLE `posts`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `featured_image` VARCHAR(255) NOT NULL,
    `status` ENUM('') NOT NULL,
    `published_at` TIMESTAMP NOT NULL,
    `keywords` JSON NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NOT NULL
);
ALTER TABLE
    `posts` ADD INDEX `posts_user_id_index`(`user_id`);
CREATE TABLE `comments`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `post_id` BIGINT NOT NULL,
    `name` VARCHAR(255) NULL,
    `message` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `deleted_at` TIMESTAMP NULL,
    `status` ENUM('') NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);
ALTER TABLE
    `comments` ADD INDEX `comments_user_id_index`(`user_id`);
ALTER TABLE
    `comments` ADD INDEX `comments_post_id_index`(`post_id`);
CREATE TABLE `categories`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);
CREATE TABLE `category_post`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_id` INT NOT NULL,
    `post_id` INT NOT NULL
);
ALTER TABLE
    `category_post` ADD INDEX `category_post_category_id_index`(`category_id`);
ALTER TABLE
    `category_post` ADD INDEX `category_post_post_id_index`(`post_id`);
CREATE TABLE `tags`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `deleted_at` TIMESTAMP NULL
);
CREATE TABLE `post_tag`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT NOT NULL,
    `tag_id` INT NOT NULL
);
ALTER TABLE
    `post_tag` ADD INDEX `post_tag_post_id_index`(`post_id`);
ALTER TABLE
    `post_tag` ADD INDEX `post_tag_tag_id_index`(`tag_id`);
CREATE TABLE `subscriptions`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NULL,
    `email` VARCHAR(255) NOT NULL,
    `subscribe_at` INT NOT NULL
);
CREATE TABLE `roles`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL
);
ALTER TABLE
    `roles` ADD INDEX `roles_user_id_index`(`user_id`);
CREATE TABLE `responses`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NULL,
    `user_id` INT NULL,
    `comment_id` INT NOT NULL,
    `reply` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `deleted_at` TIMESTAMP NULL,
    `status` ENUM('') NOT NULL
);
ALTER TABLE
    `responses` ADD INDEX `responses_user_id_index`(`user_id`);
ALTER TABLE
    `responses` ADD INDEX `responses_comment_id_index`(`comment_id`);
ALTER TABLE
    `posts` ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `roles` ADD CONSTRAINT `roles_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `responses` ADD CONSTRAINT `responses_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `posts`(`id`);
ALTER TABLE
    `category_post` ADD CONSTRAINT `category_post_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `posts`(`id`);
ALTER TABLE
    `post_tag` ADD CONSTRAINT `post_tag_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `posts`(`id`);
ALTER TABLE
    `category_post` ADD CONSTRAINT `category_post_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`id`);
ALTER TABLE
    `post_tag` ADD CONSTRAINT `post_tag_tag_id_foreign` FOREIGN KEY(`tag_id`) REFERENCES `tags`(`id`);