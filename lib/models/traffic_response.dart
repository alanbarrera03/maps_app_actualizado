// To parse this JSON data, do
//
//     final trafficResponse = trafficResponseFromMap(jsonString);

import 'dart:convert';

class TrafficResponse {
  TrafficResponse({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  final List<Route> routes;
  final List<Waypoint> waypoints;
  final String code;
  final String uuid;

  factory TrafficResponse.fromJson(String str) =>
      TrafficResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrafficResponse.fromMap(Map<String, dynamic> json) => TrafficResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromMap(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toMap() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toMap())),
        "code": code,
        "uuid": uuid,
      };
}

class Route {
  Route({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  final String weightName;
  final double weight;
  final double duration;
  final double distance;
  final List<Leg> legs;
  final String geometry;

  factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Route.fromMap(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        geometry: json["geometry"],
      );

  Map<String, dynamic> toMap() => {
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toMap())),
        "geometry": geometry,
      };
}

class Leg {
  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  final List<dynamic> viaWaypoints;
  final List<Admin> admins;
  final double weight;
  final double duration;
  final List<Step> steps;
  final double distance;
  final String summary;

  factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromMap(x))),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toMap() => {
        "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
        "admins": List<dynamic>.from(admins.map((x) => x.toMap())),
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x.toMap())),
        "distance": distance,
        "summary": summary,
      };
}

class Admin {
  Admin({
    required this.iso31661Alpha3,
    required this.iso31661,
  });

  final String iso31661Alpha3;
  final String iso31661;

  factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
      };
}

class Step {
  Step({
    required this.intersections,
    required this.maneuver,
    required this.name,
    required this.duration,
    required this.distance,
    required this.drivingSide,
    required this.weight,
    required this.mode,
    required this.geometry,
  });

  final List<Intersection> intersections;
  final Maneuver maneuver;
  final String name;
  final double duration;
  final double distance;
  final DrivingSide? drivingSide;
  final double weight;
  final Mode? mode;
  final String geometry;

  factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Step.fromMap(Map<String, dynamic> json) => Step(
        intersections: List<Intersection>.from(
            json["intersections"].map((x) => Intersection.fromMap(x))),
        maneuver: Maneuver.fromMap(json["maneuver"]),
        name: json["name"],
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        drivingSide: drivingSideValues.map[json["driving_side"]],
        weight: json["weight"].toDouble(),
        mode: modeValues.map[json["mode"]],
        geometry: json["geometry"],
      );

  Map<String, dynamic> toMap() => {
        "intersections":
            List<dynamic>.from(intersections.map((x) => x.toMap())),
        "maneuver": maneuver.toMap(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSideValues.reverse[drivingSide],
        "weight": weight,
        "mode": modeValues.reverse[mode],
        "geometry": geometry,
      };
}

enum DrivingSide { RIGHT, LEFT, SLIGHT_LEFT }

final drivingSideValues = EnumValuesTraffic({
  "left": DrivingSide.LEFT,
  "right": DrivingSide.RIGHT,
  "slight left": DrivingSide.SLIGHT_LEFT
});

class Intersection {
  Intersection({
    required this.bearings,
    required this.entry,
    required this.mapboxStreetsV8,
    required this.isUrban,
    required this.adminIndex,
    required this.out,
    required this.geometryIndex,
    required this.location,
    required this.intersectionIn,
    required this.duration,
    required this.turnWeight,
    required this.turnDuration,
    required this.weight,
    required this.trafficSignal,
  });

  final List<int> bearings;
  final List<bool> entry;
  final MapboxStreetsV8? mapboxStreetsV8;
  final bool? isUrban;
  final int adminIndex;
  final int? out;
  final int geometryIndex;
  final List<double> location;
  final int? intersectionIn;
  final double? duration;
  final double? turnWeight;
  final double? turnDuration;
  final double? weight;
  final bool? trafficSignal;

  factory Intersection.fromJson(String str) =>
      Intersection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Intersection.fromMap(Map<String, dynamic> json) => Intersection(
        bearings: List<int>.from(json["bearings"].map((x) => x)),
        entry: List<bool>.from(json["entry"].map((x) => x)),
        mapboxStreetsV8: json["mapbox_streets_v8"] == null
            ? null
            : MapboxStreetsV8.fromMap(json["mapbox_streets_v8"]),
        isUrban: json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"],
        geometryIndex: json["geometry_index"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        intersectionIn: json["in"],
        duration: json["duration"],
        turnWeight: json["turn_weight"],
        turnDuration: json["turn_duration"],
        weight: json["weight"],
        trafficSignal: json["traffic_signal"],
      );

  Map<String, dynamic> toMap() => {
        "bearings": List<dynamic>.from(bearings.map((x) => x)),
        "entry": List<dynamic>.from(entry.map((x) => x)),
        "mapbox_streets_v8": mapboxStreetsV8,
        "is_urban": isUrban,
        "admin_index": adminIndex,
        "out": out,
        "geometry_index": geometryIndex,
        "location": List<dynamic>.from(location.map((x) => x)),
        "in": intersectionIn,
        "duration": duration,
        "turn_weight": turnWeight,
        "turn_duration": turnDuration,
        "weight": weight,
        "traffic_signal": trafficSignal,
      };
}

class MapboxStreetsV8 {
  MapboxStreetsV8({
    required this.mapboxStreetsV8Class,
  });

  final Class? mapboxStreetsV8Class;

  factory MapboxStreetsV8.fromJson(String str) =>
      MapboxStreetsV8.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MapboxStreetsV8.fromMap(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]],
      );

  Map<String, dynamic> toMap() => {
        "class": classValues.reverse[mapboxStreetsV8Class],
      };
}

enum Class { STREET, SECONDARY, SERVICE, TERTIARY }

final classValues = EnumValuesTraffic({
  "secondary": Class.SECONDARY,
  "service": Class.SERVICE,
  "street": Class.STREET,
  "tertiary": Class.TERTIARY
});

class Maneuver {
  Maneuver({
    required this.type,
    required this.instruction,
    required this.bearingAfter,
    required this.bearingBefore,
    required this.location,
    required this.modifier,
  });

  final Type? type;
  final String instruction;
  final int bearingAfter;
  final int bearingBefore;
  final List<double> location;
  final DrivingSide? modifier;

  factory Maneuver.fromJson(String str) => Maneuver.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Maneuver.fromMap(Map<String, dynamic> json) => Maneuver(
        type: typeValues.map[json["type"]],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        modifier: json["modifier"] == null
            ? null
            : drivingSideValues.map[json["modifier"]],
      );

  Map<String, dynamic> toMap() => {
        "type": typeValues.reverse[type],
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": List<dynamic>.from(location.map((x) => x)),
        "modifier":
            modifier == null ? null : drivingSideValues.reverse[modifier],
      };
}

enum Type { DEPART, TURN, END_OF_ROAD, ARRIVE }

final typeValues = EnumValuesTraffic({
  "arrive": Type.ARRIVE,
  "depart": Type.DEPART,
  "end of road": Type.END_OF_ROAD,
  "turn": Type.TURN
});

enum Mode { DRIVING }

final modeValues = EnumValuesTraffic({"driving": Mode.DRIVING});

class Waypoint {
  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  final double distance;
  final String name;
  final List<double> location;

  factory Waypoint.fromJson(String str) => Waypoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Waypoint.fromMap(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}

class EnumValuesTraffic<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValuesTraffic(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
