BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "authorization" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
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
    "readingLevel" text,
    "imagePath" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_id_unique_idx" ON "book" USING btree ("isbn");

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
    "checkId" text NOT NULL,
    "score" bigint NOT NULL,
    "comment" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "valueFactor" double precision NOT NULL,
    "groupCheckId" text,
    "groupCheckName" text,
    "pupilId" bigint NOT NULL,
    "competenceId" bigint NOT NULL
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
    "score" bigint,
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
CREATE TABLE "competence_report_item" (
    "id" bigserial PRIMARY KEY,
    "publicId" bigint NOT NULL,
    "parentItem" bigint,
    "name" text NOT NULL,
    "level" json,
    "order" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "compulsory_room" (
    "id" bigserial PRIMARY KEY,
    "roomId" text NOT NULL,
    "roomType" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "credit_transaction" (
    "id" bigserial PRIMARY KEY,
    "sender" text NOT NULL,
    "receiver" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "dateTime" timestamp without time zone NOT NULL,
    "description" text,
    "_pupilDataCredittransactionsPupilDataId" bigint
);

-- Indexes
CREATE INDEX "reciever_idx" ON "credit_transaction" USING btree ("receiver");
CREATE INDEX "sender_idx" ON "credit_transaction" USING btree ("sender");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hub_document" (
    "id" bigserial PRIMARY KEY,
    "documentId" text NOT NULL,
    "documentPath" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "_pupilBookLendingPupilbooklendingfilesPupilBookLendingId" bigint,
    "_competenceCheckDocumentsCompetenceCheckId" bigint,
    "_competenceGoalDocumentsCompetenceGoalId" bigint,
    "_supportCategoryStatusDocumentsSupportCategoryStatusId" bigint,
    "_supportGoalCheckDocumentsSupportGoalCheckId" bigint,
    "_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId" bigint,
    "_preSchoolTestPreschooltestdocumentsPreSchoolTestId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "kindergarden" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "phone" text NOT NULL,
    "address" text NOT NULL,
    "email" text NOT NULL,
    "contactPerson" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "last_pupil_identities_update" (
    "id" bigserial PRIMARY KEY,
    "date" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "learning_support_plan" (
    "id" bigserial PRIMARY KEY,
    "planId" text NOT NULL,
    "createdBy" text NOT NULL,
    "learningSupportLevelId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "comment" text,
    "pupilId" bigint NOT NULL,
    "schoolSemesterId" bigint NOT NULL
);

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
CREATE TABLE "lesson_group" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "name" text NOT NULL,
    "color" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text NOT NULL,
    "modifiedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson_group_pupil" (
    "id" bigserial PRIMARY KEY,
    "lessonGroupId" bigint NOT NULL,
    "pupilDataId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "lesson_group_membership_index_idx" ON "lesson_group_pupil" USING btree ("lessonGroupId", "pupilDataId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson_subject" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "library_book" (
    "id" bigserial PRIMARY KEY,
    "libraryId" text NOT NULL,
    "bookId" bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "available" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "library_id_unique_idx" ON "library_book" USING btree ("libraryId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "library_book_location" (
    "id" bigserial PRIMARY KEY,
    "location" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "location_unique_idx" ON "library_book_location" USING btree ("location");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "missed_class" (
    "id" bigserial PRIMARY KEY,
    "missedType" text NOT NULL,
    "unexcused" boolean NOT NULL,
    "contacted" text NOT NULL,
    "returned" boolean NOT NULL,
    "returnedAt" timestamp without time zone,
    "writtenExcuse" boolean NOT NULL,
    "minutesLate" bigint,
    "createdBy" text NOT NULL,
    "modifiedBy" text,
    "comment" text,
    "schooldayId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "schoolday_pupil_data_idx" ON "missed_class" USING btree ("schooldayId", "pupilId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pre_school_medical" (
    "id" bigserial PRIMARY KEY,
    "preschoolMedicalStatus" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedBy" text,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pre_school_test" (
    "id" bigserial PRIMARY KEY,
    "careNeedsIntensity" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_authorization" (
    "id" bigserial PRIMARY KEY,
    "status" boolean,
    "comment" text,
    "createdBy" text,
    "fileId" bigint,
    "authorizationId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_book_lending" (
    "id" bigserial PRIMARY KEY,
    "lendingId" text NOT NULL,
    "status" text,
    "score" bigint NOT NULL,
    "lentAt" timestamp without time zone NOT NULL,
    "lentBy" text NOT NULL,
    "returnedAt" timestamp without time zone,
    "receivedBy" text,
    "pupilId" bigint NOT NULL,
    "isbn" bigint NOT NULL,
    "libraryBookId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_data" (
    "id" bigserial PRIMARY KEY,
    "status" text NOT NULL,
    "internalId" bigint NOT NULL,
    "preSchoolMedicalId" bigint,
    "kindergardenId" bigint,
    "kindergardenData" json,
    "preSchoolTestId" bigint,
    "avatarId" bigint,
    "avatarAuthId" bigint,
    "publicMediaAuth" json NOT NULL,
    "publicMediaAuthDocumentId" bigint,
    "contact" text,
    "communicationPupil" json,
    "specialInformation" text,
    "tutorInfo" json,
    "afterSchoolCare" json,
    "credit" bigint NOT NULL,
    "creditEarned" bigint NOT NULL,
    "schoolyearHeldBackAt" timestamp without time zone,
    "swimmer" text,
    "_kindergardenPupilsKindergardenId" bigint
);

-- Indexes
CREATE INDEX "pupil_data_status_idx" ON "pupil_data" USING btree ("status", "internalId");
CREATE UNIQUE INDEX "pupil_data_internal_id_idx" ON "pupil_data" USING btree ("internalId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pupil_list_entry" (
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
    "isbn" bigint NOT NULL,
    "comment" text,
    "score" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "finishedAt" timestamp without time zone,
    "pupilId" bigint NOT NULL,
    "workbookId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room" (
    "id" bigserial PRIMARY KEY,
    "roomCode" text NOT NULL,
    "roomName" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "scheduled_lesson" (
    "id" bigserial PRIMARY KEY,
    "active" boolean NOT NULL,
    "publicId" text NOT NULL,
    "subjectId" bigint NOT NULL,
    "scheduledAtId" bigint NOT NULL,
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
CREATE TABLE "school_data" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "officialName" text NOT NULL,
    "address" text NOT NULL,
    "schoolNumber" text NOT NULL,
    "telephoneNumber" text NOT NULL,
    "email" text NOT NULL,
    "website" text NOT NULL,
    "logoId" bigint,
    "officialSealId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "school_list" (
    "id" bigserial PRIMARY KEY,
    "listId" text NOT NULL,
    "archived" boolean NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "createdBy" text NOT NULL,
    "public" boolean NOT NULL,
    "authorizedUsers" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "school_semester" (
    "id" bigserial PRIMARY KEY,
    "schoolYear" text NOT NULL,
    "isFirst" boolean NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "classConferenceDate" timestamp without time zone,
    "supportConferenceDate" timestamp without time zone,
    "reportConferenceDate" timestamp without time zone,
    "reportSignedDate" timestamp without time zone
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
    "processedBy" text,
    "processedAt" timestamp without time zone,
    "documentId" bigint,
    "processedDocumentId" bigint,
    "schooldayId" bigint NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subject" (
    "id" bigserial PRIMARY KEY,
    "publicId" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "color" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "modifiedBy" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "parentCategory" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_category_goal" (
    "id" bigserial PRIMARY KEY,
    "goalId" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "score" bigint NOT NULL,
    "achievedAt" timestamp without time zone,
    "description" text NOT NULL,
    "strategies" text NOT NULL,
    "pupilId" bigint NOT NULL,
    "supportCategoryId" bigint NOT NULL,
    "_learningSupportPlanSupportgoalsLearningSupportPlanId" bigint,
    "_supportCategoryCategorygoalsSupportCategoryId" bigint,
    "_pupilDataSupportgoalsPupilDataId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_category_status" (
    "id" bigserial PRIMARY KEY,
    "score" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "comment" text NOT NULL,
    "pupilId" bigint NOT NULL,
    "supportCategoryId" bigint NOT NULL,
    "learningSupportPlanId" bigint NOT NULL,
    "_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId" bigint,
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
    "score" bigint NOT NULL,
    "comment" text NOT NULL,
    "supportGoalId" bigint NOT NULL,
    "_supportCategoryGoalGoalchecksSupportCategoryGoalId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "support_level" (
    "id" bigserial PRIMARY KEY,
    "level" bigint NOT NULL,
    "comment" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "createdBy" text NOT NULL,
    "pupilId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "timetable_slot" (
    "id" bigserial PRIMARY KEY,
    "day" text,
    "startTime" text,
    "endTime" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "userInfoId" bigint NOT NULL,
    "role" text NOT NULL,
    "timeUnits" bigint NOT NULL,
    "reliefTimeUnits" bigint NOT NULL,
    "pupilsAuth" json,
    "credit" bigint NOT NULL,
    "userFlags" json NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_info_id_unique_idx" ON "user" USING btree ("userInfoId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_device" (
    "id" bigserial PRIMARY KEY,
    "userInfoId" bigint NOT NULL,
    "deviceId" text NOT NULL,
    "deviceName" text NOT NULL,
    "lastLogin" timestamp without time zone NOT NULL,
    "isActive" boolean NOT NULL,
    "authId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "auth_key_user_device_idx" ON "user_device" USING btree ("authId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workbook" (
    "id" bigserial PRIMARY KEY,
    "isbn" bigint NOT NULL,
    "name" text NOT NULL,
    "subject" text,
    "level" text,
    "amount" bigint,
    "imageUrl" text NOT NULL
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
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
    REFERENCES "competence_report_item"("id")
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
ALTER TABLE ONLY "credit_transaction"
    ADD CONSTRAINT "credit_transaction_fk_0"
    FOREIGN KEY("_pupilDataCredittransactionsPupilDataId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_0"
    FOREIGN KEY("_pupilBookLendingPupilbooklendingfilesPupilBookLendingId")
    REFERENCES "pupil_book_lending"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_1"
    FOREIGN KEY("_competenceCheckDocumentsCompetenceCheckId")
    REFERENCES "competence_check"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_2"
    FOREIGN KEY("_competenceGoalDocumentsCompetenceGoalId")
    REFERENCES "competence_goal"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_3"
    FOREIGN KEY("_supportCategoryStatusDocumentsSupportCategoryStatusId")
    REFERENCES "support_category_status"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_4"
    FOREIGN KEY("_supportGoalCheckDocumentsSupportGoalCheckId")
    REFERENCES "support_goal_check"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_5"
    FOREIGN KEY("_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId")
    REFERENCES "pre_school_medical"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hub_document"
    ADD CONSTRAINT "hub_document_fk_6"
    FOREIGN KEY("_preSchoolTestPreschooltestdocumentsPreSchoolTestId")
    REFERENCES "pre_school_test"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "learning_support_plan"
    ADD CONSTRAINT "learning_support_plan_fk_0"
    FOREIGN KEY("learningSupportLevelId")
    REFERENCES "support_level"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "learning_support_plan"
    ADD CONSTRAINT "learning_support_plan_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "learning_support_plan"
    ADD CONSTRAINT "learning_support_plan_fk_2"
    FOREIGN KEY("schoolSemesterId")
    REFERENCES "school_semester"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "lesson"
    ADD CONSTRAINT "lesson_fk_0"
    FOREIGN KEY("subjectId")
    REFERENCES "lesson_subject"("id")
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
ALTER TABLE ONLY "lesson_group_pupil"
    ADD CONSTRAINT "lesson_group_pupil_fk_0"
    FOREIGN KEY("lessonGroupId")
    REFERENCES "lesson_group"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "lesson_group_pupil"
    ADD CONSTRAINT "lesson_group_pupil_fk_1"
    FOREIGN KEY("pupilDataId")
    REFERENCES "pupil_data"("id")
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
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "missed_class"
    ADD CONSTRAINT "missed_class_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_authorization"
    ADD CONSTRAINT "pupil_authorization_fk_0"
    FOREIGN KEY("fileId")
    REFERENCES "hub_document"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_authorization"
    ADD CONSTRAINT "pupil_authorization_fk_1"
    FOREIGN KEY("authorizationId")
    REFERENCES "authorization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_authorization"
    ADD CONSTRAINT "pupil_authorization_fk_2"
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
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_0"
    FOREIGN KEY("preSchoolMedicalId")
    REFERENCES "pre_school_medical"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_1"
    FOREIGN KEY("kindergardenId")
    REFERENCES "kindergarden"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_2"
    FOREIGN KEY("preSchoolTestId")
    REFERENCES "pre_school_test"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_3"
    FOREIGN KEY("avatarId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_4"
    FOREIGN KEY("avatarAuthId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_5"
    FOREIGN KEY("publicMediaAuthDocumentId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_data"
    ADD CONSTRAINT "pupil_data_fk_6"
    FOREIGN KEY("_kindergardenPupilsKindergardenId")
    REFERENCES "kindergarden"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pupil_list_entry"
    ADD CONSTRAINT "pupil_list_entry_fk_0"
    FOREIGN KEY("schoolListId")
    REFERENCES "school_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pupil_list_entry"
    ADD CONSTRAINT "pupil_list_entry_fk_1"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE CASCADE
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
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_3"
    FOREIGN KEY("lessonGroupId")
    REFERENCES "lesson_group"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_lesson"
    ADD CONSTRAINT "scheduled_lesson_fk_4"
    FOREIGN KEY("_roomScheduledlessonsRoomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "school_data"
    ADD CONSTRAINT "school_data_fk_0"
    FOREIGN KEY("logoId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "school_data"
    ADD CONSTRAINT "school_data_fk_1"
    FOREIGN KEY("officialSealId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
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
    FOREIGN KEY("documentId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "schoolday_event"
    ADD CONSTRAINT "schoolday_event_fk_1"
    FOREIGN KEY("processedDocumentId")
    REFERENCES "hub_document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "schoolday_event"
    ADD CONSTRAINT "schoolday_event_fk_2"
    FOREIGN KEY("schooldayId")
    REFERENCES "schoolday"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "schoolday_event"
    ADD CONSTRAINT "schoolday_event_fk_3"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
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
    FOREIGN KEY("_learningSupportPlanSupportgoalsLearningSupportPlanId")
    REFERENCES "learning_support_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_goal"
    ADD CONSTRAINT "support_category_goal_fk_3"
    FOREIGN KEY("_supportCategoryCategorygoalsSupportCategoryId")
    REFERENCES "support_category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_goal"
    ADD CONSTRAINT "support_category_goal_fk_4"
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
    FOREIGN KEY("learningSupportPlanId")
    REFERENCES "learning_support_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_3"
    FOREIGN KEY("_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId")
    REFERENCES "learning_support_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_4"
    FOREIGN KEY("_supportCategoryCategorystatuesSupportCategoryId")
    REFERENCES "support_category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "support_category_status"
    ADD CONSTRAINT "support_category_status_fk_5"
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
ALTER TABLE ONLY "support_level"
    ADD CONSTRAINT "support_level_fk_0"
    FOREIGN KEY("pupilId")
    REFERENCES "pupil_data"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user"
    ADD CONSTRAINT "user_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_device"
    ADD CONSTRAINT "user_device_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_device"
    ADD CONSTRAINT "user_device_fk_1"
    FOREIGN KEY("authId")
    REFERENCES "serverpod_auth_key"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
    VALUES ('school_data_hub', '20250826124122807', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250826124122807', "timestamp" = now();

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
