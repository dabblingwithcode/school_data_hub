BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "lesson_attendance" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "lesson" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "lesson_subject" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "subjectId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson_attendance" (
    "id" bigserial PRIMARY KEY,
    "lessonId" bigint NOT NULL,
    "pupilId" bigint NOT NULL,
    "comment" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text NOT NULL,
    "modifiedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson_teacher" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "scheduledLessonId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "lesson_teacher_unique_idx" ON "lesson_teacher" USING btree ("userId", "scheduledLessonId");

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
-- ACTION CREATE TABLE
--
CREATE TABLE "scheduled_lesson_teacher" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "scheduledLessonId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "scheduled_lesson_teacher_unique_idx" ON "scheduled_lesson_teacher" USING btree ("userId", "scheduledLessonId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "timetable" (
    "id" bigserial PRIMARY KEY,
    "active" boolean NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone,
    "name" text NOT NULL,
    "schoolSemesterId" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modified" json
);

-- Indexes
CREATE INDEX "timetable_school_semester_idx" ON "timetable" USING btree ("schoolSemesterId");

--
-- ACTION DROP TABLE
--
DROP TABLE "timetable_slot" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "timetable_slot" (
    "id" bigserial PRIMARY KEY,
    "day" text NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL,
    "timetableId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "lesson"
    ADD CONSTRAINT "lesson_fk_0"
    FOREIGN KEY("subjectId")
    REFERENCES "subject"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "lesson_attendance"
    ADD CONSTRAINT "lesson_attendance_fk_0"
    FOREIGN KEY("lessonId")
    REFERENCES "lesson"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "lesson_attendance"
    ADD CONSTRAINT "lesson_attendance_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "lesson_teacher"
    ADD CONSTRAINT "lesson_teacher_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "lesson_teacher"
    ADD CONSTRAINT "lesson_teacher_fk_1"
    FOREIGN KEY("scheduledLessonId")
    REFERENCES "lesson"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "scheduled_lesson_teacher"
    ADD CONSTRAINT "scheduled_lesson_teacher_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson_teacher"
    ADD CONSTRAINT "scheduled_lesson_teacher_fk_1"
    FOREIGN KEY("scheduledLessonId")
    REFERENCES "scheduled_lesson"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "timetable"
    ADD CONSTRAINT "timetable_fk_0"
    FOREIGN KEY("schoolSemesterId")
    REFERENCES "school_semester"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "timetable_slot"
    ADD CONSTRAINT "timetable_slot_fk_0"
    FOREIGN KEY("timetableId")
    REFERENCES "timetable"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250830111902468', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250830111902468', "timestamp" = now();

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
