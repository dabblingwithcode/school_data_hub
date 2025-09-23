BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "learning_support_plan" ADD COLUMN "number" bigint;
ALTER TABLE "learning_support_plan" ADD COLUMN "socialPedagogue" text;
ALTER TABLE "learning_support_plan" ADD COLUMN "proffesionalsInvolved" text;
ALTER TABLE "learning_support_plan" ADD COLUMN "strengthsDescription" text;
ALTER TABLE "learning_support_plan" ADD COLUMN "problemsDescription" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "pupil_data" ADD COLUMN "password" text;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250917215220208', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250917215220208', "timestamp" = now();

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
