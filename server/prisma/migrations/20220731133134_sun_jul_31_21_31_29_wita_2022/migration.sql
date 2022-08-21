/*
  Warnings:

  - The primary key for the `Member` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The required column `id` was added to the `Member` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE `MemberComment` DROP FOREIGN KEY `MemberComment_memberUserId_fkey`;

-- DropForeignKey
ALTER TABLE `MemberJoin` DROP FOREIGN KEY `MemberJoin_memberUserId_fkey`;

-- AlterTable
ALTER TABLE `Member` DROP PRIMARY KEY,
    ADD COLUMN `id` VARCHAR(191) NOT NULL,
    MODIFY `userId` VARCHAR(191) NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `MemberComment` ADD COLUMN `memberId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `MemberJoin` ADD COLUMN `memberId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Member` ADD CONSTRAINT `Member_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MemberJoin` ADD CONSTRAINT `MemberJoin_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `Member`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MemberComment` ADD CONSTRAINT `MemberComment_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `Member`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
