// import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
// import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';

// class SchooldayEventFilterHelpers {
//   static List<SchooldayEvent> schooldayEventsInTheLastSevenDays(
//       PupilProxy pupil) {
//     DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
//     List<SchooldayEvent> schooldayEvents = [];
//     if (pupil.schooldayEvents != null) {
//       for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
//         if (schooldayEvent.schooldayEventDate.isBefore(sevenDaysAgo)) {
//           schooldayEvents.add(schooldayEvent);
//         }
//       }
//     }
//     return schooldayEvents;
//   }

//   static List<SchooldayEvent> schooldayEventsNotProcessed(PupilProxy pupil) {
//     List<SchooldayEvent> schooldayEvents = [];
//     if (pupil.schooldayEvents != null) {
//       for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
//         if (schooldayEvent.processedBy == null) {
//           schooldayEvents.add(schooldayEvent);
//         }
//       }
//     }
//     return schooldayEvents;
//   }

//   static List<SchooldayEvent> schooldayEventsInTheLastFourteenDays(
//       PupilProxy pupil) {
//     DateTime fourteenDaysAgo =
//         DateTime.now().subtract(const Duration(days: 14));
//     List<SchooldayEvent> schooldayEvents = [];
//     if (pupil.schooldayEvents != null) {
//       for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
//         if (schooldayEvent.schooldayEventDate.isBefore(fourteenDaysAgo)) {
//           schooldayEvents.add(schooldayEvent);
//         }
//       }
//     }
//     return schooldayEvents;
//   }
// }
