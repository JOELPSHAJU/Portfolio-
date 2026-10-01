import '../../domain/entities/booking.dart';

class BookingModel extends BookingInfo {
  const BookingModel({
    required super.checkIn,
    required super.checkInSubtitle,
    required super.checkOut,
    required super.checkOutSubtitle,
    required super.guests,
    required super.guestsSubtitle,
    required super.tier,
    required super.tierSubtitle,
    required super.datesCompact,
    required super.datesSubtitleCompact,
    required super.guestsCompact,
    required super.guestsSubtitleCompact,
    required super.privilegeInclusions,
    required super.sampleDates,
    required super.sampleSummary,
    required super.samplePrice,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      checkIn: json['checkIn'] as String,
      checkInSubtitle: json['checkInSubtitle'] as String,
      checkOut: json['checkOut'] as String,
      checkOutSubtitle: json['checkOutSubtitle'] as String,
      guests: json['guests'] as String,
      guestsSubtitle: json['guestsSubtitle'] as String,
      tier: json['tier'] as String,
      tierSubtitle: json['tierSubtitle'] as String,
      datesCompact: json['datesCompact'] as String,
      datesSubtitleCompact: json['datesSubtitleCompact'] as String,
      guestsCompact: json['guestsCompact'] as String,
      guestsSubtitleCompact: json['guestsSubtitleCompact'] as String,
      privilegeInclusions: (json['privilegeInclusions'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      sampleDates: json['sampleDates'] as String,
      sampleSummary: json['sampleSummary'] as String,
      samplePrice: json['samplePrice'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkIn': checkIn,
      'checkInSubtitle': checkInSubtitle,
      'checkOut': checkOut,
      'checkOutSubtitle': checkOutSubtitle,
      'guests': guests,
      'guestsSubtitle': guestsSubtitle,
      'tier': tier,
      'tierSubtitle': tierSubtitle,
      'datesCompact': datesCompact,
      'datesSubtitleCompact': datesSubtitleCompact,
      'guestsCompact': guestsCompact,
      'guestsSubtitleCompact': guestsSubtitleCompact,
      'privilegeInclusions': privilegeInclusions,
      'sampleDates': sampleDates,
      'sampleSummary': sampleSummary,
      'samplePrice': samplePrice,
    };
  }

  BookingInfo toEntity() => this;
}
