/*
  Warnings:

  - You are about to drop the column `memberUserId` on the `MemberJoin` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `MemberComment` ADD COLUMN `roomId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `MemberJoin` DROP COLUMN `memberUserId`,
    ADD COLUMN `roomId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Score` ADD COLUMN `roomId` VARCHAR(191) NULL;
