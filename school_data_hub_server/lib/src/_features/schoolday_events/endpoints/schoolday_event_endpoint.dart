import 'dart:async';

import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/_features/schoolday_events/helpers/schoolday_event_notification_helper.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('SchooldayEventEndpoint');

class SchooldayEventEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SchooldayEvent>> fetchSchooldayEvents(Session session) async {
    return SchooldayEvent.db.find(session,
        include: SchooldayEvent.include(
          schoolday: Schoolday.include(),
          document: HubDocument.include(),
          processedDocument: HubDocument.include(),
        ));
  }

  Future<SchooldayEvent> createSchooldayEvent(Session session,
      {required int pupilId,
      required String pupilNameAndGroup,
      required String dateAsString,
      required int schooldayId,
      required SchooldayEventType type,
      required String reason,
      required String createdBy,
      required String eventTime,
      required String tutor}) async {
    final eventId = Uuid().v4();

    final schooldayEvent = SchooldayEvent(
      eventId: eventId,
      pupilId: pupilId,
      schooldayId: schooldayId,
      eventType: type,
      eventReason: reason,
      createdBy: createdBy,
      eventTime: eventTime,
      processed: false,
    );

    final eventInDatabase = await session.db.insertRow(schooldayEvent);
    final eventWithSchoolday = await SchooldayEvent.db.findById(
      session,
      eventInDatabase.id!,
      include: SchooldayEvent.include(
        schoolday: Schoolday.include(),
        document: HubDocument.include(),
        processedDocument: HubDocument.include(),
      ),
    );
    unawaited(
      SchooldayEventNotificationHelper.sendNotification(
        session: session,
        pupilNameAndGroup: pupilNameAndGroup,
        tutor: tutor,
        eventWithSchoolday: eventWithSchoolday!,
        dateAsString: dateAsString,
      ),
    );
    return eventWithSchoolday;
  }

  Future<SchooldayEvent> updateSchooldayEvent(
    Session session,
    SchooldayEvent schooldayEvent,
    bool changedProcessedStatus,
    String pupilNameAndGroup,
    String tutor,
    String modifiedBy,
    String dateTimeAsString,
  ) async {
    // If processed is false We need to detach and delete the processed document if it exists
    if (changedProcessedStatus && schooldayEvent.processed == false) {
      if (schooldayEvent.processedDocumentId != null) {
        final file = await HubDocument.db
            .findById(session, schooldayEvent.processedDocumentId!);
        // Delete the file if it exists

        if (file != null) {
          final filePath = file.documentPath!;
          await SchooldayEvent.db.detachRow
              .processedDocument(session, schooldayEvent);
          schooldayEvent.processedDocumentId = null;
          // delete the file with the file path from storage
          await session.storage
              .deleteFile(storageId: 'private', path: filePath);

          await session.db.deleteRow(file);
        }
      }
    }

    await session.db.updateRow(schooldayEvent);
    final updatedSchooldayEventInDatabase =
        await SchooldayEvent.db.findById(session, schooldayEvent.id!,
            include: SchooldayEvent.include(
              schoolday: Schoolday.include(),
              document: HubDocument.include(),
              processedDocument: HubDocument.include(),
            ));

    if (changedProcessedStatus) {
      unawaited(SchooldayEventNotificationHelper.sendNotification(
        session: session,
        pupilNameAndGroup: pupilNameAndGroup,
        tutor: tutor,
        eventWithSchoolday: updatedSchooldayEventInDatabase!,
        dateAsString: dateTimeAsString,
        changedProcessedStatus: changedProcessedStatus,
      ));
    }
    return updatedSchooldayEventInDatabase!;
  }

  Future<bool> deleteSchooldayEvent(
      Session session, int schooldayEventId) async {
    final schooldayEvent = await SchooldayEvent.db.findById(
      session,
      schooldayEventId,
    );
    if (schooldayEvent == null) {
      throw Exception('Schoolday event not found');
    }
    if (schooldayEvent.documentId != null) {
      final file =
          await HubDocument.db.findById(session, schooldayEvent.documentId!);
      // Delete the file if it exists

      if (file != null) {
        // delete the file with the file path from storage
        await session.storage
            .deleteFile(storageId: 'private', path: file.documentPath!);
        await SchooldayEvent.db.detachRow.document(session, schooldayEvent);
        await session.db.deleteRow(file);
      }
    }
    if (schooldayEvent.processedDocumentId != null) {
      final hubDocument = await HubDocument.db
          .findById(session, schooldayEvent.processedDocumentId!);
      // Delete the file if it exists

      if (hubDocument != null) {
        // delete the file with the file path from storage
        await session.storage
            .deleteFile(storageId: 'private', path: hubDocument.documentPath!);
        await SchooldayEvent.db.detachRow
            .processedDocument(session, schooldayEvent);
        await session.db.deleteRow(hubDocument);
      }
    }
    await session.db.deleteRow(schooldayEvent);
    return true;
  }

  Future<SchooldayEvent> updateSchooldayEventFile(
      Session session,
      int schooldayEventId,
      String filePath,
      String createdBy,
      bool isprocessed) async {
    // find the schoolday event by id
    final schooldayEvent = await SchooldayEvent.db.findById(
      session,
      schooldayEventId,
      include: SchooldayEvent.include(
        document: HubDocument.include(),
      ),
    );
    if (schooldayEvent == null) {
      throw Exception('Schoolday event not found');
    }

    // Create a HubDocument with the file path
    final documentId = Uuid().v4();
    final hubDocument = HubDocument(
      documentId: documentId,
      documentPath: filePath,
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    // Let's create a transaction for the database operations
    // This is important to ensure that all operations are atomic
    await session.db.transaction((transaction) async {
      // Save the hub document object to the database
      final hubDocumentInDatabase = await HubDocument.db
          .insertRow(session, hubDocument, transaction: transaction);
      switch (isprocessed) {
        case true:
          // attach the processed file to the event
          // if the pupil had a processed file, delete it
          if (schooldayEvent.processedDocument != null) {
            _log.warning(
                'Deleting old schoolday event processed document: ${schooldayEvent.processedDocument!.documentId}');
            // delete the old processed file from the storage
            session.storage.deleteFile(
                storageId: 'private',
                path: schooldayEvent.processedDocument!.documentPath!);
            // detach the old file from the schoolday event
            await SchooldayEvent.db.detachRow.processedDocument(
                session, schooldayEvent,
                transaction: transaction);
            // delete the old hub document from the database
            await HubDocument.db.deleteRow(
                session, schooldayEvent.processedDocument!,
                transaction: transaction);
            // TODO: Consider exceptions and handle them gracefully here
          }
          // update the schoolday event with the new file
          _log.info(
              'Updating schoolday event document: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');
          // pupil.avatar = hubDocument;
          await SchooldayEvent.db.attachRow.processedDocument(
              session, schooldayEvent, hubDocumentInDatabase,
              transaction: transaction);
          break;
        case false:
          // attach the file to the event
          // if the pupil had a file, delete it
          if (schooldayEvent.document != null) {
            _log.warning(
                'Deleting old schoolday event document: ${schooldayEvent.document!.documentId}');
            // delete the old file from the storage
            session.storage.deleteFile(
                storageId: 'private',
                path: schooldayEvent.document!.documentPath!);
            // detach the old file from the schoolday event
            await SchooldayEvent.db.detachRow
                .document(session, schooldayEvent, transaction: transaction);
            // delete the old hub document from the database
            await HubDocument.db.deleteRow(session, schooldayEvent.document!,
                transaction: transaction);
            // TODO: Consider exceptions and handle them gracefully here
          }
          // update the schoolday event with the new file
          _log.info(
              'Updating schoolday event document: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');
          // pupil.avatar = hubDocument;
          await SchooldayEvent.db.attachRow.document(
              session, schooldayEvent, hubDocumentInDatabase,
              transaction: transaction);
          break;
      }
    });

    final updatedEvent =
        await SchooldayEvent.db.findById(session, schooldayEvent.id!,
            include: SchooldayEvent.include(
              document: HubDocument.include(),
              processedDocument: HubDocument.include(),
              schoolday: Schoolday.include(),
            ));

    _log.fine('Updated event : ${updatedEvent!.toJson()}');
    return updatedEvent;
  }

  Future<SchooldayEvent> deleteSchooldayEventFile(
      Session session, int schooldayEventId, bool isProcessed) async {
    await session.db.transaction((transaction) async {
      final schooldayEvent = await SchooldayEvent.db.findById(
        session,
        schooldayEventId,
        include: SchooldayEvent.include(
          document: HubDocument.include(),
          processedDocument: HubDocument.include(),
        ),
        transaction: transaction,
      );

      if (schooldayEvent == null) {
        throw Exception('Schoolday event not found');
      }

      switch (isProcessed) {
        case true:
          final filePath = schooldayEvent.processedDocument!.documentPath!;
          if (schooldayEvent.processedDocumentId != null) {
            await SchooldayEvent.db.detachRow.processedDocument(
                session, schooldayEvent,
                transaction: transaction);

            await HubDocument.db.deleteRow(
                session, schooldayEvent.processedDocument!,
                transaction: transaction);
            schooldayEvent.processedDocumentId = null;
            await session.storage
                .deleteFile(storageId: 'private', path: filePath);
          }
          break;
        case false:
          final filePath = schooldayEvent.document!.documentPath!;
          if (schooldayEvent.documentId != null) {
            await SchooldayEvent.db.detachRow
                .document(session, schooldayEvent, transaction: transaction);
            await HubDocument.db.deleteRow(session, schooldayEvent.document!,
                transaction: transaction);
            schooldayEvent.documentId = null;
            await session.storage
                .deleteFile(storageId: 'private', path: filePath);
          }
      }

      await SchooldayEvent.db
          .updateRow(session, schooldayEvent, transaction: transaction);
    });
    final updatedSchooldayEvent = await SchooldayEvent.db.findById(
      session,
      schooldayEventId,
      include: SchooldayEvent.include(
        document: HubDocument.include(),
        processedDocument: HubDocument.include(),
        schoolday: Schoolday.include(),
      ),
    );
    if (updatedSchooldayEvent == null) {
      throw Exception('Schoolday event not found');
    }
    return updatedSchooldayEvent;
  }
}
