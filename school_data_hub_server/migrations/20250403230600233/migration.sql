BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "user_device_unique_idx";
DROP INDEX "auth_key_idx";
CREATE UNIQUE INDEX "auth_key_user_device_idx" ON "user_device" USING btree ("authId");
ALTER TABLE ONLY "user_device"
    ADD CONSTRAINT "user_device_fk_1"
    FOREIGN KEY("authId")
    REFERENCES "serverpod_auth_key"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250403230600233', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250403230600233', "timestamp" = now();

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
