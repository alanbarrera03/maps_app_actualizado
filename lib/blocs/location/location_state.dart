part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLoction;
  final List<LatLng> myLocationHistory;

  const LocationState(
      {this.followingUser = false, this.lastKnowLoction, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith(
          {bool? followingUser,
          LatLng? lastKnowLoction,
          List<LatLng>? myLocationHistory}) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnowLoction: lastKnowLoction ?? this.lastKnowLoction,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
      );

  @override
  List<Object?> get props =>
      [followingUser, lastKnowLoction, myLocationHistory];
}
