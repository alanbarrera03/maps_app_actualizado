import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app_actualizado/blocs/blocs.dart';
import 'package:maps_app_actualizado/views/views.dart';
import 'package:maps_app_actualizado/widgets/btn_toggle_user_route.dart';
import 'package:maps_app_actualizado/widgets/widgets.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
        if (locationState.lastKnowLocation == null) {
          return const Center(child: Text('Espere por favor...'));
        }

        return BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {
            Map<String, Polyline> polylines = Map.from(mapState.polylines);

            if (!mapState.showMyRoute) {
              polylines.removeWhere((key, value) => key == 'myRoute');
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  MapView(
                    initialLocation: locationState.lastKnowLocation!,
                    polylines: polylines.values.toSet(),
                    markers: mapState.markers.values.toSet(),
                  ),
                  const SearchBar(),
                  const ManualMarker()
                ],
              ),
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: const [
        BtnToggleUserRoute(),
        BtnFollowUser(),
        BtnCurrentLocation(),
      ]),
    );
  }
}
