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
    "receiverId" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "dateTime" timestamp without time zone NOT NULL,
    "description" text
);

-- Indexes
CREATE INDEX "reciever_idx" ON "credit_transaction" USING btree ("receiverId");
CREATE INDEX "sender_idx" ON "credit_transaction" USING btree ("sender");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "credit_transaction"
    ADD CONSTRAINT "credit_transaction_fk_0"
    FOREIGN KEY("receiverId")
    REFERENCES "pupil_data"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250407230346694', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250407230346694', "timestamp" = now();

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
