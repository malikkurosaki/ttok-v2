-- AlterTable
ALTER TABLE `MemberJoin` ADD COLUMN `userId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Score` ADD COLUMN `userId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `MemberJoin` ADD CONSTRAINT `MemberJoin_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Score` ADD CONSTRAINT `Score_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
