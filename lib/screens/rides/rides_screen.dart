import 'package:flutter/material.dart';
 
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
 
import '../../utils/animations_util.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
 
  RidePreference get currentPreference  => RidePrefService.instance.currentPreference!;

  List<Ride> get matchingRides => RidesService.instance.getRidesFor(currentPreference, null);

  void onBackPressed() {
    Navigator.of(context).pop();     //  Back to the previous view
  } 

  onRidePrefSelected(RidePreference newPreference) async {}

  void onPreferencePressed() async {
// Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
            AnimationUtils.createTopToBottomRoute(RidePrefModal(initialPreference: currentPreference,)));
    
    if (newPreference != null) {
      // 1 - Update the current preference
      RidePrefService.instance.setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed),

          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchingRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}