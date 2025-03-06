///
/// This model describes options to filter a list of rides by some criteria.
///
class RideFilter {
  final bool onlyPets; // Optional criteria on pets

  const RideFilter({this.onlyPets = false});
}