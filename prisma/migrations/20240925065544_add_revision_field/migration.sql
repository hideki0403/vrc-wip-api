/*
  Warnings:

  - Added the required column `revision` to the `Settings` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Settings" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" TEXT NOT NULL,
    "ipHash" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "config" TEXT NOT NULL
);
INSERT INTO "new_Settings" ("config", "id", "ipHash", "userId") SELECT "config", "id", "ipHash", "userId" FROM "Settings";
DROP TABLE "Settings";
ALTER TABLE "new_Settings" RENAME TO "Settings";
CREATE INDEX "idx_userId" ON "Settings"("userId");
CREATE INDEX "idx_ipHash" ON "Settings"("ipHash");
CREATE UNIQUE INDEX "Settings_userId_ipHash_key" ON "Settings"("userId", "ipHash");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;