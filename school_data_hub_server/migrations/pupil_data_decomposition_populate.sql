-- PupilData Decomposition: Phase 1 Data Population
-- Run this AFTER 'make migration' creates the sub-model tables.
-- This copies data from pupil_data legacy fields into the new domain tables,
-- then sets the FK columns on pupil_data to point to the new rows.
-- Safe to run multiple times (skips pupils that already have sub-model rows).

-- 1. Populate pupil_communication_data and link back to pupil_data
DO $$
DECLARE
  pd RECORD;
  new_id INT;
BEGIN
  FOR pd IN
    SELECT "id", "contact", "communicationPupil", "specialInformation", "tutorInfo"
    FROM pupil_data
    WHERE "communicationDataId" IS NULL
  LOOP
    INSERT INTO pupil_communication_data ("contact", "communicationPupil", "specialInformation", "tutorInfo")
    VALUES (pd."contact", pd."communicationPupil", pd."specialInformation", pd."tutorInfo")
    RETURNING "id" INTO new_id;

    UPDATE pupil_data SET "communicationDataId" = new_id WHERE "id" = pd."id";
  END LOOP;
END $$;

-- 2. Populate pupil_preschool_data and link back to pupil_data
DO $$
DECLARE
  pd RECORD;
  new_id INT;
BEGIN
  FOR pd IN
    SELECT "id", "kindergardenData", "preSchoolMedicalId", "kindergardenId", "preSchoolTestId"
    FROM pupil_data
    WHERE "preschoolDataId" IS NULL
  LOOP
    INSERT INTO pupil_preschool_data ("kindergardenData", "preSchoolMedicalId", "kindergardenId", "preSchoolTestId")
    VALUES (pd."kindergardenData", pd."preSchoolMedicalId", pd."kindergardenId", pd."preSchoolTestId")
    RETURNING "id" INTO new_id;

    UPDATE pupil_data SET "preschoolDataId" = new_id WHERE "id" = pd."id";
  END LOOP;
END $$;

-- 3. Populate pupil_media_data and link back to pupil_data
DO $$
DECLARE
  pd RECORD;
  new_id INT;
BEGIN
  FOR pd IN
    SELECT "id", "publicMediaAuth", "avatarId", "avatarAuthId", "publicMediaAuthDocumentId"
    FROM pupil_data
    WHERE "mediaDataId" IS NULL
  LOOP
    INSERT INTO pupil_media_data ("publicMediaAuth", "avatarId", "avatarAuthId", "publicMediaAuthDocumentId")
    VALUES (pd."publicMediaAuth", pd."avatarId", pd."avatarAuthId", pd."publicMediaAuthDocumentId")
    RETURNING "id" INTO new_id;

    UPDATE pupil_data SET "mediaDataId" = new_id WHERE "id" = pd."id";
  END LOOP;
END $$;

-- Verify population
SELECT 'pupil_data' AS "table", COUNT(*) AS "total",
       COUNT("communicationDataId") AS "with_comm",
       COUNT("preschoolDataId") AS "with_pre",
       COUNT("mediaDataId") AS "with_media"
FROM pupil_data;
