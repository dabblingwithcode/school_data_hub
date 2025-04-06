BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "staff" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff" (
    "id" bigserial PRIMARY KEY,
    "userInfoId" bigint NOT NULL,
    "role" text NOT NULL,
    "timeUnits" bigint NOT NULL,
    "pupilsAuth" json,
    "credit" bigint NOT NULL,
    "userFlags" json NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "staff"
    ADD CONSTRAINT "staff_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250406191900945', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250406191900945', "timestamp" = now();

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
