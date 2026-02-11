BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "competence_goal" ALTER COLUMN "modifiedBy" DROP NOT NULL;
ALTER TABLE "competence_goal" ALTER COLUMN "achievedAt" DROP NOT NULL;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20260211145535274', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260211145535274', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
