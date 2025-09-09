BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "scheduled_lesson" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "scheduled_lesson" (
    "id" bigserial PRIMARY KEY,
    "active" boolean NOT NULL,
    "publicId" text NOT NULL,
    "subjectId" bigint NOT NULL,
    "scheduledAtId" bigint NOT NULL,
    "timetableSlotOrder" bigint NOT NULL,
    "timetableId" bigint NOT NULL,
    "mainTeacherId" bigint NOT NULL,
    "lessonId" text NOT NULL,
    "roomId" bigint NOT NULL,
    "lessonGroupId" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text NOT NULL,
    "modifiedAt" timestamp without time zone NOT NULL,
    "recordtest" json,
    "_roomScheduledlessonsRoomId" bigint
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_0"
    FOREIGN KEY("subjectId")
    REFERENCES "subject"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_1"
    FOREIGN KEY("scheduledAtId")
    REFERENCES "timetable_slot"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_2"
    FOREIGN KEY("timetableId")
    REFERENCES "timetable"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_3"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_4"
    FOREIGN KEY("lessonGroupId")
    REFERENCES "lesson_group"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_5"
    FOREIGN KEY("_roomScheduledlessonsRoomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250830142343148', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250830142343148', "timestamp" = now();

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
