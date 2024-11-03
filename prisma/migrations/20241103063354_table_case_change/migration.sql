/*
  Warnings:

  - You are about to drop the `Drawing` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SiteUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Drawing" DROP CONSTRAINT "Drawing_userId_fkey";

-- DropTable
DROP TABLE "Drawing";

-- DropTable
DROP TABLE "SiteUser";

-- CreateTable
CREATE TABLE "site_user" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "saltedHash" TEXT NOT NULL,
    "accountCreated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "site_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "drawing" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT NOT NULL,
    "posted" BOOLEAN NOT NULL DEFAULT false,
    "userId" INTEGER NOT NULL,
    "likes" INTEGER NOT NULL DEFAULT 0,
    "dislikes" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "drawing_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "site_user_username_key" ON "site_user"("username");

-- AddForeignKey
ALTER TABLE "drawing" ADD CONSTRAINT "drawing_userId_fkey" FOREIGN KEY ("userId") REFERENCES "site_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
