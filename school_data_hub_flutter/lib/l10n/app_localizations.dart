import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @schoolDataHub.
  ///
  /// In de, this message translates to:
  /// **'Schuldaten App'**
  String get schoolDataHub;

  /// No description provided for @userName.
  ///
  /// In de, this message translates to:
  /// **'Benutzername'**
  String get userName;

  /// No description provided for @password.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// No description provided for @logInButtonText.
  ///
  /// In de, this message translates to:
  /// **'EINLOGGEN'**
  String get logInButtonText;

  /// No description provided for @deleteKeyPrompt.
  ///
  /// In de, this message translates to:
  /// **'Schulschlüssel löschen?'**
  String get deleteKeyPrompt;

  /// No description provided for @areYouSureYouWantToDeleteSchoolKey.
  ///
  /// In de, this message translates to:
  /// **'Sind Sie sicher, dass Sie den Schulschlüssel löschen möchten?'**
  String get areYouSureYouWantToDeleteSchoolKey;

  /// No description provided for @deleteKeyButtonText.
  ///
  /// In de, this message translates to:
  /// **'SCHULSCHLÜSSEL LÖSCHEN'**
  String get deleteKeyButtonText;

  /// No description provided for @importSchoolDataToContinue.
  ///
  /// In de, this message translates to:
  /// **'Schul-ID importieren, um fortfahren zu können.'**
  String get importSchoolDataToContinue;

  /// No description provided for @scanSchoolIdToContinue.
  ///
  /// In de, this message translates to:
  /// **'Schul-ID scannen, um fortfahren zu können.'**
  String get scanSchoolIdToContinue;

  /// No description provided for @chooseFileButton.
  ///
  /// In de, this message translates to:
  /// **'DATEI AUSWÄHLEN'**
  String get chooseFileButton;

  /// No description provided for @scanButton.
  ///
  /// In de, this message translates to:
  /// **'SCANNEN'**
  String get scanButton;

  /// No description provided for @scanSchoolId.
  ///
  /// In de, this message translates to:
  /// **'Schul-Id scannen'**
  String get scanSchoolId;

  /// No description provided for @schoolIdImportSuccess.
  ///
  /// In de, this message translates to:
  /// **'Schul-Id erfolgreich importiert!'**
  String get schoolIdImportSuccess;

  /// No description provided for @scanAborted.
  ///
  /// In de, this message translates to:
  /// **'Scanvorgang abgebrochen'**
  String get scanAborted;

  /// No description provided for @scanAccessCode.
  ///
  /// In de, this message translates to:
  /// **'Zugangscode scannen'**
  String get scanAccessCode;

  /// No description provided for @session.
  ///
  /// In de, this message translates to:
  /// **'Session'**
  String get session;

  /// No description provided for @pupilLists.
  ///
  /// In de, this message translates to:
  /// **'Kinderlisten'**
  String get pupilLists;

  /// No description provided for @schoolLists.
  ///
  /// In de, this message translates to:
  /// **'Schullisten'**
  String get schoolLists;

  /// No description provided for @learningLists.
  ///
  /// In de, this message translates to:
  /// **'Lernlisten'**
  String get learningLists;

  /// No description provided for @scanTools.
  ///
  /// In de, this message translates to:
  /// **'Scan-Tools'**
  String get scanTools;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @schooldayEvents.
  ///
  /// In de, this message translates to:
  /// **'Ereignisse'**
  String get schooldayEvents;

  /// No description provided for @missedSchooldays.
  ///
  /// In de, this message translates to:
  /// **'Fehlzeiten'**
  String get missedSchooldays;

  /// No description provided for @attendance.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheit'**
  String get attendance;

  /// No description provided for @pupilCredit.
  ///
  /// In de, this message translates to:
  /// **'Kinderkonten'**
  String get pupilCredit;

  /// No description provided for @supportLists.
  ///
  /// In de, this message translates to:
  /// **'Förderlisten'**
  String get supportLists;

  /// No description provided for @specialInfo.
  ///
  /// In de, this message translates to:
  /// **'Besondere Infos'**
  String get specialInfo;

  /// No description provided for @allDayCare.
  ///
  /// In de, this message translates to:
  /// **'OGS'**
  String get allDayCare;

  /// No description provided for @matrixRooms.
  ///
  /// In de, this message translates to:
  /// **'Matrix-Räume'**
  String get matrixRooms;

  /// No description provided for @learningresources.
  ///
  /// In de, this message translates to:
  /// **'Lernresourcen'**
  String get learningresources;

  /// No description provided for @competences.
  ///
  /// In de, this message translates to:
  /// **'Kompetenzen'**
  String get competences;

  /// No description provided for @supportCategories.
  ///
  /// In de, this message translates to:
  /// **'Förderkategorien'**
  String get supportCategories;

  /// No description provided for @workbooks.
  ///
  /// In de, this message translates to:
  /// **'Arbeitshefte'**
  String get workbooks;

  /// No description provided for @books.
  ///
  /// In de, this message translates to:
  /// **'Bücher'**
  String get books;

  /// No description provided for @selectPupils.
  ///
  /// In de, this message translates to:
  /// **'Kind/Kinder auswählen'**
  String get selectPupils;

  /// No description provided for @shown.
  ///
  /// In de, this message translates to:
  /// **'Angezeigt:'**
  String get shown;

  /// No description provided for @selected.
  ///
  /// In de, this message translates to:
  /// **'Ausgewählt:'**
  String get selected;

  /// No description provided for @checkLists.
  ///
  /// In de, this message translates to:
  /// **'Eintragelisten'**
  String get checkLists;

  /// No description provided for @lists.
  ///
  /// In de, this message translates to:
  /// **'Eintragelisten'**
  String get lists;

  /// No description provided for @authorizations.
  ///
  /// In de, this message translates to:
  /// **'Nachweis-Listen'**
  String get authorizations;

  /// No description provided for @noResults.
  ///
  /// In de, this message translates to:
  /// **'keine Ergebnisse'**
  String get noResults;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
