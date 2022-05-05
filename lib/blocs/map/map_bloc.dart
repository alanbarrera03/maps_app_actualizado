import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app_actualizado/blocs/blocs.dart';
import 'package:maps_app_actualizado/helpers/helpers.dart';
import 'package:maps_app_actualizado/models/models.dart';
import 'package:maps_app_actualizado/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>((event, emit) => (_onStartFollowingUser));

    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);

    on<OnToggleUserRouter>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    on<DisplayPolylinesEvent>((event, emit) => emit(
        state.copyWith(polylines: event.polylines, markers: event.markers)));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnowLocation == null) return;
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);

    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRouterPolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.point,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    // final starMarker = await getAssetImageMarker();
    // final endMarkers = await getNetworkImagemarker();

    final starMarker = await getStartCustomMarker(tripDuration, 'Mi Ubicación');
    final endMarkers =
        await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    final startMarker = Marker(
      anchor: const Offset(0.01, 1),
      markerId: const MarkerId('start'),
      position: destination.point.first,
      icon: starMarker,
      // infoWindow: InfoWindow(
      //     title: 'Inicio', snippet: 'Kms: $kms, duration: $tripDuration')
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.point.last,
      icon: endMarkers,
      // infoWindow: InfoWindow(
      //     title: destination.endPlace.text,
      //     snippet: destination.endPlace.placeName)
    );

    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(DisplayPolylinesEvent(curretPolylines, currentMarkers));

    // await Future.delayed(const Duration(milliseconds: 300));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
