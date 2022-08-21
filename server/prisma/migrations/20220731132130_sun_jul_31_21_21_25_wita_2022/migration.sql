-- CreateTable
CREATE TABLE `MemberComment` (
    `id` VARCHAR(191) NOT NULL,
    `memberUserId` VARCHAR(191) NULL,
    `userId` VARCHAR(191) NULL,
    `comment` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `MemberComment` ADD CONSTRAINT `MemberComment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MemberComment` ADD CONSTRAINT `MemberComment_memberUserId_fkey` FOREIGN KEY (`memberUserId`) REFERENCES `Member`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;
