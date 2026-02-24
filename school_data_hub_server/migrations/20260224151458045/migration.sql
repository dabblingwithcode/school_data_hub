BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "competence_report" ADD COLUMN "indicators" json;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20260224151458045', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260224151458045', "timestamp" = now();

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
