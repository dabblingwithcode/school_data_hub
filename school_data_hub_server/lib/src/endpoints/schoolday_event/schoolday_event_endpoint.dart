import 'package:logging/logging.dart';
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
          file: HubDocument.include(),
          processedFile: HubDocument.include(),
        ));
  }

  Future<SchooldayEvent> createSchooldayEvent(Session session,
      {required int pupilId,
      required int schooldayId,
      required SchooldayEventType type,
      required String reason,
      required String createdBy}) async {
    final eventId = Uuid().v4();

    final schooldayEvent = SchooldayEvent(
      eventId: eventId,
      pupilId: pupilId,
      schooldayId: schooldayId,
      eventType: type,
      eventReason: reason,
      createdBy: createdBy,
      processed: false,
    );

    final eventInDatabase = await session.db.insertRow(schooldayEvent);
    final eventWithSchoolday = await SchooldayEvent.db.findById(
      session,
      eventInDatabase.id!,
      include: SchooldayEvent.include(
        schoolday: Schoolday.include(),
        file: HubDocument.include(),
        processedFile: HubDocument.include(),
      ),
    );
    return eventWithSchoolday!;
  }

  Future<SchooldayEvent> updateSchooldayEvent(
      Session session, SchooldayEvent schooldayEvent) async {
    await session.db.updateRow(schooldayEvent);
    final updatedSchooldayEvent =
        await SchooldayEvent.db.findById(session, schooldayEvent.id!,
            include: SchooldayEvent.include(
              schoolday: Schoolday.include(),
              file: HubDocument.include(),
              processedFile: HubDocument.include(),
            ));
    return updatedSchooldayEvent!;
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
    if (schooldayEvent.fileId != null) {
      final file =
          await HubDocument.db.findById(session, schooldayEvent.fileId!);
      // Delete the file if it exists

      if (file != null) {
        // delete the file with the file path from storage
        await session.storage
            .deleteFile(storageId: 'private', path: file.documentPath!);
        await SchooldayEvent.db.detachRow.file(session, schooldayEvent);
        await session.db.deleteRow(file);
      }
    }
    if (schooldayEvent.processedFileId != null) {
      final hubDocument = await HubDocument.db
          .findById(session, schooldayEvent.processedFileId!);
      // Delete the file if it exists

      if (hubDocument != null) {
        // delete the file with the file path from storage
        await session.storage
            .deleteFile(storageId: 'private', path: hubDocument.documentPath!);
        await SchooldayEvent.db.detachRow
            .processedFile(session, schooldayEvent);
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
        file: HubDocument.include(),
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
          if (schooldayEvent.processedFile != null) {
            _log.warning(
                'Deleting old schoolday event processed file: ${schooldayEvent.processedFile!.documentId}');
            // delete the old processed file from the storage
            session.storage.deleteFile(
                storageId: 'private',
                path: schooldayEvent.processedFile!.documentPath!);
            // detach the old file from the schoolday event
            await SchooldayEvent.db.detachRow.processedFile(
                session, schooldayEvent,
                transaction: transaction);
            // delete the old hub document from the database
            await HubDocument.db.deleteRow(
                session, schooldayEvent.processedFile!,
                transaction: transaction);
            // TODO: Consider exceptions and handle them gracefully here
          }
          // update the schoolday event with the new file
          _log.info(
              'Updating schoolday event file: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');
          // pupil.avatar = hubDocument;
          await SchooldayEvent.db.attachRow.processedFile(
              session, schooldayEvent, hubDocumentInDatabase,
              transaction: transaction);
          break;
        case false:
          // attach the file to the event
          // if the pupil had a file, delete it
          if (schooldayEvent.file != null) {
            _log.warning(
                'Deleting old schoolday event file: ${schooldayEvent.file!.documentId}');
            // delete the old file from the storage
            session.storage.deleteFile(
                storageId: 'private', path: schooldayEvent.file!.documentPath!);
            // detach the old file from the schoolday event
            await SchooldayEvent.db.detachRow
                .file(session, schooldayEvent, transaction: transaction);
            // delete the old hub document from the database
            await HubDocument.db.deleteRow(session, schooldayEvent.file!,
                transaction: transaction);
            // TODO: Consider exceptions and handle them gracefully here
          }
          // update the schoolday event with the new file
          _log.info(
              'Updating schoolday event file: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');
          // pupil.avatar = hubDocument;
          await SchooldayEvent.db.attachRow.file(
              session, schooldayEvent, hubDocumentInDatabase,
              transaction: transaction);
          break;
      }
    });

    final updatedEvent =
        await SchooldayEvent.db.findById(session, schooldayEvent.id!,
            include: SchooldayEvent.include(
              file: HubDocument.include(),
              processedFile: HubDocument.include(),
              schoolday: Schoolday.include(),
            ));

    _log.fine('Updated event : ${updatedEvent!.toJson()}');
    return updatedEvent;
  }
}
