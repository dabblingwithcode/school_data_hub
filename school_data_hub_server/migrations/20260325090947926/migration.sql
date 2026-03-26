BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_communication_data" (
    "id" bigserial PRIMARY KEY,
    "contact" text,
    "communicationPupil" json,
    "specialInformation" text,
    "tutorInfo" json
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "pupil_data" DROP CONSTRAINT "pupil_data_fk_6";
ALTER TABLE "pupil_data" ADD COLUMN "communicationDataId" bigint;
ALTER TABLE "pupil_data" ADD COLUMN "preschoolDataId" bigint;
ALTER TABLE "pupil_data" ADD COLUMN "mediaDataId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_media_data" (
    "id" bigserial PRIMARY KEY,
    "publicMediaAuth" json NOT NULL,
    "avatarId" bigint,
    "avatarAuthId" bigint,
    "publicMediaAuthDocumentId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_preschool_data" (
    "id" bigserial PRIMARY KEY,
    "kindergardenData" json,
    "preSchoolMedicalId" bigint,
    "kindergardenId" bigint,
    "preSchoolTestId" bigint
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_7"
    FOREIGN KEY("preschoolDataId")
    REFERENCES "pupil_preschool_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_8"
    FOREIGN KEY("mediaDataId")
    REFERENCES "pupil_media_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_9"
    FOREIGN KEY("_kindergardenPupilsKindergardenId")
    REFERENCES "kindergarden"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_6"
    FOREIGN KEY("communicationDataId")
    REFERENCES "pupil_communication_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_media_data"
    ADD CONSTRAINT "pupil_media_data_fk_0"
    FOREIGN KEY("avatarId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_media_data"
    ADD CONSTRAINT "pupil_media_data_fk_1"
    FOREIGN KEY("avatarAuthId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_media_data"
    ADD CONSTRAINT "pupil_media_data_fk_2"
    FOREIGN KEY("publicMediaAuthDocumentId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_preschool_data"
    ADD CONSTRAINT "pupil_preschool_data_fk_0"
    FOREIGN KEY("preSchoolMedicalId")
    REFERENCES "pre_school_medical"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_preschool_data"
    ADD CONSTRAINT "pupil_preschool_data_fk_1"
    FOREIGN KEY("kindergardenId")
    REFERENCES "kindergarden"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_preschool_data"
    ADD CONSTRAINT "pupil_preschool_data_fk_2"
    FOREIGN KEY("preSchoolTestId")
    REFERENCES "pre_school_test"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20260325090947926', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260325090947926', "timestamp" = now();

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
