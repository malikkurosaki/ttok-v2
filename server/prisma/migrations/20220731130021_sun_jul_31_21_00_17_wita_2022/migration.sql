-- CreateTable
CREATE TABLE `MemberJoin` (
    `id` VARCHAR(191) NOT NULL,
    `memberUserId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `MemberJoin` ADD CONSTRAINT `MemberJoin_memberUserId_fkey` FOREIGN KEY (`memberUserId`) REFERENCES `Member`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;
