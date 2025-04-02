BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "authorization" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "authorizationName" text NOT NULL,
    "authorizationDescription" text NOT NULL,
    "createdBy" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book" (
    "id" bigserial PRIMARY KEY,
    "isbn" bigint NOT NULL,
    "title" text NOT NULL,
    "author" text NOT NULL,
    "description" text NOT NULL,
    "readingLevel" text NOT NULL,
    "imageId" text NOT NULL,
    "imageUrl" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_tag" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_tagging" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "bookTagId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_tagging_index_idx" ON "book_tagging" USING btree ("bookId", "bookTagId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competence" (
    "id" bigserial PRIMARY KEY,
    "publicId" bigint NOT NULL,
    "parentCompetence" bigint,
    "name" text NOT NULL,
    "level" json,
    "indicators" json,
    "order" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competence_check" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "achievement" text NOT NULL,
    "comment" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "valueFactor" double precision NOT NULL,
    "groupCheckId" text NOT NULL,
    "groupCheckName" text NOT NULL,
    "pupilId" bigint NOT NULL,
    "competenceId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competence_check_file" (
    "id" bigserial PRIMARY KEY,
    "fileId" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileExtension" text NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL,
    "uploadedBy" text NOT NULL,
    "competenceCheckId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competence_goal" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "description" text NOT NULL,
    "strategies" json,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text NOT NULL,
    "achievement" text NOT NULL,
    "achievedAt" timestamp without time zone NOT NULL,
    "pupilId" bigint NOT NULL,
    "competenceId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competence_report" (
    "id" bigserial PRIMARY KEY,
    "reportId" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text NOT NULL,
    "achievement" text NOT NULL,
    "achievedAt" timestamp without time zone NOT NULL,
    "pupilId" bigint NOT NULL,
    "schoolSemesterId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competence_report_check" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "achievement" bigint NOT NULL,
    "comment" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "pupilId" bigint NOT NULL,
    "competenceId" bigint NOT NULL,
    "competenceReportId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "library_book" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "available" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "library_book_location" (
    "id" bigserial PRIMARY KEY,
    "location" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "missed_class" (
    "id" bigserial PRIMARY KEY,
    "missedType" bigint NOT NULL,
    "unexcused" boolean NOT NULL,
    "contacted" text NOT NULL,
    "returned" boolean NOT NULL,
    "returnedAt" timestamp without time zone NOT NULL,
    "writtenExcuse" boolean NOT NULL,
    "minutesLate" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "modifiedBy" text NOT NULL,
    "comment" text NOT NULL,
    "schooldayId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_authorization" (
    "id" bigserial PRIMARY KEY,
    "status" boolean,
    "comment" text,
    "createdBy" text,
    "fileId" text,
    "fileUrl" text,
    "authorizationId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_book_lending" (
    "id" bigserial PRIMARY KEY,
    "lendingId" text NOT NULL,
    "status" text NOT NULL,
    "lentAt" timestamp without time zone NOT NULL,
    "lentBy" text NOT NULL,
    "returnedAt" timestamp without time zone NOT NULL,
    "receivedBy" text NOT NULL,
    "pupilId" bigint NOT NULL,
    "libraryBookId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_book_lending_file" (
    "id" bigserial PRIMARY KEY,
    "fileId" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileExtension" text NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL,
    "uploadedBy" text NOT NULL,
    "lendingId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_data" (
    "id" bigserial PRIMARY KEY,
    "internalId" bigint NOT NULL,
    "contact" text,
    "credit" bigint NOT NULL,
    "creditEarned" bigint NOT NULL,
    "ogs" boolean NOT NULL,
    "pickUpTime" text,
    "ogsInfo" text,
    "latestSupportLevel" text NOT NULL,
    "repeater" timestamp without time zone NOT NULL,
    "swimmer" text NOT NULL,
    "communicationPupil" text NOT NULL,
    "pupilDataParentInfo" json,
    "preSchoolRevision" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_list" (
    "id" bigserial PRIMARY KEY,
    "status" boolean,
    "comment" text,
    "entryBy" text,
    "schoolListId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_workbook" (
    "id" bigserial PRIMARY KEY,
    "comment" text NOT NULL,
    "status" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "finishedAt" timestamp without time zone NOT NULL,
    "pupilId" bigint NOT NULL,
    "workbookId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "school_list" (
    "id" bigserial PRIMARY KEY,
    "listId" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "createdBy" text NOT NULL,
    "visibility" text NOT NULL,
    "authorizedUsers" json
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "school_semester" (
    "id" bigserial PRIMARY KEY,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "classConferenceDate" timestamp without time zone NOT NULL,
    "supportConferenceDate" timestamp without time zone NOT NULL,
    "isFirst" boolean NOT NULL,
    "reportConferenceDate" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "schoolday" (
    "id" bigserial PRIMARY KEY,
    "schoolday" timestamp without time zone NOT NULL,
    "schoolSemesterId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "schoolday_event" (
    "id" bigserial PRIMARY KEY,
    "eventId" text NOT NULL,
    "eventType" text NOT NULL,
    "eventReason" text NOT NULL,
    "createdBy" text NOT NULL,
    "processed" boolean NOT NULL,
    "processedBy" text NOT NULL,
    "fileId" text NOT NULL,
    "fileUrl" text NOT NULL,
    "processedFileId" text NOT NULL,
    "processedFileUrl" text NOT NULL,
    "schooldayId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff" (
    "id" bigserial PRIMARY KEY,
    "userInfoId" bigint NOT NULL,
    "name" text NOT NULL,
    "shortName" text NOT NULL,
    "role" text NOT NULL,
    "userId" text NOT NULL,
    "email" text NOT NULL,
    "password" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "parentCategory" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_category_goal" (
    "id" bigserial PRIMARY KEY,
    "goalId" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "achieved" bigint NOT NULL,
    "achievedAt" timestamp without time zone NOT NULL,
    "description" text NOT NULL,
    "strategies" json NOT NULL,
    "pupilId" bigint NOT NULL,
    "supportCategoryId" bigint NOT NULL,
    "_supportCategoryCategorygoalsSupportCategoryId" bigint,
    "_pupilDataSupportgoalsPupilDataId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_category_status" (
    "id" bigserial PRIMARY KEY,
    "statusId" text NOT NULL,
    "status" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "comment" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileId" text NOT NULL,
    "pupilId" bigint NOT NULL,
    "supportCategoryId" bigint NOT NULL,
    "_supportCategoryCategorystatuesSupportCategoryId" bigint,
    "_pupilDataSupportcategorystatusesPupilDataId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_goal_check" (
    "id" bigserial PRIMARY KEY,
    "checkId" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "achieved" bigint NOT NULL,
    "comment" text NOT NULL,
    "supportGoalId" bigint NOT NULL,
    "_supportCategoryGoalGoalchecksSupportCategoryGoalId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_goal_check_file" (
    "id" bigserial PRIMARY KEY,
    "fileId" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "fileUrl" text NOT NULL,
    "supportGoalCheckId" bigint NOT NULL,
    "_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workbook" (
    "id" bigserial PRIMARY KEY,
    "isbn" bigint NOT NULL,
    "name" text NOT NULL,
    "subject" text NOT NULL,
    "level" text NOT NULL,
    "amount" bigint NOT NULL,
    "imageId" text NOT NULL,
    "imageUrl" text NOT NULL,
    "_pupilDataWorkbooksPupilDataId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_tagging"
    ADD CONSTRAINT "book_tagging_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_tagging"
    ADD CONSTRAINT "book_tagging_fk_1"
    FOREIGN KEY("bookTagId")
    REFERENCES "book_tag"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "competence_check"
    ADD CONSTRAINT "competence_check_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "competence_check"
    ADD CONSTRAINT "competence_check_fk_1"
    FOREIGN KEY("competenceId")
    REFERENCES "competence"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "competence_check_file"
    ADD CONSTRAINT "competence_check_file_fk_0"
    FOREIGN KEY("competenceCheckId")
    REFERENCES "competence_check"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "competence_goal"
    ADD CONSTRAINT "competence_goal_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "competence_goal"
    ADD CONSTRAINT "competence_goal_fk_1"
    FOREIGN KEY("competenceId")
    REFERENCES "competence"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "competence_report"
    ADD CONSTRAINT "competence_report_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "competence_report"
    ADD CONSTRAINT "competence_report_fk_1"
    FOREIGN KEY("schoolSemesterId")
    REFERENCES "school_semester"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "competence_report_check"
    ADD CONSTRAINT "competence_report_check_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "competence_report_check"
    ADD CONSTRAINT "competence_report_check_fk_1"
    FOREIGN KEY("competenceId")
    REFERENCES "competence"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "competence_report_check"
    ADD CONSTRAINT "competence_report_check_fk_2"
    FOREIGN KEY("competenceReportId")
    REFERENCES "competence_report"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "library_book"
    ADD CONSTRAINT "library_book_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "library_book"
    ADD CONSTRAINT "library_book_fk_1"
    FOREIGN KEY("locationId")
    REFERENCES "library_book_location"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "missed_class"
    ADD CONSTRAINT "missed_class_fk_0"
    FOREIGN KEY("schooldayId")
    REFERENCES "schoolday"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "missed_class"
    ADD CONSTRAINT "missed_class_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_authorization"
    ADD CONSTRAINT "pupil_authorization_fk_0"
    FOREIGN KEY("authorizationId")
    REFERENCES "authorization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_authorization"
    ADD CONSTRAINT "pupil_authorization_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_book_lending"
    ADD CONSTRAINT "pupil_book_lending_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_book_lending"
    ADD CONSTRAINT "pupil_book_lending_fk_1"
    FOREIGN KEY("libraryBookId")
    REFERENCES "library_book"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_book_lending_file"
    ADD CONSTRAINT "pupil_book_lending_file_fk_0"
    FOREIGN KEY("lendingId")
    REFERENCES "pupil_book_lending"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_list"
    ADD CONSTRAINT "pupil_list_fk_0"
    FOREIGN KEY("schoolListId")
    REFERENCES "school_list"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_list"
    ADD CONSTRAINT "pupil_list_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_workbook"
    ADD CONSTRAINT "pupil_workbook_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_workbook"
    ADD CONSTRAINT "pupil_workbook_fk_1"
    FOREIGN KEY("workbookId")
    REFERENCES "workbook"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "schoolday"
    ADD CONSTRAINT "schoolday_fk_0"
    FOREIGN KEY("schoolSemesterId")
    REFERENCES "school_semester"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "schoolday_event"
    ADD CONSTRAINT "schoolday_event_fk_0"
    FOREIGN KEY("schooldayId")
    REFERENCES "schoolday"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "schoolday_event"
    ADD CONSTRAINT "schoolday_event_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "staff"
    ADD CONSTRAINT "staff_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "support_category_goal"
    ADD CONSTRAINT "support_category_goal_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_goal"
    ADD CONSTRAINT "support_category_goal_fk_1"
    FOREIGN KEY("supportCategoryId")
    REFERENCES "support_category"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_goal"
    ADD CONSTRAINT "support_category_goal_fk_2"
    FOREIGN KEY("_supportCategoryCategorygoalsSupportCategoryId")
    REFERENCES "support_category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_goal"
    ADD CONSTRAINT "support_category_goal_fk_3"
    FOREIGN KEY("_pupilDataSupportgoalsPupilDataId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_1"
    FOREIGN KEY("supportCategoryId")
    REFERENCES "support_category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_2"
    FOREIGN KEY("_supportCategoryCategorystatuesSupportCategoryId")
    REFERENCES "support_category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_3"
    FOREIGN KEY("_pupilDataSupportcategorystatusesPupilDataId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "support_goal_check"
    ADD CONSTRAINT "support_goal_check_fk_0"
    FOREIGN KEY("supportGoalId")
    REFERENCES "support_category_goal"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_goal_check"
    ADD CONSTRAINT "support_goal_check_fk_1"
    FOREIGN KEY("_supportCategoryGoalGoalchecksSupportCategoryGoalId")
    REFERENCES "support_category_goal"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "support_goal_check_file"
    ADD CONSTRAINT "support_goal_check_file_fk_0"
    FOREIGN KEY("supportGoalCheckId")
    REFERENCES "support_goal_check"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_goal_check_file"
    ADD CONSTRAINT "support_goal_check_file_fk_1"
    FOREIGN KEY("_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId")
    REFERENCES "support_goal_check"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workbook"
    ADD CONSTRAINT "workbook_fk_0"
    FOREIGN KEY("_pupilDataWorkbooksPupilDataId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR school_data_hub
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('school_data_hub', '20250402112430273', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250402112430273', "timestamp" = now();

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
