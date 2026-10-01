class BookingInfo {
  final String checkIn;
  final String checkInSubtitle;
  final String checkOut;
  final String checkOutSubtitle;
  final String guests;
  final String guestsSubtitle;
  final String tier;
  final String tierSubtitle;
  final String datesCompact;
  final String datesSubtitleCompact;
  final String guestsCompact;
  final String guestsSubtitleCompact;
  final List<String> privilegeInclusions;
  final String sampleDates;
  final String sampleSummary;
  final String samplePrice;

  const BookingInfo({
    required this.checkIn,
    required this.checkInSubtitle,
    required this.checkOut,
    required this.checkOutSubtitle,
    required this.guests,
    required this.guestsSubtitle,
    required this.tier,
    required this.tierSubtitle,
    required this.datesCompact,
    required this.datesSubtitleCompact,
    required this.guestsCompact,
    required this.guestsSubtitleCompact,
    required this.privilegeInclusions,
    required this.sampleDates,
    required this.sampleSummary,
    required this.samplePrice,
  });
}
