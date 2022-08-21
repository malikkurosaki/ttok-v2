/*
  Warnings:

  - You are about to drop the column `memberUserId` on the `MemberComment` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `MemberComment_memberUserId_fkey` ON `MemberComment`;

-- DropIndex
DROP INDEX `MemberJoin_memberUserId_fkey` ON `MemberJoin`;

-- AlterTable
ALTER TABLE `MemberComment` DROP COLUMN `memberUserId`;
