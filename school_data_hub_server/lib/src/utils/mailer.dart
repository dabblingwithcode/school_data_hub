import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';

/// Singleton service for sending emails
class MailerService {
  static MailerService? _instance;
  static MailerService get instance {
    _instance ??= MailerService._internal();
    return _instance!;
  }

  MailerService._internal();
  final _logger = Logger('MailerService');
  late final String _username;
  late final String _password;
  late final String _smtpHost;
  late final int _smtpPort;
  late final String _fromName;
  late final String _defaultRecipient;

  /// Initialize the mailer service with configuration
  void initialize({
    required String username,
    required String password,
    required String smtpHost,
    required int smtpPort,
    required String fromName,
    required String defaultRecipient,
  }) {
    _username = username;
    _password = password;
    _smtpHost = smtpHost;
    _smtpPort = smtpPort;
    _fromName = fromName;
    _defaultRecipient = defaultRecipient;
  }

  /// Initialize from Serverpod session (recommended approach)
  void initializeFromSession(Session session) {
    final passwords = session.passwords;

    initialize(
      username: passwords['emailUsername'] ?? '',
      password: passwords['emailPassword'] ?? '',
      smtpHost: passwords['emailSmtpHost'] ?? '',
      smtpPort: int.tryParse(passwords['emailSmtpPort'] ?? '0') ?? 587,
      fromName: 'Schuldaten Benachrichtigungen',
      defaultRecipient: '',
    );
  }

  /// Send an email with the specified parameters
  Future<bool> sendEmail({
    required String subject,
    required String body,
    String? recipient,
    String? htmlBody,
    List<String>? ccRecipients,
    List<String>? bccRecipients,
    List<Attachment>? attachments,
  }) async {
    try {
      final smtpServer = SmtpServer(
        _smtpHost,
        port: _smtpPort,
        username: _username,
        password: _password,
      );

      final message = Message()
        ..from = Address(_username, _fromName)
        ..recipients.add(recipient ?? _defaultRecipient)
        ..subject = subject
        ..text = body;

      if (htmlBody != null) {
        message.html = htmlBody;
      }

      if (ccRecipients != null && ccRecipients.isNotEmpty) {
        message.ccRecipients.addAll(ccRecipients);
      }

      if (bccRecipients != null && bccRecipients.isNotEmpty) {
        message.bccRecipients.addAll(bccRecipients);
      }

      if (attachments != null && attachments.isNotEmpty) {
        message.attachments.addAll(attachments);
      }

      final sendReport = await send(message, smtpServer);
      _logger.info('Email sent successfully: ${sendReport.toString()}');
      return true;
    } on MailerException catch (e) {
      _logger.severe('Failed to send email: $e');
      return false;
    } catch (e) {
      _logger.severe('Unexpected error sending email: $e');
      return false;
    }
  }

  /// Send a contact form email (convenience method)
  Future<bool> sendContactEmail({
    required String subject,
    required String body,
    String? senderEmail,
  }) async {
    final emailBody =
        senderEmail != null ? 'From: $senderEmail\n\n$body' : body;

    return sendEmail(
      subject: 'Contact Form: $subject',
      body: emailBody,
    );
  }

  /// Send a notification email (convenience method)
  Future<bool> sendNotification({
    required String subject,
    required String message,
    required String recipient,
  }) async {
    return sendEmail(
      subject: 'Notification: $subject',
      body: message,
      recipient: recipient,
    );
  }
}
