BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "compulsory_room" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "compulsory_room" (
    "id" bigserial PRIMARY KEY,
    "roomId" text NOT NULL,
    "roomType" text NOT NULL
);


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250718151055108', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250718151055108', "timestamp" = now();

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
