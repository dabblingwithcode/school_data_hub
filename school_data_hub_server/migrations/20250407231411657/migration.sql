BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "credit_transaction" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "credit_transaction" (
    "id" bigserial PRIMARY KEY,
    "sender" text NOT NULL,
    "receiver" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "dateTime" timestamp without time zone NOT NULL,
    "description" text
);

-- Indexes
CREATE INDEX "reciever_idx" ON "credit_transaction" USING btree ("receiver");
CREATE INDEX "sender_idx" ON "credit_transaction" USING btree ("sender");


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250407231411657', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250407231411657', "timestamp" = now();

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
