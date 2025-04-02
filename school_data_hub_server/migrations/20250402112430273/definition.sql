BEGIN;

--
-- Class Authorization as table authorization
--
CREATE TABLE "authorization" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "authorizationName" text NOT NULL,
    "authorizationDescription" text NOT NULL,
    "createdBy" text NOT NULL
);

--
-- Class Book as table book
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
-- Class BookTag as table book_tag
--
CREATE TABLE "book_tag" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

--
-- Class BookTagging as table book_tagging
--
CREATE TABLE "book_tagging" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "bookTagId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_tagging_index_idx" ON "book_tagging" USING btree ("bookId", "bookTagId");

--
-- Class Competence as table competence
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
-- Class CompetenceCheck as table competence_check
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
-- Class CompetenceCheckFile as table competence_check_file
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
-- Class CompetenceGoal as table competence_goal
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
-- Class CompetenceReport as table competence_report
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
-- Class CompetenceReportCheck as table competence_report_check
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
-- Class LibraryBook as table library_book
--
CREATE TABLE "library_book" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "available" boolean NOT NULL
);

--
-- Class LibraryBookLocation as table library_book_location
--
CREATE TABLE "library_book_location" (
    "id" bigserial PRIMARY KEY,
    "location" text NOT NULL
);

--
-- Class MissedClass as table missed_class
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
-- Class PupilAuthorization as table pupil_authorization
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
-- Class PupilBookLending as table pupil_book_lending
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
-- Class PupilBookLendingFile as table pupil_book_lending_file
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
-- Class PupilData as table pupil_data
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
-- Class PupilList as table pupil_list
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
-- Class PupilWorkbook as table pupil_workbook
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
-- Class SchoolList as table school_list
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
-- Class SchoolSemester as table school_semester
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
-- Class Schoolday as table schoolday
--
CREATE TABLE "schoolday" (
    "id" bigserial PRIMARY KEY,
    "schoolday" timestamp without time zone NOT NULL,
    "schoolSemesterId" bigint NOT NULL
);

--
-- Class SchooldayEvent as table schoolday_event
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
-- Class Staff as table staff
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
-- Class SupportCategory as table support_category
--
CREATE TABLE "support_category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "parentCategory" bigint NOT NULL
);

--
-- Class SupportGoal as table support_category_goal
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
-- Class SupportCategoryStatus as table support_category_status
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
-- Class SupportGoalCheck as table support_goal_check
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
-- Class SupportGoalCheckFile as table support_goal_check_file
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
-- Class Workbook as table workbook
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
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AuthKey as table serverpod_auth_key
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
-- Class EmailAuth as table serverpod_email_auth
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
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
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
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
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
-- Class EmailReset as table serverpod_email_reset
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
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
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
-- Class UserInfo as table serverpod_user_info
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
-- Foreign relations for "book_tagging" table
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
-- Foreign relations for "competence_check" table
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
-- Foreign relations for "competence_check_file" table
--
ALTER TABLE ONLY "competence_check_file"
    ADD CONSTRAINT "competence_check_file_fk_0"
    FOREIGN KEY("competenceCheckId")
    REFERENCES "competence_check"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "competence_goal" table
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
-- Foreign relations for "competence_report" table
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
-- Foreign relations for "competence_report_check" table
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
-- Foreign relations for "library_book" table
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
-- Foreign relations for "missed_class" table
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
-- Foreign relations for "pupil_authorization" table
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
-- Foreign relations for "pupil_book_lending" table
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
-- Foreign relations for "pupil_book_lending_file" table
--
ALTER TABLE ONLY "pupil_book_lending_file"
    ADD CONSTRAINT "pupil_book_lending_file_fk_0"
    FOREIGN KEY("lendingId")
    REFERENCES "pupil_book_lending"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "pupil_list" table
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
-- Foreign relations for "pupil_workbook" table
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
-- Foreign relations for "schoolday" table
--
ALTER TABLE ONLY "schoolday"
    ADD CONSTRAINT "schoolday_fk_0"
    FOREIGN KEY("schoolSemesterId")
    REFERENCES "school_semester"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "schoolday_event" table
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
-- Foreign relations for "staff" table
--
ALTER TABLE ONLY "staff"
    ADD CONSTRAINT "staff_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "support_category_goal" table
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
-- Foreign relations for "support_category_status" table
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
-- Foreign relations for "support_goal_check" table
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
-- Foreign relations for "support_goal_check_file" table
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
-- Foreign relations for "workbook" table
--
ALTER TABLE ONLY "workbook"
    ADD CONSTRAINT "workbook_fk_0"
    FOREIGN KEY("_pupilDataWorkbooksPupilDataId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
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
