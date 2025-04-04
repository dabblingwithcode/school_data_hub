BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "staff" ALTER COLUMN "pupilsAuth" DROP NOT NULL;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250404062342694', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250404062342694', "timestamp" = now();

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
