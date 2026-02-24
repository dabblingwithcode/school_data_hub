BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "competence_report" ADD COLUMN "modifiedAt" timestamp without time zone;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "competence_report_check" DROP CONSTRAINT "competence_report_check_fk_1";
ALTER TABLE "competence_report_check" DROP CONSTRAINT "competence_report_check_fk_2";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "competence_report_check"
    ADD CONSTRAINT "competence_report_check_fk_1"
    FOREIGN KEY("competenceId")
    REFERENCES "competence_report_item"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "competence_report_check"
    ADD CONSTRAINT "competence_report_check_fk_2"
    FOREIGN KEY("competenceReportId")
    REFERENCES "competence_report"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20260224105058664', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260224105058664', "timestamp" = now();

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
