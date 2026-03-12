import 'dart:async';

import 'package:school_data_hub_server/src/_features/schoolday_events/helpers/schoolday_event_notification_helper.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

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
    session.messages.postMessage('hub_events_stream', eventWithSchoolday);
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
    await session.db.transaction((transaction) async {
      // If processed is false we need to detach and delete the processed document if it exists
      if (changedProcessedStatus && schooldayEvent.processed == false) {
        if (schooldayEvent.processedDocumentId != null) {
          final file = await HubDocument.db.findById(
              session, schooldayEvent.processedDocumentId!,
              transaction: transaction);

          if (file != null) {
            final filePath = file.documentPath!;
            await SchooldayEvent.db.detachRow.processedDocument(
                session, schooldayEvent,
                transaction: transaction);
            schooldayEvent.processedDocumentId = null;
            await session.storage
                .deleteFile(storageId: 'private', path: filePath);
            await HubDocument.db
                .deleteRow(session, file, transaction: transaction);
          }
        }
      }

      await SchooldayEvent.db
          .updateRow(session, schooldayEvent, transaction: transaction);
    });
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
    session.messages
        .postMessage('hub_events_stream', updatedSchooldayEventInDatabase!);
    return updatedSchooldayEventInDatabase;
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
    await session.db.transaction((transaction) async {
      if (schooldayEvent.documentId != null) {
        final file = await HubDocument.db.findById(
            session, schooldayEvent.documentId!,
            transaction: transaction);

        if (file != null) {
          await session.storage
              .deleteFile(storageId: 'private', path: file.documentPath!);
          await SchooldayEvent.db.detachRow
              .document(session, schooldayEvent, transaction: transaction);
          await HubDocument.db
              .deleteRow(session, file, transaction: transaction);
        }
      }
      if (schooldayEvent.processedDocumentId != null) {
        final hubDocument = await HubDocument.db.findById(
            session, schooldayEvent.processedDocumentId!,
            transaction: transaction);

        if (hubDocument != null) {
          await session.storage.deleteFile(
              storageId: 'private', path: hubDocument.documentPath!);
          await SchooldayEvent.db.detachRow.processedDocument(
              session, schooldayEvent,
              transaction: transaction);
          await HubDocument.db
              .deleteRow(session, hubDocument, transaction: transaction);
        }
      }
      await SchooldayEvent.db
          .deleteRow(session, schooldayEvent, transaction: transaction);
    });
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        objectType: HubObjectType.schooldayEvent,
        id: schooldayEventId,
      ),
    );
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
            session.log(
                'Deleting old schoolday event processed document: ${schooldayEvent.processedDocument!.documentId}',
                level: LogLevel.warning);
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
          }
          // update the schoolday event with the new file
          session.log(
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
            session.log(
                'Deleting old schoolday event document: ${schooldayEvent.document!.documentId}',
                level: LogLevel.warning);
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
          }
          // update the schoolday event with the new file
          session.log(
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

    session.log('Updated event : ${updatedEvent!.toJson()}', level: LogLevel.debug);
    session.messages.postMessage('hub_events_stream', updatedEvent);
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
    session.messages.postMessage('hub_events_stream', updatedSchooldayEvent);
    return updatedSchooldayEvent;
  }
}
