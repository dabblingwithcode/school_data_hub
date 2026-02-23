import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart'
    show SessionLogEntry, LogEntry, QueryLogEntry;

import '../../../generated/protocol.dart';

class AdminLogsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  Future<HubSessionLogResult> getSessionLogs(
    Session session,
    HubSessionLogFilter filter,
  ) async {
    final sessionLogEntries = await SessionLogEntry.db.find(
      session,
      where: (t) {
        Expression where = Constant.bool(true);

        if (filter.endpoint != null) {
          where = where & t.endpoint.equals(filter.endpoint);
        }
        if (filter.method != null) {
          where = where & t.method.equals(filter.method);
        }
        if (filter.slow) {
          where = where & t.slow.equals(true);
        }
        if (filter.error) {
          where = where & t.error.notEquals(null);
        }
        if (filter.open) {
          where = where & t.isOpen.equals(true);
        }
        if (filter.lastSessionLogId != null) {
          where = where & (t.id < filter.lastSessionLogId);
        }

        return where;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: 100,
    );

    final List<HubSessionLogInfo> sessionLogInfoList = [];

    for (final entry in sessionLogEntries) {
      final logs = await LogEntry.db.find(
        session,
        where: (t) => t.sessionLogId.equals(entry.id!),
      );

      final queries = await QueryLogEntry.db.find(
        session,
        where: (t) => t.sessionLogId.equals(entry.id!),
      );

      sessionLogInfoList.add(
        HubSessionLogInfo(
          sessionLogEntry: HubSessionLogEntry(
            sessionId: entry.id!,
            serverId: entry.serverId,
            time: entry.time,
            endpoint: entry.endpoint,
            method: entry.method,
            duration: entry.duration,
            numQueries: entry.numQueries,
            slow: entry.slow,
            error: entry.error,
            stackTrace: entry.stackTrace,
            authenticatedUserId: entry.authenticatedUserId,
            isOpen: entry.isOpen,
          ),
          logs: logs
              .map(
                (l) => HubLogEntry(
                  logLevel: l.logLevel.index,
                  message: l.message,
                  error: l.error,
                  stackTrace: l.stackTrace,
                  time: l.time,
                  order: l.order,
                ),
              )
              .toList(),
          queries: queries
              .map(
                (q) => HubQueryLogEntry(
                  query: q.query,
                  duration: q.duration,
                  numRows: q.numRows,
                  error: q.error,
                  slow: q.slow,
                  order: q.order,
                ),
              )
              .toList(),
        ),
      );
    }

    return HubSessionLogResult(sessionLog: sessionLogInfoList);
  }

  Future<void> deleteSessionLog(
    Session session,
    int sessionLogId,
  ) async {
    // Delete associated log entries first
    await LogEntry.db.deleteWhere(
      session,
      where: (t) => t.sessionLogId.equals(sessionLogId),
    );

    // Delete associated query log entries
    await QueryLogEntry.db.deleteWhere(
      session,
      where: (t) => t.sessionLogId.equals(sessionLogId),
    );

    // Delete the session log entry itself
    await SessionLogEntry.db.deleteWhere(
      session,
      where: (t) => t.id.equals(sessionLogId),
    );
  }

  Future<void> deleteAllSessionLogs(Session session) async {
    // Delete all log entries
    await LogEntry.db.deleteWhere(
      session,
      where: (t) => Constant.bool(true),
    );

    // Delete all query log entries
    await QueryLogEntry.db.deleteWhere(
      session,
      where: (t) => Constant.bool(true),
    );

    // Delete all session log entries
    await SessionLogEntry.db.deleteWhere(
      session,
      where: (t) => Constant.bool(true),
    );
  }
}
