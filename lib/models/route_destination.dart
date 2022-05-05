import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app_actualizado/models/models.dart';

class RouteDestination {
  final List<LatLng> point;
  final double duration;
  final double distance;
  final Feature endPlace;

  RouteDestination(
      {required this.point,
      required this.duration,
      required this.distance,
      required this.endPlace});
}
