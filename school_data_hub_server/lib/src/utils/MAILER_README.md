# MailerService Singleton

A singleton service for sending emails in your Serverpod application.

## Features

- **Singleton Pattern**: Single instance across your application
- **Serverpod Integration**: Works seamlessly with Serverpod sessions
- **Configuration Management**: Uses Serverpod's password system for secure credential storage
- **Multiple Email Types**: Support for plain text, HTML, attachments, CC, BCC
- **Convenience Methods**: Pre-built methods for common email scenarios
- **Error Handling**: Comprehensive error handling with logging

## Setup

### 1. Add Email Configuration to passwords.yaml

Add your email configuration to `config/passwords.yaml`:

```yaml
shared:
  emailUsername: 'your-email@domain.com'
  emailPassword: 'your-app-password'
  emailSmtpHost: 'smtp-mail.outlook.com'
  emailSmtpPort: '587'
```

### 2. Initialize the Service

The service can be initialized in two ways:

#### Option A: From Session (Recommended)
```dart
MailerService.instance.initializeFromSession(session);
```

#### Option B: Manual Configuration
```dart
MailerService.instance.initialize(
  username: 'your-email@domain.com',
  password: 'your-password',
  smtpHost: 'smtp-mail.outlook.com',
  smtpPort: 587,
  fromName: 'Your App Name',
  defaultRecipient: 'admin@yourdomain.com',
);
```

## Usage Examples

### Basic Email
```dart
// In your endpoint
Future<bool> sendBasicEmail(Session session) async {
  MailerService.instance.initializeFromSession(session);
  
  return await MailerService.instance.sendEmail(
    subject: 'Test Email',
    body: 'This is a test email.',
    recipient: 'user@example.com',
  );
}
```

### Contact Form Email
```dart
Future<bool> handleContactForm(Session session, String message) async {
  MailerService.instance.initializeFromSession(session);
  
  return await MailerService.instance.sendContactEmail(
    subject: 'Contact Form Submission',
    body: message,
    senderEmail: 'user@example.com',
  );
}
```

### Notification Email
```dart
Future<bool> sendSystemAlert(Session session, String alert) async {
  MailerService.instance.initializeFromSession(session);
  
  return await MailerService.instance.sendNotification(
    subject: 'System Alert',
    message: alert,
  );
}
```

### Rich Email with HTML and Attachments
```dart
Future<bool> sendRichEmail(Session session) async {
  MailerService.instance.initializeFromSession(session);
  
  return await MailerService.instance.sendEmail(
    subject: 'Rich Email',
    body: 'Plain text version',
    htmlBody: '<h1>HTML Version</h1><p>Rich content here</p>',
    recipient: 'user@example.com',
    ccRecipients: ['cc@example.com'],
    bccRecipients: ['bcc@example.com'],
    attachments: [FileAttachment(File('path/to/file.pdf'))],
  );
}
```

## API Reference

### sendEmail()
Main method for sending emails with full customization options.

**Parameters:**
- `subject` (required): Email subject
- `body` (required): Plain text email body
- `recipient` (optional): Recipient email (uses default if not provided)
- `htmlBody` (optional): HTML version of the email
- `ccRecipients` (optional): List of CC recipients
- `bccRecipients` (optional): List of BCC recipients
- `attachments` (optional): List of email attachments

**Returns:** `Future<bool>` - true if email sent successfully, false otherwise

### sendContactEmail()
Convenience method for contact form emails.

**Parameters:**
- `subject` (required): Email subject
- `body` (required): Email body
- `senderEmail` (optional): Sender's email address

### sendNotification()
Convenience method for system notifications.

**Parameters:**
- `subject` (required): Notification subject
- `message` (required): Notification message

## Error Handling

The service includes comprehensive error handling:

- **MailerException**: Caught and logged, returns false
- **General Exceptions**: Caught and logged, returns false
- **Configuration Errors**: Will throw if service not properly initialized

## Security Notes

- All email configuration (credentials, SMTP host, and port) are stored in `passwords.yaml` which should not be committed to version control
- The service uses secure SMTP connections (port 587 with TLS by default)
- Consider using app-specific passwords for email accounts with 2FA enabled
- SMTP host and port are now configurable per environment for maximum flexibility

## Dependencies

Make sure you have the `mailer` package in your `pubspec.yaml`:

```yaml
dependencies:
  mailer: ^6.0.1
```
