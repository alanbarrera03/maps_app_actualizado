import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app_actualizado/blocs/blocs.dart';
import 'package:maps_app_actualizado/delegates/delegates.dart';
import 'package:maps_app_actualizado/models/search_result.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : const _SearchBarBody();
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  void onSearchResult(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final destination = await searchBloc.getCoorsStartToEnd(
          locationBloc.state.lastKnowLocation!, result.position!);
      await mapBloc.drawRouterPolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());

            if (result == null) return;

            onSearchResult(context, result);
          },
          child: FadeInDown(
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: const Text('¿A dónde quieres ir?',
                  style: TextStyle(color: Colors.black87)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
