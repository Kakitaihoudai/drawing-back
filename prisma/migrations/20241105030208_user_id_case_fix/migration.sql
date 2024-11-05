/*
  Warnings:

  - You are about to drop the column `userId` on the `drawing` table. All the data in the column will be lost.
  - Added the required column `user_id` to the `drawing` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "drawing" DROP CONSTRAINT "drawing_userId_fkey";

-- AlterTable
ALTER TABLE "drawing" DROP COLUMN "userId",
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "drawing" ADD CONSTRAINT "drawing_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "site_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
