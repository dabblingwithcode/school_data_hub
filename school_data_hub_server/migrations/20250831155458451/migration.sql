BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "lesson_group" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson_group" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "name" text NOT NULL,
    "color" text,
    "timetableId" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text,
    "modifiedAt" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "lesson_group"
    ADD CONSTRAINT "lesson_group_fk_0"
    FOREIGN KEY("timetableId")
    REFERENCES "timetable"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250831155458451', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250831155458451', "timestamp" = now();

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
