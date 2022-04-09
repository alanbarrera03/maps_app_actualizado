import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app_actualizado/blocs/blocs.dart';

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
    return Scaffold(body:
        BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state.lastKnowLoction == null) {
        return const Center(child: Text('Espere por favor...'));
      }

      final CameraPosition initialCameraPosition =
          CameraPosition(target: state.lastKnowLoction!, zoom: 15);

      return GoogleMap(initialCameraPosition: initialCameraPosition);
    }));
  }
}
