import '../model/ride/ride.dart';
import '../model/ride/ride_filter.dart';
import '../model/ride_pref/ride_pref.dart';

abstract class RidesRepository {
  List<Ride> getRidesFor(RidePreference ridePreference, RideFilter? rideFilter);
}