BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "pupil_book_lending" ADD COLUMN "borrowerUserId" bigint;
ALTER TABLE "pupil_book_lending" ADD COLUMN "borrowerType" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_book_lending"
    ADD CONSTRAINT "pupil_book_lending_fk_2"
    FOREIGN KEY("borrowerUserId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20260326112818752', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260326112818752', "timestamp" = now();

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
