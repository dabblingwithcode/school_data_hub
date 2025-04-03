BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user_device" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_device" (
    "id" bigserial PRIMARY KEY,
    "userInfoId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "deviceName" text,
    "lastLogin" timestamp without time zone NOT NULL,
    "isActive" boolean NOT NULL,
    "authId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_device_unique_idx" ON "user_device" USING btree ("userInfoId", "deviceId");
CREATE UNIQUE INDEX "auth_key_idx" ON "user_device" USING btree ("authId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_device"
    ADD CONSTRAINT "user_device_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250403211453492', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250403211453492', "timestamp" = now();

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
