/*
  Warnings:

  - You are about to drop the column `createdAt` on the `drawing` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `drawing` table. All the data in the column will be lost.
  - You are about to drop the column `accountCreated` on the `site_user` table. All the data in the column will be lost.
  - You are about to drop the column `saltedHash` on the `site_user` table. All the data in the column will be lost.
  - Added the required column `updated_at` to the `drawing` table without a default value. This is not possible if the table is not empty.
  - Added the required column `salted_hash` to the `site_user` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "drawing" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "site_user" DROP COLUMN "accountCreated",
DROP COLUMN "saltedHash",
ADD COLUMN     "account_created" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "salted_hash" TEXT NOT NULL;
