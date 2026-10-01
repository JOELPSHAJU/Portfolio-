import 'suite.dart';
import 'dining_venue.dart';
import 'spa_treatment.dart';
import 'concierge_privilege.dart';
import 'accolade.dart';
import 'booking.dart';
import 'navigation_item.dart';

class HotelPageData {
  final List<Suite> suites;
  final List<DiningVenue> diningVenues;
  final List<SpaTreatment> spaTreatments;
  final List<ConciergePrivilege> conciergePrivileges;
  final List<Accolade> accolades;
  final BookingInfo booking;
  final List<NavigationItem> navigationItems;

  const HotelPageData({
    required this.suites,
    required this.diningVenues,
    required this.spaTreatments,
    required this.conciergePrivileges,
    required this.accolades,
    required this.booking,
    required this.navigationItems,
  });
}
