// enum SchooldayEventType {
//   notSet('choose'),
//   parentsMeeting('Eg'),
//   admonition('rk'),
//   afternoonCareAdmonition('rkogs'),
//   admonitionAndBanned('rkabh'),
//   otherEvent('other');

//   final String value;
//   const SchooldayEventType(this.value);
// }

// enum SchooldayEventReason {
//   violenceAgainstPupils('gm'),
//   violenceAgainstTeachers('gl'),
//   violenceAgainstThings('gs'),
//   insultOthers('ab'),
//   dangerousBehaviour('gv'),
//   annoyOthers('äa'),
//   ignoreInstructions('il'),
//   disturbLesson('us'),
//   other('ss'),
//   learningDevelopmentInfo('le'),
//   learningSupportInfo('fi'),
//   admonitionInfo('ki');

//   final String value;
//   const SchooldayEventReason(this.value);
// }

enum SchooldayEventFilter {
  sevenDays,
  admonition,
  afternoonCareAdmonition,
  admonitionAndBanned,
  parentsMeeting,
  otherEvent,
  violenceAgainstThings,
  violenceAgainstPupils,
  violenceAgainstAdults,
  dangerousBehaviour,
  insultOthers,
  annoy,
  ignoreInstructions,
  disturbLesson,
  other,
  learningDevelopmentInfo,
  learningSupportInfo,
  admonitionInfo,
  processed,
}

Map<SchooldayEventFilter, bool> initialSchooldayEventFilterValues = {
  SchooldayEventFilter.sevenDays: false,
  SchooldayEventFilter.admonition: false,
  SchooldayEventFilter.afternoonCareAdmonition: false,
  SchooldayEventFilter.admonitionAndBanned: false,
  SchooldayEventFilter.parentsMeeting: false,
  SchooldayEventFilter.otherEvent: false,
  SchooldayEventFilter.violenceAgainstThings: false,
  SchooldayEventFilter.violenceAgainstPupils: false,
  SchooldayEventFilter.violenceAgainstAdults: false,
  SchooldayEventFilter.dangerousBehaviour: false,
  SchooldayEventFilter.insultOthers: false,
  SchooldayEventFilter.annoy: false,
  SchooldayEventFilter.ignoreInstructions: false,
  SchooldayEventFilter.disturbLesson: false,
  SchooldayEventFilter.other: false,
  SchooldayEventFilter.learningDevelopmentInfo: false,
  SchooldayEventFilter.learningSupportInfo: false,
  SchooldayEventFilter.admonitionInfo: false,
  SchooldayEventFilter.processed: false,
};
